import 'package:flexiscan101/Components/custom/custom_appBar.dart';
import 'package:flexiscan101/Components/custom/custom_button.dart';
import 'package:flexiscan101/Patient/Auth/login.dart';
import 'package:flutter/material.dart';

class AuthHome extends StatelessWidget {
  const AuthHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: Appbar(title: '',
        backGroundColor: Color(0xffd7a859) ,
      ),
      backgroundColor: Color(0xffd7a859),
      body: Column(
        children: [
          Image(image: NetworkImage('asset/images/Selected 2.gif'),
          height: screenHeight * 0.25,
            width: 400,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight:Radius.circular(40),
                topLeft:Radius.circular(40),
              ),
              color: Color(0xff233a66)
            ),
            width: 400,
            height: screenHeight * 0.65,
            child: Column(
             // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextColumn(),
                buildAuthColumn(context),
              ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildAuthColumn(context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(width: 280, function: (){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context)=>Login()),
                (Route<dynamic >route)=> false, );
        },
            text: "Patient",
            textColor: Colors.white,
            color:Color(0xffd7a859)),
        SizedBox(height: 30,),
        buildButton(width: 280, function: (){
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context)=>Login()),
                (Route<dynamic >route)=> false, );
        },
            text: "Doctor",
            textColor: Colors.white,
            color: Color(0xffd7a859)),
      ],
    );
  }

  Widget buildTextColumn(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Start Your Wellness Experience:',
            style: TextStyle(
              color: Color(0xffd7a859),
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
          Text('Select Your Role to Begin',
            style: TextStyle(
                color: Colors.white,
              fontSize: 20,
            ),),
          SizedBox(height: 90,),
        ],
      ),
    );
  }
}
