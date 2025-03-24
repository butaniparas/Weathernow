import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weathernow/resources/appassets.dart';
import 'package:weathernow/ui/home/home.dart';
import 'package:weathernow/utils/screensize.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Navigatetonext(context);
    ScreenSize.init(context);

    return Scaffold(
      body: SafeArea(
          child: Container(
        width: ScreenSize.screenWidth,
        height: ScreenSize.screenHeight,
        child: Lottie.asset(appassets.splashanim),
      )),
    );
  }
}

void Navigatetonext(BuildContext context) async {
  await Future.delayed(Duration(seconds: 4));
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
}

