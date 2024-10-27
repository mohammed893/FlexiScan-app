import 'package:flexiscan101/Components/custom/custom_appBar.dart';
import 'package:flexiscan101/SharedScreens/auth_home.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'on_boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: '',
        onPressed: () {
          submit();
        },
        backGroundColor: Color(0xff233a66),
        textButtonColor: Color(0xffd7a859),
      ),
      backgroundColor: Color(0xff233a66),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemBuilder: (context, index) => buildBoarderItem(boarding[index]),
              itemCount: boarding.length,
              onPageChanged: (int index) {
                setState(() {
                  isLast = (index == boarding.length - 1);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Color(0XFFffd691),
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: Colors.white,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                     submit();
                    } else {
                      controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    }
                  },
                  backgroundColor: Color(0xffd7a859),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xff233a66),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoarderItem(BoardingModel model) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
           children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Flexible(
               flex: 2,
               child: Image(
                 image: AssetImage(model.image),
                 height: 400,
                 width: 350,
               ),
             ),
            // if (model.image2 != null)
            //  Flexible(
            //    flex: 1,
            //    child: Image(
            //      image: AssetImage(model.image2!),
            //      fit: BoxFit.contain,
            //      height: 400,
            //      width: 300,
            //       ),
            //  ),

                     ],
                   ),
           ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xffd7a859),
          ),
        ),
        SizedBox(height: 20),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );

  void submit(){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => AuthHome()
      ),
          (Route<dynamic >route)=> false,
    );
  }
}
