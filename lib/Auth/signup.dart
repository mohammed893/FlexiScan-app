// Auth/signup.dart

import 'package:flexiscan101/Components/custom/custom_button.dart';
import 'package:flexiscan101/Components/custom/custom_formfield.dart';
import 'package:flexiscan101/Components/custom/custom_optional_button.dart';
import 'package:flexiscan101/Components/custom/custom_toast.dart';
import 'package:flexiscan101/Auth/login.dart';
import 'package:flexiscan101/Auth/auth_cubit/cubit.dart';
import 'package:flexiscan101/Auth/auth_cubit/states.dart';
import 'package:flexiscan101/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/Patient/Cubit/states.dart';
import 'package:flexiscan101/Patient/home_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatefulWidget {
  final String userType;
  const Signup({super.key, required this.userType});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String userType;

  final formKey = GlobalKey<FormState>();

    final emailController = TextEditingController();

    final passwordController = TextEditingController();

    final nameController = TextEditingController();

    final phoneController = TextEditingController();

    final dateController = TextEditingController();

    @override
    void initState(){
      super.initState();
      userType = widget.userType;
    }

    @override
   Widget build(BuildContext context) {
    return MultiBlocProvider(
       providers: [
         BlocProvider(create: (context) =>FlexiCubit()),
         BlocProvider(create: (context)=>AuthCubit()),
       ],
       child: Scaffold(
         resizeToAvoidBottomInset: false,
         backgroundColor:const Color(0xffd7a859),
         body: BlocConsumer<AuthCubit, AuthStates>(
             listener: (context , state){
               if(state is AuthSignupSuccessState){
                 if(state.signupModel.message.isNotEmpty){
                   print("Message: ${state.signupModel.message}");
                   if (state.signupModel.token!= null){
                     print("Token: ${state.signupModel.token}");
                     Navigator.pushAndRemoveUntil(context,
                       MaterialPageRoute(builder: (context) =>  PatientHome(), ///////////////////////////// patient for testing 
                       ),
                           (Route<dynamic >route)=> false,
                     );
                   }
                   showToast(
                       msg: state.signupModel.message,
                       state: ToastStates.success);
                 }
                 else{
                   showToast(
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
                 const SizedBox( height: 50,),
                 buildTextColumn(),
                 const Spacer(),
                 Center(
                   child: Container(
                     decoration:const BoxDecoration(
                       borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(40),
                         topRight: Radius.circular(40),
                       ),
                       color:Color(0xff233a66),
                     ),
                     width: double.infinity,
                     height: MediaQuery.of(context).size.height * 0.68,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(
                           vertical: 30,
                           horizontal: 30,
                       ),
                       child: BlocBuilder<FlexiCubit,FlexiStates>(
                         builder: (context , state){
                           return SingleChildScrollView(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 buildTextFiledColum(cubit, context),
                                 const SizedBox(height: 35,),
                                 Center(
                                   child: buildButton(
                                       width: 380,
                                       function: (){
                                         if (formKey.currentState?.validate() ?? false) {
                                           authCubit.signup(
                                             name: nameController.text,
                                             email: emailController.text,
                                             password: passwordController.text,
                                             dateOfBirth: dateController.text,
                                             phoneNumber: phoneController.text,
                                             type: userType,
                                             gender: '',
                                             age: '',
                                             hospital: '',
                                             nationalID: '',
                                             verification: '',
                                             follow: false,
                                           );
                                         }
                                       },
                                       text: 'SIGN UP',
                                       textColor:const Color(0xff233a66),
                                       color:const Color(0xffffd691)),
                                 ),
                                 buildSignUpRow(context),
                               ],
                             ),
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

Widget buildTextFiledColum(FlexiCubit cubit, context){
     return  Form(
       key:formKey ,
       child: Column(
         children: [
           buildFormFiled(
             label: 'Name',
             controller: nameController,
             color:const Color(0xffffd691),
             validatorString: 'Please Enter Your Name',
           ),
           const SizedBox(height: 20,),
           buildFormFiled(
             label: 'Email Address',
             controller: emailController,
             color:const Color(0xffffd691),
             validatorString: 'Please Enter Your Email',
           ),
           const SizedBox(height: 20,),
           buildFormFiled(
               label: 'Password',
               controller: passwordController,
               obscure: cubit.isPassword,
               color: const Color(0xffffd691),
               iconColor:const Color(0xff233a66),
               suffix: cubit.suffix,
               validatorString: 'Please Enter Your Password',
               suffixPressed: (){
                 cubit.changePasswordVisibility();
               }
           ),
           const SizedBox(height: 20,),
           buildFormFiled(
               label: 'Phone Number',
               controller: phoneController,
               color: const Color(0xffffd691),
               validatorString: 'Please Enter Your Phone Number',
           ),
           const SizedBox(height: 20,),
           buildFormFiled(
             label: 'Date Of Birth',
             controller: dateController,
             color: const Color(0xffffd691),
             validatorString: 'Please Enter Your Date Of Birth',
             onTap:() async {
               DateTime? pickedDate = await showDatePicker(
                 context: context,
                 initialDate: DateTime.now(),
                 firstDate: DateTime(1940 , 12 , 12),
                 lastDate: DateTime.now(),
               );
               if (pickedDate != null) {
                 dateController.text =
                 "${pickedDate.year}-${pickedDate
                     .month}-${pickedDate.day}";
               }
             },

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
         style:const TextStyle(
           color: Colors.white,
           fontSize: 20,
         ),),
         const SizedBox(height: 15,),
         Row(
           children: [
             buildOptionButton(
                 text: tex1,
                 isSelected: isSelected1,
                 onTap: (){
                   cubit.selectMale();
                 }),
             const SizedBox(width: 16),
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
         const  Text('You have an account?',
           style: TextStyle(
               color: Colors.white
           ),),
         TextButton(
           onPressed: (){
             Navigator.push(context,
               MaterialPageRoute(builder: (context)=>const Login(userType:'d' ,)),
             );
           },
            child: const Text('Log In'),
           style: TextButton.styleFrom(
             foregroundColor:const Color(0xffffd691),
           ),
         ),

       ],
     );
   }

Widget buildTextColumn(){
    return const Padding(
      padding:  EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sign-Up Now ",
            style: TextStyle(
              color: Color(0xff233a66),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(" To Have Unique Experience With Us",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
}
}

