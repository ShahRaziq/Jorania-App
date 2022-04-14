import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_icons/weather_icons.dart';

class Weather extends StatelessWidget {
  final String temp, location, weather, date;

  const Weather({
    Key? key,
    required this.date,
    required this.temp,
    required this.location,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height.toString());
    //print(MediaQuery.of(context).size.width.toString());
    return Container(
      decoration: BoxDecoration(
          color: weather == "rainy" ? Colors.grey : Color(0xff72D6F8),
          borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          Positioned(
            child: weather == "rainy"
                ? Image.asset(
                    "asset/rain.png",
                    height: 200.h,
                  )
                : Image.asset("asset/Group 3.png"),
            right: 0,
            top: -20,
          ),
          Container(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Text(
                  "27°",
                  style: TextStyle(fontSize: 70.sp, color: Colors.white),
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
                              "Jumaat, 15 April, ",
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.white),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 23.w,
                                  color: Colors.white,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Inderapura, Kuantan",
                                      style: TextStyle(
                                          fontSize: 20.sp, color: Colors.white),
                                    ),
                                    Text(
                                      "Pahang",
                                      style: TextStyle(
                                          fontSize: 20.sp, color: Colors.white),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Icon(
                          weather == "rainy"
                              ? Icons.cloud_outlined
                              : Icons.wb_sunny_outlined,
                          size: 70.w,
                          color: Colors.white,
                        ),
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
