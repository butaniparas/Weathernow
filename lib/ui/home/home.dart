import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weathernow/common_widgets/CustomDialog.dart';
import 'package:weathernow/common_widgets/CustomText.dart';
import 'package:weathernow/common_widgets/Imageasset.dart';
import 'package:weathernow/resources/appassets.dart';
import 'package:weathernow/resources/appstring.dart';
import 'package:weathernow/ui/home/widget/WeatherInfoItem.dart';
import 'package:weathernow/ui/home/provider/WeatherDataProvider.dart';
import 'package:weathernow/utils/screensize.dart';

import '../../common_widgets/CustomTextformFiled.dart';
import '../../resources/appcolor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherDataProvider>(context, listen: false)
          .fetchCurrentLocationWeather(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final weatherdataProvider = Provider.of<WeatherDataProvider>(context);

    final weatherdata = weatherdataProvider.modelCurrentWeather;
    final city = weatherdata?.name ?? "";
    final currenttime = weatherdata?.dt != null ? convertTimestampForDate(weatherdata!.dt!) : "";
    final temperature = kelvinToCelsius(weatherdata?.main?.temp ?? 0.0);
    final high_temperature = kelvinToCelsius(weatherdata?.main?.tempMax ?? 0.0);
    final low_temperature = kelvinToCelsius(weatherdata?.main?.tempMin ?? 0.0);
    final humidity = "${weatherdata?.main?.humidity ?? ""}%";
    final wind_speed = "${weatherdata?.wind?.speed ?? ""} km/h";
    final skyvisibility = "${((weatherdata?.visibility ?? 0) / 10000 * 100).toInt()}%";
    final weatherCondition = weatherdata?.weather?[0].main ?? "";
    final weathertext = weatherdata?.weather?[0].description ?? "";
    final String sunset = weatherdata?.sys?.sunset != null ? convertToTime(weatherdata!.sys!.sunset!) : "";
    final String sunrise = weatherdata?.sys?.sunrise != null ? convertToTime(weatherdata!.sys!.sunrise!) : "";

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          await _onWillPop(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Consumer<WeatherDataProvider>(
              builder: (context, searchProvider, child) {
                return Opacity(
                    opacity: 0.7,
                    child: image_asset(
                        assetpath: getBackgroundImage(weatherCondition),
                        width: ScreenSize.screenWidth,
                        height: ScreenSize.screenHeight,
                        fit: BoxFit.cover));
              },
            ),
            Container(
              color: appcolor.color_black_transperent,
            ),
            Lottie.asset(appassets.flyingbird, width: 300, height: 300),
            Positioned(
                bottom: 0,
                child:
                    Lottie.asset(appassets.flyingbird, width: 300, height: 300)),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        image_asset(
                          assetpath: appassets.ic_location,
                          width: 22,
                          height: 22,
                          fit: BoxFit.cover,
                          color: appcolor.color_white,
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          text: city!,
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                          fontcolor: appcolor.color_white,
                        ),
                      ],
                    ),
                    CustomText(
                      text: "Today, $currenttime",
                      fontWeight: FontWeight.w400,
                      fontsize: 15,
                      fontcolor: appcolor.color_white,
                    ),
                    SizedBox(height: 20),
                    CustomTextformfield(
                      controller: _searchController,
                      hinttext: "Enter City Here...",
                      obsecure: false,
                      keybordtype: TextInputType.text,
                      hintcolor: appcolor.color_white,
                      borderradius: 15,
                      borderColor: appcolor.color_white,
                      textcolor: appcolor.color_white,
                      focused_borderColor: appcolor.color_white,
                      onsubmitted: (value) {
                        if (value!.isNotEmpty) {
                          weatherdataProvider.updateSearch(context, value!);
                        } else {
                          weatherdataProvider.fetchCurrentLocationWeather(context);
                        }
                      },
                      suffixicon: weatherdataProvider.searchQuery.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: appcolor.color_white,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                weatherdataProvider.clearSearch(context);
                              },
                            )
                          : null,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                          width: ScreenSize.screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: appcolor.color_blue_lightest,
                          ),
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Consumer<WeatherDataProvider>(
                                builder: (context, searchProvider, child) {
                                  return Lottie.asset(
                                    getCardAnim(weatherCondition),
                                    width: ScreenSize.screenWidth*0.2,
                                    height: ScreenSize.screenWidth*0.2,
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                              CustomText(
                                text: "${temperature.toStringAsFixed(1)}°C",
                                fontcolor: appcolor.color_white,
                                fontsize: 35,
                              ),
                              SizedBox(height: 5),
                              CustomText(
                                text: weathertext!,
                                fontcolor: appcolor.color_white,
                                fontsize: 20,
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: WeatherInfoItem(
                                      assetPath: appassets.ic_windspeed,
                                      value: wind_speed.toString(),
                                      iconColor: appcolor.color_white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: WeatherInfoItem(
                                      assetPath: appassets.ic_humidity,
                                      value: humidity.toString(),
                                      iconColor: appcolor.color_white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: WeatherInfoItem(
                                      assetPath: appassets.ic_eye,
                                      value: skyvisibility.toString(),
                                      iconColor: appcolor.color_white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomText(text: "Today Weather",fontWeight: FontWeight.bold,fontsize: 18,fontcolor: appcolor.color_white),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenSize.screenWidth*0.19,
                            height:ScreenSize.screenWidth*0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: appcolor.color_yellowwhite,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: WeatherInfoItem(
                                assetPath: appassets.ic_lowtemp,
                                value: low_temperature.toStringAsFixed(1),
                                iconSize: 30,
                                iconColor:appcolor.color_black,
                                textColor: appcolor.color_black,
                                textSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width: ScreenSize.screenWidth*0.19,
                            height:ScreenSize.screenWidth*0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: appcolor.color_yellowwhite,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: WeatherInfoItem(
                                assetPath: appassets.ic_hightemp,
                                value: high_temperature.toStringAsFixed(1),
                                iconSize: 30,
                                iconColor:appcolor.color_black,
                                textColor: appcolor.color_black,
                                textSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width: ScreenSize.screenWidth*0.19,
                            height:ScreenSize.screenWidth*0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: appcolor.color_yellowwhite,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: WeatherInfoItem(
                                assetPath: appassets.ic_sunrise,
                                value: sunrise.toString(),
                                iconSize: 30,
                                iconColor:appcolor.color_black,
                                textColor: appcolor.color_black,
                                textSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            width: ScreenSize.screenWidth*0.19,
                            height:ScreenSize.screenWidth*0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: appcolor.color_yellowwhite,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: WeatherInfoItem(
                                assetPath: appassets.ic_sunset,
                                value: sunset.toString(),
                                iconSize: 30,
                                iconColor:appcolor.color_black,
                                textColor: appcolor.color_black,
                                textSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

Future<bool> _onWillPop(BuildContext context) async {
  bool? exitConfirmed = await showDialog(
    context: context,
    builder: (context) => CustomDialog(
      imageUrl: appassets.ic_exit,
      message: appstring.exitmessage,
      okayText: appstring.exit,
      onOkay: () {
        Navigator.of(context).pop(true);
      },
      cancelText: appstring.cancel,
      onCancel: () {
      },
    ),
  );

  if (exitConfirmed == true) {
    exit(0); // Exit the app
  }

  return false;
}

//For Temperature Conversion (Kelvin to celsius)
double kelvinToCelsius(double kelvin) {
  return kelvin - 273.15;
}

//For convert date in required format
String convertTimestampForDate(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('MMM d').format(date);
}

//For convert time in required format
String convertToTime(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('HH:mm').format(date);
}

//background image
String getBackgroundImage(String condition) {
  switch (condition) {
    case "Rain":
      return appassets.iv_rainy;
    case "Clouds":
      return appassets.iv_cloudy;
    case "Snow":
      return appassets.iv_snowfall;
    default:
      return appassets.iv_sunny;
  }
}

//weather status card aniimantion
String getCardAnim(String condition) {
  switch (condition) {
    case "Rain":
      return appassets.splashanim;
    case "Clouds":
      return appassets.cloudy;
    case "Snow":
      return appassets.snowfall;
    default:
      return appassets.sunny;
  }
}

String getWeatherCondition(String city) {
  List<String> weatherConditions = ["Sunny", "Rain", "Clouds", "Snow"];
  weatherConditions.shuffle();
  return weatherConditions[0];
}


