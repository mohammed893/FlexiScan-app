import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexiscan101/shared/Components/custom/custom_app_bar.dart';
import 'package:flexiscan101/shared/Components/custom/custom_button.dart';
import 'package:flexiscan101/users/Doctor/Models/Appointment_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../shared/Components/custom/custom_home_item.dart';
import '../../shared/Components/custom/custom_search_bar.dart';
TextEditingController searchController = TextEditingController();

class DoctorHome extends StatelessWidget {
  DoctorHome({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: appbar(
        title: '',
        showAvatar: true,
        menuOnPressed: (){},
        leadingIcon: Icons.menu,
        notiOnPressed: (){},
        notiIcon: Icons.notifications_none,
        backGroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          welcomeRow(),
          Search(searchController: searchController,),
          Flexible(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.start,
              child: buildContainer(text: "  Today'\s Appointment",
                iconText: 'Schedule',
                icon: Icons.schedule,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildContainer({
    required String text,
    required String iconText,
    required IconData? icon,
  }){
    return Container(
      width: double.infinity,
      height: 520,
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
              iconText:iconText ,
              icon:icon),
          const SizedBox(height: 20,),
          Row(
            children: [
              Text(text,
                style:const TextStyle(
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
    final model = AppointmentModel(
      name: "Mohammed Ahmed ",
      age: '22',
      gender: 'male',
      date: 'sunday 21:30 22-11-2022',
      environment: 'online',
    );

    return
      CarouselSlider(
        items: [
          Container(
            width: 230,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child:  Padding(
              padding: const EdgeInsets.all(20.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appointmentDataColumn(model ),
                  Spacer(),
                  appointmentButtonRow(),
                ],
              ),
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
          viewportFraction: 0.65,
          height:300,
        ),
      );
  }

  Widget appointmentButtonRow(){
    return Row(
      children:  [
        buildButton(
          color:const Color(0xff233a66),
          width: 90.0,
          text: 'Accept',
          height: 45.0,
          textColor: Colors.white,
          loading: false,
          function: (){},
        ),
        const SizedBox(width: 5,),
        buildButton(
          color:const Color(0xff233a66),
          width: 90.0,
          text: 'Cancel',
          height: 45.0,
          textColor: Colors.white,
          loading: false,
          function: (){},
        ),

      ],
    );
  }

  Widget appointmentDataColumn(AppointmentModel model){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(model.name,
          style:const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),
        ),
        const SizedBox(height: 5,),
        Text(model.gender,
          style:const TextStyle(
              fontSize: 20.0
          ),),
        const SizedBox(height: 5,),
        Text(model.age,
          style:const TextStyle(
              fontSize: 20.0
          ),),
        Text(model.date,
          style:const TextStyle(
              fontSize: 20.0
          ),
        ),
        const SizedBox(height: 5,),
        Text(model.environment,
          style:const TextStyle(
              fontSize: 20.0
          ),),
        const SizedBox(height: 4,),

      ],
    );
  }

  Widget welcomeRow(){
    return const Row(
      children: [
        Image(image: AssetImage('asset/images/Pointing.gif'),
          height: 200,
          width: 120,
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back,',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text("DR "
                'Name',
              style: TextStyle(
                fontSize: 25,
                color: Color(0xff233a66),

              ),
            ),
          ],
        ),
      ],
    );
  }
}
