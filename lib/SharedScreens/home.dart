
import 'package:flexiscan101/Patient/Auth/login.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff233a66),
      body:
          Center(
            child:
              Stack(
                children: [
                buildTextColumn(),
                Positioned(
                  top: 60,left: 0,right: 0,
                  child: Image(image: AssetImage('asset/images/HandsUp.gif',),
                      width: 500,
                      height: 500,
                    ),
                ),
                Positioned(
                  bottom: 400,
                  left: 10,
                  right: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:[
                        buildOptionContainer(
                          function: (){
                            submit(context , "p");
                          },
                          label: 'Patient',
                          icon: Icons.person,
                          borderColor: Color(0xffd7a859),
                          backgroundColor:Color(0xffd7a859),
                          containerColor: Color(0xffd7a859),
                        ),
                        SizedBox(width: 130),
                        buildOptionContainer(
                          function: (){
                            submit(context , "d");
                          },
                          label: 'Doctor',
                          icon: Icons.medical_services_rounded,
                          borderColor: Color(0xffd7a859),
                          backgroundColor:Color(0xffd7a859),
                          containerColor: Color(0xff233a66),
                        ),
                      ],
                    ),
                  ),
                ), 
                ],
              ),

          ),


    );
  }
 Widget buildOptionContainer({
  required VoidCallback function,
  required String label,
  required IconData icon,
  required Color borderColor,
  required Color backgroundColor,
  required Color containerColor,
}) {
  return Container(
    width: 126,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: containerColor,
    ),
    child: ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
          side: BorderSide(color: borderColor, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: Color(0xff233a66),
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    ),
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
                fontSize: 30,
            ),),
          Text('Select Your Role to Begin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),),
        ],
      ),
    );
  }


  void submit(BuildContext context , String userType){
    print(userType);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) =>  Login(userType: userType)
      ),
          (Route<dynamic >route)=> false,
    );
  }

}
