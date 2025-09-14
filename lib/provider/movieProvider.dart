import 'package:adamcinemaapp/dataService/movieService.Dart';
import 'package:adamcinemaapp/model/movieModel.dart';
import 'package:flutter/material.dart';

class MovieProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadMovies() async {
    _isLoading = true;
    notifyListeners();
    _movies = await _movieService.fetchMovies();
    _isLoading = false;
    notifyListeners();
  }
}