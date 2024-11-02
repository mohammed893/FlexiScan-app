// shared/components/custum_components.dart
import 'package:flutter/material.dart';
import 'package:physical_theraby/shared/app_cubit/app_cubit.dart';
import 'package:physical_theraby/shared/network/local/cache_helper.dart';
import 'dart:ui' as ui;

import 'package:physical_theraby/shared/styles/colors.dart';

// Helper function to build a grid item with animation on hover
Widget buildAnimatedGridItem({
  required String title,
  required BuildContext context,
  required dynamic pageRoute,
  IconData? icon,
  color
}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AnimatedScale(
      scale: 1.05, // Adjust the scale for a slight zoom effect
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: 100,
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            backgroundColor: color,
          ),
          onPressed: () {
            AppCubit.get(context)
                .navigateToNextPage(context: context, nextPage: pageRoute);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget greetingItem({
  required String username,
  required BuildContext context,
  required ImageProvider userimage,
}) {
  return Row(
    children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: userimage,
      ),
      SizedBox(width: 30),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(seconds: 1), 
            child: Text(
              username,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    ],
  );
}
        


class CurvedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the isDark value from AppCubit
    bool isDark = AppCubit.get(context).isDark;

    return CustomPaint(
      size: Size.fromHeight(200), 
      painter: RPSCustomPainter(isDark: isDark), 
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  final bool isDark;
  

  RPSCustomPainter({
    required this.isDark, 
  }); 

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintFill = Paint()
      ..color = isDark ? AppColors.darkBackground : AppColors.lightBackground
      ..style = PaintingStyle.fill;

    Path path = Path();

    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.7,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.9,
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();

    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
