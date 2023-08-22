// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_in_flutter/view/home_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () { 
      ///* `Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));` is used to
      ///* navigate to the `HomeScreen` when the timer duration is completed in the `initState` method.
      ///* It creates a new route to the `HomeScreen` and pushes it onto the navigation stack, replacing
      ///* the current route.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      
    });
  }


  
  
  
  
  
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    
    return Scaffold(
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/splash_pic.jpg",
              fit: BoxFit.cover,
              height: height * .5,
            ),

            SizedBox(height: height *.04,),

            Text("TOP HEADLINES",style: GoogleFonts.anton(letterSpacing: .6,color: Colors.grey.shade700),),

            SizedBox(height: height *.04,),

            SpinKitChasingDots(
              color: Colors.blue,
              size: 40,
            )

          ],
        ),
      ) ,
    );

  }
}