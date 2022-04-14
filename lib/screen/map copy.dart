import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng SOURCE_LOCATION = LatLng(3.8170687016220435,
    103.33250841777334); //3.8170687016220435, 103.33250841777334
const LatLng DEST_LOCATION = LatLng(3.8170687016220435, 103.33250841777334);
const double CAMERA_ZOOM = 14;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();

  late LatLng currentLocation;
  late LatLng destinationLocation;

  @override
  void initState() {
    super.initState();

    // set up initial locations
    this.setInitialLocation();
    // set up the marker icons
    this.setSourceAndDestinationMarkerIcons();
  }

  void setSourceAndDestinationMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/imgs/source_pin_android.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/imgs/destination_pin.png');
  }

  void setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

    destinationLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    return Scaffold(
      body: Container(
          child: Center(
              child: GoogleMap(
        myLocationButtonEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: false,
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

          //for black map theme
        },
      ))),
    );
  }
}
