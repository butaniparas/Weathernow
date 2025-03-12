import 'package:flutter/material.dart';

class image_asset extends StatelessWidget {
  final String assetpath;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;

  image_asset(
      {required this.assetpath,
      required this.width,
      required this.height,
      required this.fit, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetpath,width: width,height: height,fit: fit,color: color,);
  }
}
