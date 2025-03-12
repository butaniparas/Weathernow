import 'package:flutter/material.dart';

class ScreenSize {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  static void init(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;

    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }

  static double widthPercentage(double percentage) {
    return blockWidth * percentage;
  }

  static double heightPercentage(double percentage) {
    return blockHeight * percentage;
  }
}