import 'package:flexiscan101/Components/custom/custom_appBar.dart';
import 'package:flexiscan101/Components/custom/custom_button.dart';
import 'package:flexiscan101/Components/custom/custom_formField.dart';
import 'package:flexiscan101/Patient/Auth/signup.dart';
import 'package:flexiscan101/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/Patient/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Login extends StatelessWidget {
   Login({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>FlexiCubit(),
      child: BlocConsumer<FlexiCubit , FlexiStates>(
        listener: (context , state){},
        builder: (context , state){
          var cubit = FlexiCubit.get(context);
          return  Scaffold(
            appBar: Appbar(title: 'LOGIN',
                backGroundColor:Color(0xffd7a859),
                textColor: Color(0xff233a66)),
            backgroundColor: Color(0xffd7a859),
            body: Padding(
              padding: const EdgeInsets.only(top: 160),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color:Color(0xff233a66),
                  ),
                  width: 300,
                  height: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('',
                          style: TextStyle(),),
                        buildTextFiledColum(cubit),
                        SizedBox(height: 10,),
                        TextButton(
                            onPressed: (){},
                            child: Text('Forget Password?',),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.grey,
                            )),
                        SizedBox(height: 30,),
                        buildButton(
                            width: 280,
                            function: (){},
                            text: 'LOGIN',
                            textColor: Color(0xff233a66),
                            color: Color(0xffffd691)),
                        SizedBox(height: 20,),
                        buildSignUpRow(context),
                      ],
                    ),
                  )
              ),
            ),
          );
        },

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
          prefix: Icons.email,
          iconColor: Color(0xff233a66),
        ),
        SizedBox(height: 30,),
        buildFormFiled(
            label: 'Password',
            controller: passwordController,
            obscure: true,
            color: Color(0xffffd691),
            prefix: Icons.lock ,
            iconColor: Color(0xff233a66),
            suffix: cubit.suffix,
            suffixPressed: (){
             cubit.changePasswordVisibility();
            }

        ),

      ],
    );
  }

  Widget buildSignUpRow(context){
    return  Row(
      children: [
        Text('You don\'t have an account?',
          style: TextStyle(
              color: Colors.white
          ),),
        Spacer(),
        TextButton(
          onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context)=>Signup()),
            );
          },
          child: Text('Sign Up'),
          style: TextButton.styleFrom(
            foregroundColor: Color(0xffffd691),
          ),
        ),

      ],
    );
  }

}
