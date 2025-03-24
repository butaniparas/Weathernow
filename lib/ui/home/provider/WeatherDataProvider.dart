import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathernow/common_widgets/ToastHelper.dart';
import 'package:weathernow/resources/appstring.dart';
import 'package:weathernow/ui/home/model/ModelCurrentWeather.dart';

import '../../../Api/ApiService.dart';
import '../../../common_widgets/Loader.dart';
import '../../../services/LocationService.dart';

class WeatherDataProvider extends ChangeNotifier {
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  String? _errorMessage;
  ModelCurrentWeather? modelCurrentWeather;
  String? get errorMessage => _errorMessage;

  //fetch current location
  Future<void> fetchCurrentLocationWeather(BuildContext context) async {
    Loader().showLoader(context);
    _errorMessage = null;

    try {
      String? city = await LocationService.getCityName();
      if (city != null) {
        _searchQuery = city;
        Loader().hideLoader(context);
        getweatherdata(context,city);
      } else {
        Loader().hideLoader(context);
        ToastHelper.showToast(message: "Location not found");    }
    } catch (e) {
      ToastHelper.showToast(message: "Location not found");
      _errorMessage = e.toString();
      Loader().hideLoader(context);
    } finally {
      Loader().hideLoader(context);
      notifyListeners();
    }

    notifyListeners();
  }

  //get current weather data
  getweatherdata(BuildContext context,String city) async {

    Loader().showLoader(context);

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Loader().hideLoader(context);
      ToastHelper.showToast(message: appstring.nointernet);

      // Load cached data
      await loadCachedWeather();
      notifyListeners();
      return;
    }

    try{
      var data={
        'q':city,
        'appid':appstring.apikey,
      };

      final response = await ApiService().getData("weather",params: data);
      var body =jsonDecode(response.body);

      if(body!=null){
        modelCurrentWeather=ModelCurrentWeather.fromJson(body);
        await saveWeatherToCache(body);
      }else{
        loadCachedWeather();
        ToastHelper.showToast(message:appstring.invalidcity);
      }
    }catch(e){
      loadCachedWeather();
      Loader().hideLoader(context);
      ToastHelper.showToast(message:appstring.invalidcity);
    } finally {
      Loader().hideLoader(context);
    }
    notifyListeners();

  }

  updateSearch(BuildContext context,String city) async {
    _searchQuery = city;
    _errorMessage = null;
    notifyListeners();

    try {
      getweatherdata(context,city);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void clearSearch(BuildContext context) {
    _searchQuery = '';
    _errorMessage = null;
    fetchCurrentLocationWeather(context);
    notifyListeners();
  }

  // Save weather data to SharedPreferences
  Future<void> saveWeatherToCache(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("cached_weather", jsonEncode(data));
  }

  // Load cached weather data
  Future<void> loadCachedWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString("cached_weather");

    if (cachedData != null) {
      modelCurrentWeather = ModelCurrentWeather.fromJson(jsonDecode(cachedData));
    }
  }

}
