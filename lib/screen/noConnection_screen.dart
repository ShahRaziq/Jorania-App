import 'package:Jorania/providers/place_provider.dart';
import 'package:Jorania/screen/nav_bar.dart';
import 'package:Jorania/screen/place.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NoConScreen extends StatefulWidget {
  const NoConScreen({Key? key}) : super(key: key);

  @override
  State<NoConScreen> createState() => _NoConScreenState();
}

class _NoConScreenState extends State<NoConScreen> {
  var subscription;

  @override
  initState() {
    super.initState();
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result != ConnectivityResult.none) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => place.place!));
      }
    });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("asset/nocon.jpg"),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Tiada Sambungan ',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      )),
                  TextSpan(
                      text: 'Internet!',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 133, 123, 124),
                      )),
                  TextSpan(
                      text: ' Sila pastikan anda mempunyai sambungan ',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      )),
                  TextSpan(
                      text: 'Internet!',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 133, 123, 124),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
