import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flexiscan101/Custom%20Modules/Online-Sessions/temp/components/log_sink.dart';
import 'package:flexiscan101/Custom%20Modules/Online-Sessions/temp/components/stats_monitoring_widget.dart';
import 'package:flexiscan101/Custom%20Modules/Online-Sessions/temp/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JoinChannelVideo extends StatefulWidget {
  const JoinChannelVideo({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  late final RtcEngine _engine;

  bool isJoined = false,
      switchCamera = true,
      switchRender = true,
      openCamera = true,
      muteCamera = false,
      muteAllRemoteVideo = false,
      muteMic = false;
      
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  bool _isUseFlutterTexture = false;
  bool _isUseAndroidSurfaceView = false;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;
  late final RtcEngineEventHandler _rtcEngineEventHandler;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }
  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: appId,
    ));
    _rtcEngineEventHandler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        logSink.log(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: token,
      channelId: _controller.text,
      uid: uid,
      options: ChannelMediaOptions(
        channelProfile: _channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      openCamera = true;
      muteCamera = false;
      muteAllRemoteVideo = false;
    });
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  _openCamera() async {
    await _engine.enableLocalVideo(!openCamera);
    setState(() {
      openCamera = !openCamera;
    });
  }

  _muteLocalVideoStream() async {
    await _engine.muteLocalVideoStream(!muteCamera);
    setState(() {
      muteCamera = !muteCamera;
    });
  }
  _muteMicrophone() async {
    await _engine.muteLocalAudioStream(!muteMic);
    setState(() {
      muteMic = !muteMic;
    });
  }

  _muteAllRemoteVideoStreams() async {
    await _engine.muteAllRemoteVideoStreams(!muteAllRemoteVideo);
    setState(() {
      muteAllRemoteVideo = !muteAllRemoteVideo;
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  body: Stack(
    children: [
      // Video View for the local user and remote users
      StatsMonitoringWidget(
        rtcEngine: _engine,
        uid: 0,
        child: AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _engine,
            canvas: const VideoCanvas(uid: 0),
            useFlutterTexture: _isUseFlutterTexture,
            useAndroidSurfaceView: _isUseAndroidSurfaceView,
          ),
          onAgoraVideoViewCreated: (viewId) {
            _engine.startPreview();
          },
        ),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.of(remoteUid.map(
              (e) => SizedBox(
                width: 200,
                height: 200,
                child: StatsMonitoringWidget(
                  rtcEngine: _engine,
                  uid: e,
                  channelId: _controller.text,
                  child: AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: _engine,
                      canvas: VideoCanvas(uid: e),
                      connection: RtcConnection(channelId: _controller.text),
                      useFlutterTexture: _isUseFlutterTexture,
                      useAndroidSurfaceView: _isUseAndroidSurfaceView,
                    ),
                  ),
                ),
              ),
            )),
          ),
        ),
      ),

      // Control Buttons at the bottom
      Positioned(
        bottom: 50, // Adjust as needed
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Mic Button
              IconButton(
                icon: Icon(muteMic ? Icons.mic_off : Icons.mic),
                onPressed: _muteMicrophone, // Toggle mic
                color: muteMic ? Colors.red : Colors.white,
                iconSize: 30,
              ),
              
              // Join Channel Button (when not joined)
              ElevatedButton(
                onPressed: isJoined ? null : _joinChannel, // Join if not already joined
                child: Text(isJoined ? 'Joined' : 'Join Channel'),
                style: ElevatedButton.styleFrom(
                  iconColor: isJoined ? Colors.green : Colors.blue, // Different color if joined
                ),
              ),
              
              // End Call Button (when joined)
              ElevatedButton(
                onPressed: isJoined ? _leaveChannel : null, // Leave if joined
                child: Text('End Call'),
                style: ElevatedButton.styleFrom(iconColor: Colors.red),
              ),
              
              // Switch Camera Button
              IconButton(
                icon: Icon(switchCamera ? Icons.camera_front : Icons.camera_rear),
                onPressed: _switchCamera, // Switch camera
                color: Colors.white,
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);  
  } }

// _engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
//                   dimensions: VideoDimensions(width: width, height: height),
//                   frameRate: frameRate,
//                   bitrate: bitrate,
//                 ));