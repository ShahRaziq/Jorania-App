import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Jorania/services/airpasangsurutScrap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:Jorania/services/weather_service.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Jorania/custom/weatherCard.dart';
import 'package:Jorania/screen/login_screen.dart';
import 'package:Jorania/services/firestore_service.dart';
import 'package:Jorania/web_view/jupem.dart';
import 'package:Jorania/web_view/tideForecast.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String dateString;
  WeatherModel? weatherModel;
  int temp = 0;
  String icon = "01d";
  Position? currentPosition;
  List<Placemark>? placemarks;
  Map<String, Map<String, String>>? airPasang;

  String text = "";

  String username = "";
  FireStoreService fireStoreService = FireStoreService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //date format malay
    initializeDateFormatting('ms');
    dateString = DateFormat('EEEE, d, MMMM', "ms").format(DateTime.now());

    //air pasang surut Scrap
    AirPasangSurut air = AirPasangSurut();
    air.extractData("Tanjung Gelang").then((value) {
      airPasang = value;
      if (mounted) {
        setState(() {});
      }
    });
    fireStoreService.getdata().then((value) {
      username = value.data()!["name"];
      getweather();
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
          iconTheme: IconThemeData(color: Colors.transparent),
          title: Text(
            "",
            style: TextStyle(fontSize: 30, color: Colors.transparent),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
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
                color: Colors.grey[700],
              ),
              iconSize: 36,
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                  WeatherCard(
                    date: dateString,
                    temp: temp.toString(),
                    location: "",
                    weather: "sunny",
                    icon: icon,
                    state: placemarks != null
                        ? placemarks!.elementAt(0).administrativeArea!
                        : "",
                    city: placemarks != null
                        ? placemarks!.elementAt(0).locality!
                        : "",
                  ),
                  SizedBox(height: 30),
                  Text("Ramalan air pasang surut 🌊:",
                      style: TextStyle(
                          color: Color(0xff323F4B),
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),

                  SizedBox(height: 20),
                  //card ramalan air pasang surut jupem
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Color.fromARGB(240, 216, 109, 60),
                    child: InkWell(
                      splashColor:
                          Color.fromARGB(255, 131, 173, 163).withAlpha(50),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => JupemWV()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Column(
                              children: [
                                // date
                                airPasang != null
                                    ? Text(airPasang!.keys.first,
                                        style: TextStyle(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))
                                    : SizedBox(),
                                airPasang != null
                                    ?
                                    //pasang surut table
                                    DataTable(
                                        columns: [
                                            DataColumn(
                                                label: Text('Masa',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepPurple,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            DataColumn(
                                                label: Text('Ketinggian (cm)',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.deepPurple,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        rows: airPasang![airPasang!.keys.first]!
                                            .entries
                                            .map(
                                              (e) => DataRow(
                                                cells: [
                                                  DataCell(Center(
                                                      child: Text(
                                                    e.key,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.sp),
                                                  ))),
                                                  DataCell(Center(
                                                      child: Text(
                                                    e.value,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.sp),
                                                  ))),
                                                ],
                                              ),
                                            )
                                            .toList())
                                    : SizedBox(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Stesen: Tanjung Gelang, Pahang',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          height: 2),
                                    ),
                                  ],
                                ),
                                Text(
                                  "sumber: laman web rasmi JUPEM",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 107, 88, 192),
                                      height: 1.6),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),

                  SizedBox(height: 20),
                  //card forecast.com TideForcastWV
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    color: Color.fromARGB(255, 24, 120, 175),
                    child: InkWell(
                      splashColor:
                          Color.fromARGB(255, 131, 173, 163).withAlpha(50),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => TideForcastWV()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ramalan terperinci ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10.w,
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

  void getweather() async {
    await _determinePosition();

    final response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/nearest_city?lat=${currentPosition!.latitude}&lon=${currentPosition!.longitude}&key=ebddbd20-8b93-4184-89b7-55ad20cc40c1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      WeatherModel weatherModel = weatherModelFromJson(response.body);
      print(response.body);
      print(weatherModel.data!.current!.weather!.tp);
      if (mounted) {
        setState(() {
          temp = weatherModel.data!.current!.weather!.tp!;
          icon = weatherModel.data!.current!.weather!.ic!;
        });
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);

    placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude);
  }
}
