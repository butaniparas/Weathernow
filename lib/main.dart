import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/resources/appcolor.dart';
import 'package:weathernow/ui/home/provider/WeatherDataProvider.dart';
import 'package:weathernow/ui/splash/splash.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => WeatherDataProvider()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: appcolor.color_blue_lightest,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weathernow',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}


