import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Jorania/screen/login_screen.dart';
import 'package:Jorania/screen/nav_bar.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      //send user to home screen\
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (c) => NavBar()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
            child: Image.asset(
          "asset/Jorania.png",
        )),
      ),
    );
  }
}
