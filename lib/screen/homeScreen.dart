// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/movieProvider.dart';
import '../widget/movieCardWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MovieProvider>(context, listen: false).loadMovies());
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hello, Raymond",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Want to go see a movie? Get your ticket today",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[850],
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search movie",
                  hintStyle: const TextStyle(color: Colors.white54),
                  suffixIcon: const Icon(Icons.filter_list, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              const Text(
                "New Release",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              if (movieProvider.isLoading)
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              else
                SizedBox(
                  height: 280,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movieProvider.movies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final movie = movieProvider.movies[index];
                      return MovieCard(movie: movie);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
