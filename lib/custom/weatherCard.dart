import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherCard extends StatelessWidget {
  final String temp, location, weather, date, icon, city, state;

  const WeatherCard({
    Key? key,
    required this.date,
    required this.temp,
    required this.location,
    required this.weather,
    required this.icon,
    this.state = "",
    this.city = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool day = true;
    final now = DateTime.now();
    Color color() {
      log(now.toString());
      if (now.hour > 6 && now.hour < 19) {
        return Color.fromARGB(255, 65, 125, 180);
      }else{return Colors.white;}     
    }

    if (now.hour > 6 && now.hour < 19) {
      day = false;
    } else {
      day = true;
    }
    // print(MediaQuery.of(context).size.height.toString());
    //print(MediaQuery.of(context).size.width.toString());
    return Container(
      decoration: BoxDecoration(
          color: day ? Colors.grey : Color.fromARGB(255, 180, 222, 236),
          borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          Positioned(
            child: day
                ? Opacity(opacity: 0.6,
                  child: Image.asset(
                      "asset/night.png",
                      height: 200.h,
                    ),
                )
                : Opacity(opacity: 0.95,
                  child: Image.asset(
                    "asset/Group 3.png",
                     height: 220.h,
                    )
                    ),
            right: -3,
            top: -30,
          ),
          Container(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Text(
                  "$temp°",
                  style: TextStyle(fontSize: 70.sp, color: color()),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 100.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$date, ",
                              style: TextStyle(fontSize: 20.sp, color: color()),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 23.w,
                                  color: color(),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 181.w,
                                      child: Text(
                                        "$city,",
                                        style: TextStyle(
                                            fontSize: 20.sp, color: color()),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 181.w,
                                      child: Text(
                                        state,
                                        style: TextStyle(
                                            fontSize: 20.sp, color: color()),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Image.asset(
                          "asset/$icon.png",
                          height: 70.h,
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
