import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexiscan101/Components/custom/custom_app_bar.dart';
import 'package:flexiscan101/Components/custom/custom_button.dart';
import 'package:flexiscan101/Components/custom/custom_home_item.dart';
import 'package:flexiscan101/Components/custom/custom_search_bar.dart';
import 'package:flexiscan101/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/Patient/Cubit/states.dart';
import 'package:flexiscan101/Patient/Models/recommendation_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
 TextEditingController searchController = TextEditingController();

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        welcomeRow(),
        Search(searchController: searchController),
        Flexible(child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.start,
          child: buildContainer(text: 'text', iconText: 'Schedule', icon:  Icons.schedule, context: context),
        ))
      ],
    );
  }

  Widget buildContainer({
    required String text,
    required String iconText,
    required IconData? icon,
    required BuildContext context
  }){
    final model = RecommendedModel(
      name: "Dr.Mohammed ",
      image: 'asset/images/profile.png',
      rate: 4.5,
    );
    return Container(
      width: double.infinity,
      height: 565,
      decoration:const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        color: Color(0xff233a66),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          buildRowHomeItem(iconText: iconText,icon: icon),
          const SizedBox(height: 15,),
          Row(
            children: [
              const Text( '  Recommended',
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
          const SizedBox(height: 15,),
          buildAppointmentContainer(model),

        ],
      ),
    );
  }
  Widget buildAppointmentContainer(RecommendedModel model){
    return
      CarouselSlider(
        items: [
          Container(
            width: 250,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Padding(
                  padding:const EdgeInsets.only(top: 20),
                  child: Image(image: AssetImage(model.image),
                    height: 100,
                  ),
                ),
                const SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name,
                      style:const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    BlocBuilder<FlexiCubit,FlexiStates>(
                      builder: (context , state){
                        return  RatingBar.builder(
                          itemBuilder: (context, _) =>const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          minRating: 0,
                          maxRating: 5,
                          allowHalfRating: true,
                          direction: Axis.horizontal,
                          initialRating:model.rate,
                          onRatingUpdate: (newRate) {
                            FlexiCubit.get(context).updateRate(newRate);
                          },
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment:MainAxisAlignment.end,
                  children: [
                    buildButton(
                        color:const Color(0xff233a66),
                        text: 'Book Now',
                        width: 120.0,
                        function: (){},
                        textColor: Colors.white,
                        height: 50.0,
                        loading: false
                    ),
                  ],
                )
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
          viewportFraction: 0.65,
          height: 320,
        ),
      );
  }

  Widget navigationBar(flexi){
    return BottomNavigationBar(
      backgroundColor: const  Color(0xff233a66),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      currentIndex: flexi.currentIndex,
      onTap: (index) {
        flexi.changeIndex(index);
      },
      items:const [
        BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.play_circle),
            label: "Exercises"),
        BottomNavigationBarItem(icon: Icon(Icons.devices),
            label: "Device"),
      ],
    );
  }

  Widget welcomeRow(){
    return const Row(
      children: [
        Image(image: AssetImage('asset/images/Pointing.gif'),
          height: 140,
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
            Text('Name',
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