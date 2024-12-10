// main.dart

import 'package:flexiscan101/Auth/screens/auth_home.dart';
import 'package:flexiscan101/Remote/BLE_COMM/controllers/cubit.dart';
import 'package:flexiscan101/Remote/BLE_COMM/screens/Scan.dart';
import 'package:flexiscan101/Remote/BLE_COMM/screens/test.dart';
import 'package:flexiscan101/users/Doctor/doctor_home.dart';
import 'package:flexiscan101/Remote/Network/dio_helper.dart';
import 'package:flexiscan101/screens/On%20Boarding/on_boarding_screen.dart';
import 'package:flexiscan101/Custom%20Modules/Online-Sessions/Call.dart';
import 'package:flexiscan101/Custom%20Modules/Online-Sessions/index.dart';
import 'package:flexiscan101/Custom%20Modules/Online-Sessions/temp/main_screen.dart';
import 'package:flexiscan101/users/Patient/Patient_home.dart';
import 'package:flexiscan101/Custom%20Modules/animation_module/custom_components/animation_widgets.dart';
import 'package:flexiscan101/screens/ai_screen.dart';
import 'package:flexiscan101/screens/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Remote/Network/cache_helper.dart';
import 'shared/app_cubit/app_cubit.dart';
import 'shared/app_cubit/app_states.dart';
import 'shared/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.init();

  CachHelper.putBool(key: 'onboarding', value: false); // just for testing 
  bool isDark = CachHelper.getData(key: 'isDark');
  bool onboarding = CachHelper.getData(key: 'onboarding' );
  runApp(MyApp(isDark: false ,     
                onboardingcompleted: onboarding,));
}


class MyApp extends StatelessWidget {
final bool isDark;
final bool onboardingcompleted;
  MyApp({required this.isDark, required this.onboardingcompleted});
  @override
   Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeAppMode( currentModeFromPrefs: isDark ),
          
        ),
        BlocProvider(create: (context) => BleCubit(),)

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:  AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
           // home: const OnBoardingScreen(),
            home:
            // const BookScreen()
            // BLEScreen()
            // BLEScreen()
            // ScanScreen()
            // OnlineSessionsIndex()
            // AIScreen()
            PatientHome()
            // const PatientHome()
            // Session_Screen()
            // onboardingcompleted ? const AuthHome() : const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
