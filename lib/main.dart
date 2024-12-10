// main.dart

import 'package:flexiscan101/Doctor/doctor_home.dart';
import 'package:flexiscan101/Network/dio_helper.dart';
import 'package:flexiscan101/On%20Boarding/on_boarding_screen.dart';
import 'package:flexiscan101/Online-Sessions/Call.dart';
import 'package:flexiscan101/Online-Sessions/index.dart';
import 'package:flexiscan101/Online-Sessions/temp/main_screen.dart';
import 'package:flexiscan101/animation_module/custom_components/animation_widgets.dart';
import 'package:flexiscan101/screens/ai_screen.dart';
import 'package:flexiscan101/screens/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Network/cache_helper.dart';
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
  runApp(MyApp(isDark: isDark ,     
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
            // OnlineSessionsIndex()
            // AIScreen()
            // DoctorHome(searchController:searchController ,)
            // Session_Screen()
            onboardingcompleted ? const AuthHome() : const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
