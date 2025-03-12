import 'package:flutter/material.dart';

class WeatherInfoItem extends StatelessWidget {
  final String assetPath;
  final String value;
  final double iconSize;
  final Color iconColor;
  final double textSize;
  final Color textColor;

  const WeatherInfoItem({
    required this.assetPath,
    required this.value,
    this.iconSize = 30,
    this.iconColor = Colors.white,
    this.textSize = 15,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          assetPath,
          width: iconSize,
          height: iconSize,
          color: iconColor,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(fontSize: textSize, color: textColor),
        ),
      ],
    );
  }
}
