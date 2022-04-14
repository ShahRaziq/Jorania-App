import 'dart:developer';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:Jorania/custom/weatherCard.dart';
import 'package:Jorania/screen/login_screen.dart';
import 'package:Jorania/services/firestore_service.dart';
import 'package:Jorania/web_view/jupem.dart';
import 'package:Jorania/web_view/tideForecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  final screens = [
    Center(
      child: Text('Home', style: TextStyle(fontSize: 60)),
    ),
    Center(
      child: Text('Home', style: TextStyle(fontSize: 60)),
    ),
    Center(
      child: Text('Home', style: TextStyle(fontSize: 60)),
    ),
    Center(
      child: Text('Home', style: TextStyle(fontSize: 60)),
    ),
  ];
  String text = "";

  // request() async {
  //   final response = await http.get(
  //     Uri.parse(
  //         "https://tides.p.rapidapi.com/tides?longitude=103.3317&latitude=3.8168&interval=60&duration=1440"),
  //     // Send authorization headers to the backend.
  //     headers: {
  //       "X-RapidAPI-Host": "tides.p.rapidapi.com",
  //       "X-RapidAPI-Key": "e0c26bb0a6mshd8ee3db38ec9a94p120674jsnaf21c4d3dfcc",
  //     },
  //   );

//     Map valueMap = json.decode(response.body);
//     //  text = valueMap["heights"][3]["height"].toString();
// setState(() {

// });

//     log(response.body);
//   }
  String username = "";
  FireStoreService fireStoreService = FireStoreService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireStoreService.getdata().then((value) {
      username = value.data()!["name"];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // request();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.grey),
          title: Text(
            "Jorania",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            //Log out button
            IconButton(
              onPressed: () {
                // set up the buttons
                Widget cancelButton = TextButton(
                  child: Text("Tidak"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
                Widget continueButton = TextButton(
                  child: Text("Ya"),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text("Log Keluar"),
                  content: Text("Anda pasti mahu log keluar?"),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.black,
              ),
              iconSize: 36,
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hai $username,",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),

                  SizedBox(height: 20),
                  Weather(date: "", temp: "", location: "", weather: "sunny"),
                  SizedBox(height: 30),
                  Text("Ramalan air pasang surut:",
                      style: TextStyle(
                          color: Color(0xff323F4B),
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),

                  SizedBox(height: 20),
                  //card ramalan air pasang surut jupem
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Color.fromARGB(255, 228, 118, 160),
                    child: InkWell(
                      splashColor:
                          Color.fromARGB(255, 131, 173, 163).withAlpha(50),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => JupemWV()));
                      },
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Stesen: Tanjung Gelang, Pahang',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Text(
                    "sumber: laman web rasmi JUPEM",
                    style: TextStyle(
                      color: Color.fromARGB(255, 107, 88, 192),
                    ),
                  ),
                  SizedBox(height: 20),
                  //card forecast.com TideForcastWV
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Colors.purpleAccent,
                    child: InkWell(
                      splashColor:
                          Color.fromARGB(255, 131, 173, 163).withAlpha(50),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => TideForcastWV()));
                      },
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ramalan terperinci',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Text(
                    "sumber: laman web rasmi tide-forcast.com",
                    style: TextStyle(
                      color: Color.fromARGB(255, 107, 88, 192),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
