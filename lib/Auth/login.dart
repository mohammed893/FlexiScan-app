import 'package:flexiscan101/Auth/auth_home.dart';
import 'package:flexiscan101/Components/custom/custom_button.dart';
import 'package:flexiscan101/Auth/signup.dart';
import 'package:flexiscan101/Auth/auth_cubit/cubit.dart';
import 'package:flexiscan101/Auth/auth_cubit/states.dart';
import 'package:flexiscan101/Doctor/doctor_home.dart';
import 'package:flexiscan101/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/Patient/Cubit/states.dart';
import 'package:flexiscan101/animation_module/cubit.dart';
import 'package:flexiscan101/animation_module/states.dart';
import 'package:flexiscan101/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Login extends StatefulWidget {
  final String userType;
  const Login({super.key , required this.userType});

  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late String userType;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationCubit animationCubit;
  var selectedOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationCubit = AnimationCubit(this, context); // Initialize without `this` and context
  }
 @override
  void initState() {
    super.initState();
    userType = widget.userType;  // Initialize with the passed value
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    animationCubit.dispose(); // Close the animationCubit properly
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => animationCubit),
        BlocProvider(create: (context) => FlexiCubit()),
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: Scaffold(resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffd7a859),
        body: BlocBuilder<AnimationCubit, AnimationStates>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 500),
                        bottom: animationCubit.currentState == "Flying" ? 300 : 0,
                        left: MediaQuery.of(context).size.width / 2 - 80,
                        child: ClipRect(
                          child: Image.asset(
                            animationCubit.currentGIF,
                             height: 250,
                            width: 180,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Color(0xff233a66),
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.52,
                  child: Column(
                    children: [
                      BlocBuilder<FlexiCubit, FlexiStates>(
                        builder: (context, flexiState) {
                          return buildTextFieldColumn(context, flexiState);
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Forget Password?'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                          ),
                        ),
                      ),
                      BlocConsumer<AnimationCubit, AnimationStates>(
                        listener: (context, animationState) {
                          // Add listener logic here if needed
                        },
                        builder: (context, animationState) {
                          return BlocConsumer<AuthCubit, AuthStates>(
                            listener: (context , state){
                              print(state);
                            },
                            builder: (context , state){
                              return buildButton(
                                width: double.infinity,
                                function: () => _login(context, _formKey , AuthCubit.get(context) , userType),
                                text: 'LOGIN',
                                textColor: const Color(0xff233a66),
                                color: const Color(0xffffd691),
                                loading: (AuthCubit.get(context).state is AuthLoadingState) 
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      buildSignUpRow(context),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildTextFieldColumn(BuildContext context, FlexiStates flexiState) {
    final flexiCubit = FlexiCubit.get(context); // Get the FlexiCubit instance
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFormField(
            label: 'Email Address',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Your Email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            radius: 20,
            color: const Color(0xffffd691),
            prefix: Icons.email,
            iconColor: const Color(0xff233a66),
            onChanged: (value) {
              final animationCubit = AnimationCubit.get(context);
              if (value.isNotEmpty && !selectedOnce && animationCubit.currentState == "Idle") {
                animationCubit.changeFromIdle("Selected");
                selectedOnce = true;
              } else if (!selectedOnce) {
                animationCubit.changeToIdle(animationCubit.currentState);
                animationCubit.changeFromIdle("Selected");
                selectedOnce = true;
              } else {
                animationCubit.changeToIdle(animationCubit.currentState);
              }
            },
          ),
          const SizedBox(height: 10),
          buildFormField(
            label: 'Password',
            controller: _passwordController,
            validator: (value) {
              final cubit = AnimationCubit.get(context);

              // Synchronous validation logic
              if (value == null || value.isEmpty) {
                if (cubit.currentState != "Idle" && cubit.currentState != "error") {
                  cubit.changeToIdle(cubit.currentState);
                }
                if (cubit.currentState != "error") {
                  cubit.changeFromIdle("error");
                }
                return 'Please enter your password';
              }

              if (value.length < 6) {
                if (cubit.currentState != "Idle" && cubit.currentState != "error") {
                  cubit.changeToIdle(cubit.currentState);
                }
                if (cubit.currentState != "error") {
                  cubit.changeFromIdle("error");
                }
                return 'Password must be at least 6 characters';
              }

              return null;
            },
            radius: 20,
            obscure: flexiCubit.isPassword,
            color: const Color(0xffffd691),
            prefix: Icons.lock,
            iconColor: const Color(0xff233a66),
            suffix: flexiCubit.suffix,
            suffixPressed: () {
              flexiCubit.changePasswordVisibility();
            },
          ),
        ],
      ),
    );
  }

  Widget buildSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Signup(userType: userType,)),
            );
          },
          child: const Text('Sign Up'),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xffffd691),
          ),
        ),
      ],
    );
  }

  Future<void> _login(BuildContext context, GlobalKey<FormState> formKey , AuthCubit authCubit , String userType) async {
    if (formKey.currentState!.validate()) {
      final cubit = AnimationCubit.get(context);
      await Future.delayed( const Duration(seconds: 1));

      if (cubit.currentState != "Idle") {
        await cubit.changeToIdle(cubit.currentState);
      }
      await authCubit.login(email: _emailController.text, password: _passwordController.text , userType: userType);
    
      if(authCubit.state is AuthLoginSuccessState && authCubit.loginModel!.token != null){
        cubit.changeFromIdle("Flying");
        await Future.delayed(const Duration(milliseconds: 900));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  DoctorHome()),
        );
      }else{
        if(authCubit.state is AuthLoginErrorState){
          print('login failed');
          cubit.changeFromIdle("error");
          Fluttertoast.showToast(msg: "Email or password invalid" , textColor: Colors.white , backgroundColor: Colors.grey);
        }
      }
    
    } else {
      print("Form validation failed.");
    }
  }
}

// Custom Form Field
Widget buildFormField({
  required String label,
  bool obscure = false,
  IconData? prefix,
  IconData? suffix,
  double radius = 0,
  TextEditingController? controller,
  Function? validator,
  VoidCallback? suffixPressed,
  color,
  iconColor,
  onChanged,
}) => TextFormField(
  obscureText: obscure,
  validator: validator as String? Function(String?)?,
  controller: controller,
  decoration: InputDecoration(
    labelText: label,
    labelStyle:const TextStyle(color: Color(0xff233a66)),
    prefix:  Icon(prefix, color: iconColor),
    errorStyle: const TextStyle(
      color:  Color.fromARGB(255, 255, 170, 140), // Change this to your desired error color
      fontSize: 14,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide:const BorderSide(color:  Color.fromARGB(255, 255, 170, 140)), // Change this to your desired border color
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide:const BorderSide(color:  Color.fromARGB(255, 255, 170, 140)), // Change this to your desired focused border color
    ),errorText: "",
    suffixIcon: IconButton(
      onPressed: suffixPressed,
      icon: Icon(suffix, color: iconColor),
    ),
    filled: true,
    fillColor: color,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide.none,
    ),
  ),
  onChanged: onChanged,
);