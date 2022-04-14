import 'package:flutter/material.dart';

class PlaceDetail extends StatelessWidget {
  final int index;

  PlaceDetail(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Place detail'),
        ),
        body: Center(
          child: Text('The details page for #$index'),
        ));
  }
}
