
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Jorania/splachScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(480.0, 965.3333333333334),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
         theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: MySplashScreen(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

