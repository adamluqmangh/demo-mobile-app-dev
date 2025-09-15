import 'package:adamcinemaapp/model/movieModel.dart';
import 'package:adamcinemaapp/screen/movieDetailsScreen.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            movie.movieImage,
            height: 180,
            width: 120,
            fit: BoxFit.cover,
            ),
        ),
        const SizedBox(height: 5),
        Text(
          movie.movieTitle,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        )
      ],
    )
  );
}}