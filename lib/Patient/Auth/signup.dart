
import 'package:flexiscan101/Components/custom/custom_button.dart';
import 'package:flexiscan101/Components/custom/custom_formField.dart';
import 'package:flexiscan101/Components/custom/custom_optional_button.dart';
import 'package:flexiscan101/Components/custom/custom_toast.dart';
import 'package:flexiscan101/Patient/Auth/login.dart';
import 'package:flexiscan101/Patient/Cubit/auth_cubit/cubit.dart';
import 'package:flexiscan101/Patient/Cubit/auth_cubit/states.dart';
import 'package:flexiscan101/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/Patient/Cubit/states.dart';
import 'package:flexiscan101/SharedScreens/auth_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatelessWidget {
    Signup({super.key});

    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final genderController = TextEditingController();
    final nameController = TextEditingController();


  @override
   Widget build(BuildContext context) {
    return MultiBlocProvider(
       providers: [
         BlocProvider(create: (context) =>FlexiCubit()),
         BlocProvider(create: (context)=>AuthCubit()),
       ],
       child: Scaffold(
         backgroundColor: Color(0xffd7a859),
         body: BlocConsumer<AuthCubit, AuthStates>(
             listener: (context , state){
               if(state is AuthSignupSuccessState){
                 if(state.signupModel.message.isNotEmpty){
                   print("Message: ${state.signupModel.message}");
                   if (state.signupModel.token!= null){
                     print("Token: ${state.signupModel.token}");
                     Navigator.pushAndRemoveUntil(context,
                       MaterialPageRoute(builder: (context)=> AuthHome(),
                       ),
                           (Route<dynamic >route)=> false,
                     );
                   }
                   ShowToast(
                       msg: state.signupModel.message,
                       state: ToastStates.success);
                 }
                 else{
                   ShowToast(
                       msg: state.signupModel.message,
                       state: ToastStates.error);
                 }
               }
               else if (state is AuthSignupErrorState){
                 print("Signup failed");
               }
             },
           builder: (context , state){
             var cubit = FlexiCubit.get(context);
             var authCubit = AuthCubit.get(context);
             return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 buildTextColumn(),
                 SizedBox(height: 10,),
                 Center(
                   child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(40),
                         topRight: Radius.circular(40),
                       ),
                       color:Color(0xff233a66),
                     ),
                     width: double.infinity,
                     height: 491,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(
                           vertical: 30,
                           horizontal: 40
                       ),
                       child: BlocBuilder<FlexiCubit,FlexiStates>(
                         builder: (context , state){
                           return Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               buildTextFiledColum(cubit),
                               SizedBox(height: 10,),
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
                               SizedBox(height: 21,),
                               Center(
                                 child: buildButton(
                                     width: 380,
                                     function: (){
                                       if (formKey.currentState?.validate() ?? false) {
                                         authCubit.signup(
                                           name: nameController.text,
                                           email: emailController.text,
                                           password: passwordController.text,
                                           gender: genderController.text,
                                         );
                                       }
                                     },
                                     text: 'SIGN UP',
                                     textColor:Color(0xff233a66),
                                     color: Color(0xffffd691)),
                               ),
                               buildSignUpRow(context),
                             ],
                           );
                         },
                       ),
                     ),
                   ),
                 ),
               ],
             );
           },

         ),
       ),
     );
   }

Widget buildTextFiledColum(FlexiCubit cubit){
     return  Form(
       key:formKey ,
       child: Column(
         children: [
           buildFormFiled(
             label: 'Name',
             controller: nameController,
             color: Color(0xffffd691),
             validatorString: 'Please Enter Your Name',
           ),
           SizedBox(height: 15,),
           buildFormFiled(
             label: 'Email Address',
             controller: emailController,
             color: Color(0xffffd691),
             validatorString: 'Please Enter Your Email',
           ),
           SizedBox(height: 15,),
           buildFormFiled(
               label: 'Password',
               controller: passwordController,
               obscure: cubit.isPassword,
               color: Color(0xffffd691),
               iconColor: Color(0xff233a66),
               suffix: cubit.suffix,
               validatorString: 'Please Enter Your Password',
               suffixPressed: (){
                 cubit.changePasswordVisibility();
               }
           ),

         ],
       ),
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
         SizedBox(height: 15,),
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
       ]
     );
    }

Widget buildSignUpRow(context){
     return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Text('You have an account?',
           style: TextStyle(
               color: Colors.white
           ),),
         TextButton(
           onPressed: (){
             Navigator.push(context,
               MaterialPageRoute(builder: (context)=>Login(userType:'d' ,)),
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

Widget buildTextColumn(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );
}
}

