class Movie {
  final String movieTitle;
  final String movieImage;

  Movie({required this.movieTitle, required this.movieImage});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieTitle: json['movieTitle'],
      movieImage: json['movieImage'],
      );
  }
}