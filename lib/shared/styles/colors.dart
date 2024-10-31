// shared/styles/colors.dart
import 'dart:ui';

class AppColors {
  // Light Colors
  static const Color lightButtonBlue = Color(0xFF789DBC); 
  static const Color lightButtonPink = Color(0xFFFFC7ED); 
  static const Color lightButtonGold = Color(0xFFFFD691); 
  static const Color lightButtonGreen = Color(0xFFC9E9D2); 

 static const Color lightBackground = Color(0xFFD9D9D9); 
static const Color lightCardBackground = Color(0xFFF0F0F0); 
static const Color lightTextandicon = Color(0xFF304463);
 
  
  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF304463);
  static const Color darkCardBackground = Color.fromARGB(89, 22, 45, 87);
  static const Color darkTextandicon = Color(0xFFFEF9F2);

static const Color darkButtonBlue = Color(0xFF4A6A8A);  
static const Color darkButtonPink = Color(0xFFB35D87);  
static const Color darkButtonGold = Color(0xFFC7A563);  
static const Color darkButtonGreen = Color(0xFF6A9A8A);  

  // Method to get button color based on the theme
  static Color getButtonColor(
    String buttonType,
     bool isDark
     ) {
    switch (buttonType) {
      case 'AI Health Check':
        return isDark ? darkButtonBlue : lightButtonBlue;
      case 'Book an Online Session':
        return isDark ? darkButtonPink : lightButtonPink;
      case 'Last Sessions':
        return isDark ? darkButtonGold : lightButtonGold;
      case 'Chat with Doctor':
        return isDark ? darkButtonGreen : lightButtonGreen;
      case 'Upcoming Sessions':
        return isDark ? darkButtonBlue : lightButtonBlue; 
      case 'Past Sessions':
        return isDark ? darkButtonPink : lightButtonPink; 
      default:
        return isDark ? darkButtonBlue : lightButtonBlue; 
    }
  }
}
