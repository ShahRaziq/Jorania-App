import 'dart:async';
import 'dart:developer';
import 'package:Jorania/screen/noConnection_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Jorania/screen/login_screen.dart';
import 'package:Jorania/screen/nav_bar.dart';
import 'package:provider/provider.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  dynamic nextScreen = const NavBar();
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      //send user to home screen\
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (c) => nextScreen));
      }
    });
  }

  Future getConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    log(connectivityResult.toString());
    if (connectivityResult == ConnectivityResult.none) {
      nextScreen = const NoConScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    getConnection();

    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result != ConnectivityResult.none) {
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const NoConScreen()));
      }
    });
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
