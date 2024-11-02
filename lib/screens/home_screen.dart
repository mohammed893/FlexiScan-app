// screens/home_screen.dart
import 'package:flexiscan101/screens/book_screen.dart';
import 'package:flexiscan101/shared/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/app_cubit/app_states.dart';
import '../shared/components/custum_components.dart';
import '../shared/styles/colors.dart';
import 'ai_screen.dart';
import 'chat_screen.dart';
import 'sessions_info_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isDark = AppCubit.get(context).isDark;

        return Scaffold(
          backgroundColor: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
          appBar: AppBar(
            backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
            actions: [
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(
                  isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CurvedDivider(),
                    Positioned(
                      top: 0,
                      left: 16,
                      right: 16,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: greetingItem(
                          username: 'user',
                           // edit by getting the username from register model

                          context: context,
                          userimage: NetworkImage(
                            'https://cdni.iconscout.com/illustration/premium/thumb/male-user-image-illustration-download-in-svg-png-gif-file-formats--person-picture-profile-business-pack-illustrations-6515860.png',
                           // this will be handled when updating user profile data ... 
                          //initialize user image in the component whith this image and then call 
                         //the userupdate method (will be build later) and pass the updated image 
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    shrinkWrap: true,
                    children: [
                      buildAnimatedGridItem(
                        title: 'AI Health Check',
                        context: context,
                        pageRoute: AIScreen(),
                        icon: Icons.health_and_safety,
                        color: AppColors.getButtonColor('AI Health Check', isDark),
                      ),
                      buildAnimatedGridItem(
                        title: 'Book an Online Session',
                        context: context,
                        pageRoute: BookScreen(),
                        icon: Icons.calendar_today,
                        color: AppColors.getButtonColor('Book an Online Session', isDark),
                      ),
                      buildAnimatedGridItem(
                        title: 'Last Sessions',
                        context: context,
                        pageRoute: SessionsInfoScreen(),
                        icon: Icons.history,
                        color: AppColors.getButtonColor('Last Sessions', isDark),
                      ),
                      buildAnimatedGridItem(
                        title: 'Chat with Doctor',
                        context: context,
                        pageRoute: ChatScreen(),
                        icon: Icons.chat,
                        color: AppColors.getButtonColor('Chat with Doctor', isDark),
                      ),
                      buildAnimatedGridItem(
                        title: 'Upcoming Sessions',
                        context: context,
                        pageRoute: SessionsInfoScreen(),
                        icon: Icons.event,
                        color: AppColors.getButtonColor('Upcoming Sessions', isDark),
                      ),
                      buildAnimatedGridItem(
                        title: 'Past Sessions',
                        context: context,
                        pageRoute: SessionsInfoScreen(),
                        icon: Icons.done,
                        color: AppColors.getButtonColor('Past Sessions', isDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
