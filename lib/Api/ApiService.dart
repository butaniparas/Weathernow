import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/';


  // GET method
  Future<dynamic> getData(String apiUrl, {Map<String, dynamic>? params}) async {
    var fullUrl = Uri.parse(baseUrl + apiUrl);

    if (params != null && params.isNotEmpty) {
      fullUrl = fullUrl.replace(
        queryParameters: {
          ...fullUrl.queryParameters, // Keep existing params
          ...params,
        },
      );
    }

    try {
      final response = await http.get(
        fullUrl,
        headers: _headers(),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('GET request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('GET request error: $e');
    }
  }


  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json', // Ensure JSON format
      'Accept': 'application/json',
    };
  }
}
