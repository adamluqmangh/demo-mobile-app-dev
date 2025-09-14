import 'package:adamcinemaapp/screen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/movieProvider.dart';



void main() {
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        )
      ),
      home: HomeScreen(),
    );
  }
}

