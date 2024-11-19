// main.dart
import 'package:flexiscan101/Auth/auth_home.dart';
import 'package:flexiscan101/Doctor/doctor_home.dart';
import 'package:flexiscan101/Network/dio_helper.dart';
import 'package:flexiscan101/On%20Boarding/on_boarding_screen.dart';
import 'package:flexiscan101/Patient/home_patient.dart';
import 'package:flexiscan101/screens/profile_comp_screen.dart';
import 'package:flexiscan101/shared/notification/cubit.dart';
import 'package:flexiscan101/shared/notification/notification_helper.dart';
import 'package:flexiscan101/shared/profile/cubit.dart';
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
  await NotificationHelper.initializeNotifications();
  

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
         BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:  AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: 
            onboardingcompleted
                ? (ProfileCubit.get(context).isProfileComplete
                    ? (ProfileCubit.get(context).isDoctor
                        ?  DoctorHome() // If user is a doctor, show DoctorHome
                        :  PatientHome()) // If user is a patient, show PatientHome
                    :  CompleteInformationScreen( userType: 'patient',)) // If profile is incomplete, show ProfileCompletionScreen
                : const OnBoardingScreen(), 
          );
        },
      ),
    );
  }
}
