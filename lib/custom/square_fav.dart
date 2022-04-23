import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Square extends StatefulWidget {
  final String name;
  final String imageURL;
  Square(this.name, this.imageURL);

  @override
  State<Square> createState() => _SquareState();
}

class _SquareState extends State<Square> {
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
                  child: Image.network(
                    widget.imageURL,
                    width: 400.w,
                    height: 300.h,
                    fit: BoxFit.cover,
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
                            widget.name,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ))),
                )
              ],
            )));
  }
}
