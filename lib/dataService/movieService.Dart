import '../model/movieModel.dart';
import 'dart:convert';
import 'package:flutter/services.dart';


class MovieService {
  Future<List<Movie>> fetchMovies() async {
    final response = await rootBundle.loadString('asset/movie.json');
    final data = json.decode(response) as List;
    return data.map((movieJson) => Movie.fromJson(movieJson)).toList();
  }
}