import 'dart:async';
import 'dart:io';
import 'package:flexiscan101/Online-Sessions/temp/join_channel_video/join_channel_video.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Session_Screen extends StatefulWidget {
  const Session_Screen({super.key});

  @override
  State<Session_Screen> createState() => _Session_ScreenState();
}

class _Session_ScreenState extends State<Session_Screen> {
  final Screen = JoinChannelVideo();
  bool _showPerformanceOverlay = false;
  void initState() {
    super.initState();
    _requestPermissionIfNeed();
  }
  Future<void> _requestPermissionIfNeed() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.audio, Permission.microphone, Permission.camera].request();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(showPerformanceOverlay: _showPerformanceOverlay,
    theme: ThemeData.light(),
    home: Scaffold(
      appBar: AppBar(
          title: const Text('Main Call Screen'),
        ),body: _body(),
    ),);
    
  }
  Widget _body(){
    return  JoinChannelVideo();
  }
  
}

// _configOverride.set(keyAppId, _appIdController.text);
//                       _configOverride.set(
//                           keyChannelId, _channelIdController.text);
//                       _configOverride.set(keyToken, _tokenController.text);

//                       widget.setupCompleted();