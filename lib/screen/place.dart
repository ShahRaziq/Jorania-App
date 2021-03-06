import 'dart:developer';

import 'package:Jorania/providers/place_provider.dart';
import 'package:Jorania/screen/editLocation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:like_button/like_button.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatefulWidget {
  final Map<String, dynamic> data;

  const PlaceDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  bool visible = false;
  List<dynamic>? picUrl;
  bool liked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserRole();
    picUrl = widget.data["loc_pic"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    place.place = widget;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: visible,
        child: FloatingActionButton.extended(
          heroTag: 'kemaskini_lokasi_hero',
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => EditLocation(id: widget.data["id"])));
          },
          label: const Text("kemaskini"),
          icon: const Icon(Icons.edit),
          backgroundColor: Colors.orange,
        ),
      ),
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('asset/heading.png', height: 80.h),
          SizedBox(
            width: 30.w,
          )
        ]),
        foregroundColor: Colors.grey[700],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),

              // color: Color.fromARGB(255, 163, 130, 130),
              child: CarouselSlider(
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    height: 250.0),
                items: picUrl!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        i,
                        fit: BoxFit.cover,
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    widget.data["loc_name"],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),

                //edit button

                //star button
                Container(
                    height: 50.h,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 157, 10),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 19.w),
                          const Text(
                            'Suka',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 3.w),
                          FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<dynamic> favLocation =
                                      snapshot.data!['favLoc'];

                                  favLocation.contains(widget.data['id'])
                                      ? liked = true
                                      : liked = false;
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                return LikeButton(
                                  isLiked: liked,
                                  onTap: onLikeButtonTapped,
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.star,
                                      size: 33.sp,
                                      color: isLiked
                                          ? Colors.yellow
                                          : Colors.grey[400],
                                    );
                                  },
                                );
                              }),
                          const SizedBox(width: 7),
                        ])),
                SizedBox(
                  width: 20.w,
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),

            //content keterangan
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.data["loc_desc"],
                    style: const TextStyle(),
                  ),
                ),
              ),
            ),

            //header tips
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30.w,
                ),
                const Text(
                  'Tips',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            //content tips
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    widget.data["loc_tips"],
                    style: const TextStyle(),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            //button GPS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50),
                        primary: Colors.deepOrange[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13))),
                    onPressed: () async {
                      if (await MapLauncher.isMapAvailable(MapType.google) !=
                          null) {
                        await MapLauncher.showMarker(
                          mapType: MapType.google,
                          coords: Coords(
                              (widget.data['loc_geo'] as GeoPoint).latitude,
                              (widget.data['loc_geo'] as GeoPoint).longitude),
                          title: widget.data['loc_name'],
                          description: widget.data['loc_desc'],
                        );
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.directions,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Arah GPS',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        )
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    var data = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    log(data.toString());
    List<dynamic> favoriteLocation = data['favLoc'];
    if (isLiked) {
      favoriteLocation.remove(widget.data['id']);
    } else {
      favoriteLocation.add(widget.data['id']);
    }
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favLoc': favoriteLocation});

    return !isLiked;
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
      setState(() {});
    });
  }
}
