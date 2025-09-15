import 'package:flutter/services.dart';
import 'dart:convert';


class LocationService {
  static Future<List<String>> loadLocations() async {
    final String jsonString = await rootBundle.loadString('asset/location.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return List<String>.from(jsonMap['location']);
  }
}