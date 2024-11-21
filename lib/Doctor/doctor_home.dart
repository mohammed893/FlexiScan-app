 import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexiscan101/Components/custom/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../Components/custom/custom_home_item.dart';
import '../Components/custom/custom_search_bar.dart';

class DoctorHome extends StatelessWidget {
  final TextEditingController searchController;
  DoctorHome({super.key , required this.searchController});
  

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      resizeToAvoidBottomInset: false,
       backgroundColor: Colors.white,
         appBar: appbar(title: '',
           menuOnPressed: (){},
           leadingIcon: Icons.menu,
           notiOnPressed: (){},
           notiIcon: Icons.notifications_none,
           backGroundColor: Colors.white,
         ),
         body: Column(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
            Search(searchController: searchController,),
            buildContainer(),
           ],
         ),
     );
   }

   Widget buildContainer(){
     return Container(
       width: double.infinity,
       height: 450,
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
           buildRowHomeItem(),
           const SizedBox(height: 20,),
           Row(
             children: [
               const Text('Today\'s Appointments',
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 25,
                 fontWeight: FontWeight.bold,
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
           buildAppointmentContainer(),

         ],
       ),
     );
   }

   Widget buildAppointmentContainer(){
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

