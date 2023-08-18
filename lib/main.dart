import 'package:flutter/material.dart';
import 'package:news_app_in_flutter/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.black),
        )
      ),  
      home: SplashScreen()
    );
  }
}

