import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final String child;
  Square({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
            height: 200,
            color: Colors.amberAccent[200],
            child: Center(
              child: Text(
                child,
                style: TextStyle(fontSize: 40),
              ),
            )));
  }
}
