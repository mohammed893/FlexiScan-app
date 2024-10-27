
import 'package:flexiscan101/Components/custom/custom_appBar.dart';
import 'package:flexiscan101/Components/custom/custom_button.dart';
import 'package:flexiscan101/Components/custom/custom_formField.dart';
import 'package:flexiscan101/Components/custom/custom_optional_button.dart';
import 'package:flexiscan101/Patient/Auth/login.dart';
import 'package:flexiscan101/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/Patient/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatefulWidget {
    Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   @override
   Widget build(BuildContext context) {
     return BlocProvider(
       create: (BuildContext context)=>FlexiCubit(),
       child: BlocConsumer<FlexiCubit, FlexiStates>(
         listener: (context , state){},
         builder:(context , state){
           var cubit = FlexiCubit.get(context);
           return Scaffold(
             backgroundColor: Color(0xffd7a859),
             body: SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height: 30,),
                   Text("Sign-Up Now ",
                     style: TextStyle(
                       color: Color(0xff233a66),
                       fontSize: 30,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                   Text(" To Have Unique Experience With Us",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 20,
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 30),
                     child: Center(
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(40),
                             topRight: Radius.circular(40),
                           ),
                           color:Color(0xff233a66),
                         ),
                         width: double.infinity,
                         height: 485,
                         child: Padding(
                           padding: const EdgeInsets.symmetric(
                             vertical: 30,
                             horizontal: 40
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: 20,),
                               buildFormFiled(label: 'Name',
                               color: Color(0xffffd691),
                              ),
                               SizedBox(height: 20,),
               
                               buildTextFiledColum(cubit),
                               SizedBox(height: 20,),
                               buildOptionButtonRow(
                                 'Gender',
                                 'Male',
                                 'Female',
                                 cubit.isMaleSelected,
                                 cubit.isFemaleSelected,
                                 cubit.selectMale,
                                 cubit.selectFemale,
                                 cubit,
                               ),
                               SizedBox(height: 20,),
                               Center(
                                 child: buildButton(
                                     width: 380,
                                     function: (){},
                                     text: 'SIGN UP',
                                     textColor:Color(0xff233a66),
                                     color: Color(0xffffd691)),
                               ),
                               SizedBox(height: 10,),
                               buildSignUpRow(context),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           );
         } ,
       ),
     );
   }

Widget buildTextFiledColum(FlexiCubit cubit){
     return  Column(
       children: [
         buildFormFiled(
           label: 'Email Address',
           controller: emailController,
           obscure: false,
           color: Color(0xffffd691),
         ),
         SizedBox(height: 20,),
         buildFormFiled(
             label: 'Password',
             controller: passwordController,
             obscure: true,
             color: Color(0xffffd691),
             iconColor: Color(0xff233a66),
             suffix: cubit.suffix,
             suffixPressed: (){
               cubit.changePasswordVisibility();
             }
         ),
       ],
     );
   }


Widget buildOptionButtonRow(String label,
    String tex1,
    String tex2,
    isSelected1,
    isSelected2,
    VoidCallback onTap1,
    VoidCallback onTap2,
    FlexiCubit cubit ){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(label,
         style: TextStyle(
           color: Colors.white,
           fontSize: 20,
         ),),
         SizedBox(height: 10,),
         Row(
           children: [
             buildOptionButton(
                 text: tex1,
                 isSelected: isSelected1,
                 onTap: (){
                   cubit.selectMale();
                 }),
             SizedBox(width: 16),
             buildOptionButton(
               text: tex2,
               isSelected: isSelected2,
               onTap: () {
                cubit.selectFemale();
               },
             ),
           ],
         ),
       ],
            );
    }


Widget buildOptionalButtonColumn(FlexiCubit cubit){
     return Column(
       children: [
         buildOptionButtonRow(
           'Gender',
           'Male',
           'Female',
           cubit.isMaleSelected,
           cubit.isFemaleSelected,
           cubit.selectMale,
           cubit.selectFemale,
           cubit,
         ),
         SizedBox(height: 25,),
         buildOptionButtonRow(
             'Follow-up with doctor',
             'Yes',
             'No',
             cubit.isFollowYes,
             cubit.isFollowNo,
             cubit.followYes,
             cubit.followNo,
             cubit),

       ],
     );
}


Widget buildSignUpRow(context){
     return  Row(
       children: [
         Text('You have an account?',
           style: TextStyle(
               color: Colors.white
           ),),
         Spacer(),
         TextButton(
           onPressed: (){
             Navigator.push(context,
               MaterialPageRoute(builder: (context)=>Login()),
             );
           },
           child: Text('Log In'),
           style: TextButton.styleFrom(
             foregroundColor: Color(0xffffd691),
           ),
         ),

       ],
     );
   }

}

