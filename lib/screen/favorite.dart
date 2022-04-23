import 'dart:developer';

import 'package:Jorania/screen/place.dart';
import 'package:Jorania/services/firestore_service.dart';
import 'package:Jorania/services/weather_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Jorania/custom/square_fav.dart';
import 'package:Jorania/screen/place.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    log("message1");
  }

  List<Map<String, dynamic>> locations = [];

  @override
  Widget build(BuildContext context) {
    log("message");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        automaticallyImplyLeading: false,
        title: Text('Lokasi Kegemaran'),
      ), // AppBar
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: loading
                ? SizedBox(
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator()))
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: locations.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) =>
                                      PlaceDetail(data: locations[index])));
                        },
                        child: Square(
                            locations[index]["loc_name"],
                            (locations[index]["loc_pic"] as List<dynamic>)
                                .first),
                      );
                    })),
          )
        ],
      ),
    );

    // Scaffold
  }

  Future getData() async {
    var data = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    List<dynamic> favloc = data.data()!["favLoc"];
    for (int i = 0; i <= favloc.length; i++) {
      if (i == favloc.length) {
        loading = false;

        if (mounted) {
          setState(() {});
        }
        break;
      }
      var loc = await FirebaseFirestore.instance
          .collection("lokasi")
          .doc(favloc[i])
          .get();
      loc.data()!.addAll({"id": loc.id});
      Map<String, dynamic> o = loc.data()!;
      o.addAll({"id": favloc[i]});
      locations.add(o);
    }
  }
}
