import 'package:flutter/services.dart';
import 'dart:convert';


class CinemaHallService {
  static Future<List<String>> loadCinemaHall() async {
    final String jsonString = await rootBundle.loadString('asset/cinemahall.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return List<String>.from(jsonMap['cinemahall']);
  }
}