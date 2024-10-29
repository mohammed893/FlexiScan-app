
import 'package:flutter/material.dart';

import '../Components/custom/custom_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff233a66),
      body: Center(
        child:
          Stack(
            children: [
              Image(image: NetworkImage('asset/images/userordoc.gif'),
                width: 800,
                height: 800,
              ),
            Positioned(
                bottom: 160,

              child: Row(
                children:[
                  buildOptionContainer(
                    function: (){},
                    label: 'Patient',
                    icon: Icons.person,
                    borderColor: Color(0xffd7a859),
                    backgroundColor:Color(0xffd7a859),
                    containerColor: Color(0xffd7a859),
                  ),
                  SizedBox(width: 400,),
                  buildOptionContainer(
                    function: (){},
                    label: 'Doctor',
                    icon: Icons.medical_services_rounded,
                    borderColor: Color(0xffd7a859),
                    backgroundColor:Color(0xffd7a859),
                    containerColor: Color(0xff233a66),
                  ),
                ],
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
    required borderColor,
    required backgroundColor,
    required containerColor,
}
){
    return Container(
      width: 200,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: containerColor,
      ),
      child: ElevatedButton(
        onPressed:function,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
            side: BorderSide(color:  borderColor , width: 3),
          ),
        ),
        child: Row(
          children: [
            //SizedBox(height: 30,),
            Icon(icon,
              size: 40,color: Color(0xff233a66)),
            SizedBox(width: 40,),
            Text(label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
          ],
        ),
      ),
    );
  }
}
