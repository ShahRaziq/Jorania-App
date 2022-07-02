import 'dart:async';

// import 'dart:html';

import 'package:Jorania/screen/addLocation.dart';
import 'package:Jorania/screen/place.dart';
import 'package:Jorania/services/firestore_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool visible = false;

  static const CameraPosition _kuantan = CameraPosition(
    target: LatLng(3.8170687016220435, 103.33250841777334),
    zoom: 14.4746,
  );

  blackThemeGoogleMap() {
    newGoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

  FireStoreService fireStoreService = FireStoreService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserRole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("lokasi").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                markers = {};
                for (var document in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  GeoPoint geopoint = data["loc_geo"];

                  String name = data["loc_name"];

                  data.addAll({'id': document.id});

                  var markerIdVal = document.id;
                  final MarkerId markerId = MarkerId(markerIdVal);
                  // creating a new MARKER
                  final Marker marker = Marker(
                    markerId: markerId,
                    position: LatLng(geopoint.latitude, geopoint.longitude),
                    //marker window
                    infoWindow: InfoWindow(
                      title: name,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => PlaceDetail(data: data)));
                      },
                    ),
                  );

                  // adding a new marker to map

                  markers[markerId] = marker;
                }
              }
              return Stack(children: [
                GoogleMap(
                  markers: Set<Marker>.of(markers.values),
                  mapType: MapType.terrain,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  initialCameraPosition: _kuantan,
                  onMapCreated: (GoogleMapController controller) {
                    _controllerGoogleMap.complete(controller);
                    newGoogleMapController = controller;
                    blackThemeGoogleMap();

                    //for black theme google  map
                  },
                )
              ]);
            }),
        floatingActionButton: Visibility(
          visible: visible,
          child: FloatingActionButton.extended(
            onPressed: () {
              Widget cancelButton = TextButton(
                child: const Text("Tidak"),
                onPressed: () {
                  Navigator.pop(context);
                },
              );
              Widget continueButton = TextButton(
                child: const Text("Ya"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddLocation()));
                },
              );

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: const Text("Tambah Lokasi"),
                content: const Text(
                  "Anda perlu berada di lokasi baharu yang ingin ditambah terlebih dahulu. Sila semak lokasi anda dengan menekan butang di penjuru atas kanan. Sudahkah anda berada di lokasi yang ingin ditambah?",
                  textAlign: TextAlign.justify,
                ),
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
            label: const Text("Tambah Lokasi"),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }

  checkUserRole() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!["role"].toString() == "panel") {
        visible = true;
      } else {
        visible = false;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }
}
