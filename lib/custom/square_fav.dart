import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.orange),
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ClipRRect(
                  child: Image.asset(
                    "asset/benteng.jpg",
                    width: 400.w,
                    height: 300.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Benteng Esplande',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ))),
                )
              ],
            )));
  }
}
