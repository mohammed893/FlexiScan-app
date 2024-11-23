import 'dart:developer';
import 'package:flexiscan101/Online-Sessions/Call.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class OnlineSessionsIndex extends StatefulWidget {
  const OnlineSessionsIndex({super.key});

  @override
  State<OnlineSessionsIndex> createState() => _OnlineSessionsIndexState();
}

class _OnlineSessionsIndexState extends State<OnlineSessionsIndex> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  @override
  void dispose (){
    _channelController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Container(child: Image.asset(
                'asset/images/Patient.png' , 
                fit: BoxFit.fitWidth,
                ),
              height: 300,),
              const SizedBox(height: 20,),
              TextField(controller: _channelController,
              decoration: InputDecoration(
                errorText: _validateError ? 'channel name is mendatory': null,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
                hintText: 'Channel name'
              ),
              ),
              // RadioListTile(value: ClientRole.Broadcaster,
              // title: const Text('BroadCaster'),
              //  groupValue: _role,
              //   onChanged: (ClientRole? val){
              //     setState(() {
              //       _role = val;
              //     });
              //   }
              //   ),
              //   RadioListTile(value: ClientRole.Audience,
              // title: const Text('Audience'),
              //  groupValue: _role,
              //   onChanged: (ClientRole? val){
              //     setState(() {
              //       _role = val;
              //     });
              //   }
              //   ),
                ElevatedButton(onPressed: onJoin,
                 child: const Text('join'),
                style: ElevatedButton.styleFrom(minimumSize: const Size(
                  double.infinity , 40
                )
                ),
                )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> onJoin()async{
    setState(() {
      _channelController.text.isEmpty?
      _validateError = true :
       _validateError = false;
    });
    if(_channelController.text.isNotEmpty){
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      Navigator.push(context,
       MaterialPageRoute(
        builder: (context)=>CallPage(channelName: _channelController.text,
        )
        )
        );
    }
  }
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}