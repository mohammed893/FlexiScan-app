// Patient/home_patient.dart
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexiscan101/Components/custom/custom_app_bar.dart';
import 'package:flexiscan101/Components/custom/custom_home_item.dart';
import 'package:flexiscan101/Components/custom/custom_search_bar.dart';
import 'package:flexiscan101/Network/cache_helper.dart';
import 'package:flexiscan101/shared/components/custum_components.dart';
import 'package:flexiscan101/shared/notification/cubit.dart';
import 'package:flexiscan101/shared/profile/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/profile/states.dart';


class PatientHome extends StatelessWidget {
  const PatientHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(
        title: '',
        menuOnPressed: () {}, //////////////later
        notiOnPressed: () {
          
          context.read<NotificationCubit>().sendNotification(
            "Complete Your Profile",
            "Your profile is incomplete. Tap to finish it.",
            "patient_profile",
          );
        },
      ),
      body: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              greetingItem(
                context: context,
                username: 'name ', /////////////// will be replaced
                userImage: AssetImage('assets/images/profile.webp'),
              ),
              Padding(
                
                 padding: const EdgeInsets.all(12),
                 child: Search( hinttext:  'search for a therabist'),
                ),
               
              Expanded(child:buildContainer()),
            ],
          );
        },
      ),
    );
  }

Widget buildContainer(){
     return Container(
       width: double.infinity,
       height: 500,
       decoration:const BoxDecoration(
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(40),
           topRight: Radius.circular(40),
         ),
         color: Color(0xff233a66),
       ),
       child: Column(
         children: [
           const SizedBox(height: 15,),
           buildRowHomeItem(
            'AI Scan',
            'Book ',
            'Flexi ',
            'chat',
          Icons.accessibility_new,
          Image.asset('asset/images/booking.png'),
          Image.asset('asset/images/technical-support.png'),
          Icons.chat_bubble_rounded,

            
           ),
           const SizedBox(height: 20,),
           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: const Text('suggested doctors',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 25,
                   fontWeight: FontWeight.bold,
                 ),
                 ),
               ),
               const Spacer(),
                TextButton(
                   onPressed: (){},
                    child: const Text('View All',
                     style: TextStyle(
                       color: Colors.grey,
                       fontSize: 20,
                     ),),
                   style: TextButton.styleFrom(
                     backgroundColor: const Color(0xff233a66),
                   ))
             ],
           ),
           const SizedBox(height: 10,),
           buildbottomContainer(),

         ],
       ),
     );
   }

   Widget buildbottomContainer(){
     return
        CarouselSlider(
            items: [
              Container(
                width: 200,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child:const Column(
                  children: [
                    Image(image: AssetImage('asset/images/Idle.gif'),
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    Text('data'),
                    SizedBox(height: 10,),
                    Text('data'),
                  ],
                ),
              ),
            ],
            options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayAnimationDuration:const Duration(seconds: 1),
              autoPlayInterval:const Duration(seconds: 4),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.58,
            )
             );
   }

}


