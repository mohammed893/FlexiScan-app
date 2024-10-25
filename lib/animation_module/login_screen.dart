import 'package:flexiscan101/animation_module/cubit.dart';
import 'package:flexiscan101/animation_module/states.dart';
import 'package:flexiscan101/animation_module/testScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationCubit animationCubit;
  var SelectedOnce = false;

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationCubit = AnimationCubit(this, context); // Initialize here
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    animationCubit.dispose(); // Dispose of the animation cubit
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => animationCubit,
      child: Scaffold(
        body: BlocBuilder<AnimationCubit , AnimationStates>(
          builder: (context, state) {
            
            return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                     AnimatedPositioned(
                            duration: const Duration(milliseconds: 500),
                            bottom: animationCubit.currentState == "Flying" ? 300 : 0,
                            left: MediaQuery.of(context).size.width / 2 - 65,
                            child: ClipRect(
                              child: Image.asset(
                                animationCubit.currentGIF,
                                height: 180,
                                width: 130,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          )
                        
                      
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: const OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              print(value);
                              final cubit = AnimationCubit.get(context);

                              if (value.isNotEmpty && !SelectedOnce && cubit.currentState == "Idle") {
                                cubit.changeFromIdle("Selected");
                                SelectedOnce = true;
                              } else {
                                if(!SelectedOnce)
                                {
                                  cubit.changeToIdle(cubit.currentState);
                                  cubit.changeFromIdle("Selected");
                                  SelectedOnce = true;
                                }
                                cubit.changeToIdle(cubit.currentState);

                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                            final cubit = AnimationCubit.get(context);

                            // Synchronous validation logic
                            if (value == null || value.isEmpty) {
                              if (cubit.currentState != "Idle" && cubit.currentState != "error") {
                                cubit.changeToIdle(cubit.currentState); // Called asynchronously elsewhere
                              }
                              if (cubit.currentState != "error") {
                                cubit.changeFromIdle("error"); // Called asynchronously elsewhere
                              }
                              return 'Please enter your password';
                            }

                            if (value.length < 6) {
                              if (cubit.currentState != "Idle" && cubit.currentState != "error") {
                                cubit.changeToIdle(cubit.currentState); // Called asynchronously elsewhere
                              }
                              if (cubit.currentState != "error") {
                                cubit.changeFromIdle("error"); // Called asynchronously elsewhere
                              }
                              return 'Password must be at least 6 characters';
                            }

                            return null;
                          },

                            onChanged: (value) {
                              if (value.isNotEmpty) {
                              } else {
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => _login(context),
                            child: const Text('Login'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/signup');
                            },
                            child: const Text("Don't have an account? Sign Up"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
          },
          
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      final cubit = AnimationCubit.get(context);
      await Future.delayed(Duration(seconds: 1));
      if(cubit.currentState != "Idle"){
        await cubit.changeToIdle(cubit.currentState);
      }
      await cubit.changeFromIdle("Flying");
      await Future.delayed(const Duration(seconds: 0 , milliseconds: 700)).then((onValue){
        Navigator.pushReplacement(
       context,
        MaterialPageRoute(builder: (context) =>AnimationTestScreen()),
);    
      });
      }
  }
}
