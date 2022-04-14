import 'package:flutter/material.dart';

class ServiceDetail extends StatelessWidget {
  final int index;

  ServiceDetail(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Service detail'),
        ),
        body: Center(
          child: Text('The service detail for #$index'),
        ));
  }
}
