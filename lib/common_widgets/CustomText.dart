import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final double? fontsize;
  final Color? fontcolor;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;
  final int? maxline;


  // Constructor with optional parameters
  const CustomText({
    required this.text,
    this.textAlign,
    this.fontsize,
    this.fontcolor,
    this.fontWeight, this.overflow, this.maxline, this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontsize, color: fontcolor,fontWeight: fontWeight,decoration: textDecoration),
      textAlign: textAlign ??
          TextAlign.start,overflow: overflow,maxLines: maxline,
      // Default alignment// Default text overflow
    );
  }
}
