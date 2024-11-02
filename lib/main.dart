import 'package:flexiscan101/Network/dio_helper.dart';
import 'package:flexiscan101/On%20Boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physical_theraby/screens/home_screen.dart';
import 'package:physical_theraby/shared/app_cubit/app_cubit.dart';
import 'package:physical_theraby/shared/app_cubit/app_states.dart';
import 'package:physical_theraby/shared/network/local/cache_helper.dart';
import 'package:physical_theraby/shared/styles/theme.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();
  bool isDark = CachHelper.getData(key: 'isDark');
  bool onboarding = CachHelper.getData(key: 'onboarding' );
  runApp(MyApp(isDark: isDark ,     
                onboardingconpleted: onboarding,));
}


class MyApp extends StatelessWidget {
final bool isDark;
final bool onboardingconpleted;
  MyApp({required this.isDark, required this.onboardingconpleted});
  @override
   Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode( currentModeFromPrefs: isDark )
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:  AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: onboardingCompleted ? login() : OnBoardingScreen(),
            /*
           // edit the submit function 'sanable's branch' at the end of onboardingscreen to be 


            void submit() {
 
           CachHelper.putBool(key: 'onboarding', value: true).then((value) {
           if (value) {
      
            Navigator.pushAndRemoveUntil(
            context,
           MaterialPageRoute(builder: (context) => AuthHome()),
           (Route<dynamic> route) => false,
      );
    }
  });
}
            
             */
          );
        },
      ),
    );
  }
}
