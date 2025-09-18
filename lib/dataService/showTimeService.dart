import 'dart:convert';
import 'package:flutter/services.dart';

class ShowtimeService {
  static Future<List<String>> loadShowtimes() async {
    final String response = await rootBundle.loadString('asset/cinemashowtime.json');
    final data = json.decode(response);
    return List<String>.from(data['showtimes']);
  }
}