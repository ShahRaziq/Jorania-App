import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:like_button/like_button.dart';

class PlaceDetail extends StatelessWidget {
  final Map<String, dynamic> data;

  PlaceDetail({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(data["loc_pic"].runtimeType.toString());
    List<dynamic> picUrl = data["loc_pic"];
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.grey[700],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      //edit
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Sunting"),
        icon: const Icon(Icons.edit),
        backgroundColor: Colors.orangeAccent,
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(20.w),
                  height: 250.h,
                  width: 500.w,
                  // color: Color.fromARGB(255, 163, 130, 130),
                  child: CarouselSlider(
                    options: CarouselOptions(height: 500.0),
                    items: picUrl.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(i);
                        },
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.add_a_photo),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Benteng Nezuko',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 157, 10),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 19.w),
                          Text(
                            'Suka',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 3.w),
                          LikeButton(
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                Icons.star,
                                size: 33.sp,
                                color:
                                    isLiked ? Colors.yellow : Colors.grey[400],
                              );
                            },
                          ),
                          SizedBox(width: 7),
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
              padding: EdgeInsets.all(16),
              child: Container(
                height: 300.h,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Lokasi memancing yang menjadi tumpuan orang ramai terutamanya pada malam minggu. Lokasi bersih dan selesa. jhsajdhskajdhkjshdjkashdkjhsjd jdhkajshdkja joirejvcvbn fjoiwjeofinsccv nihwihgohdjsnfjsnjhnfew./?fsjfoihwfuif',
                    style: TextStyle(),
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
                Text(
                  'Tips',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            //content tips
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Lokasi memancing yang menjadi tumpuan orang ramai terutamanya pada malam minggu. Lokasi bersih dan selesa. jhsajdhskajdhkjshdjkashdkjhsjd jdhkajshdkja joirejvcvbn fjoiwjeofinsccv nihwihgohdjsnfjsnjhnfew./?fsjfoihwfuif',
                    style: TextStyle(),
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
                        minimumSize: Size(50, 50),
                        primary: Colors.deepOrange[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(13))),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.directions,
                          size: 30,
                        ),
                        SizedBox(
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
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
