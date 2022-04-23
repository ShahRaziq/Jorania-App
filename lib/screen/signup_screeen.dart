import 'package:Jorania/providers/place_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:Jorania/screen/login_screen.dart';
import 'package:Jorania/services/auth_service.dart';
import 'package:Jorania/services/firestore_service.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //formkey
  final _formKey = GlobalKey<FormState>();
  //default role =user
  String role = "user";
  //editting Controller
  final nameController = new TextEditingController();
  final emelController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();

  AuthService authService = AuthService();
  FireStoreService fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);

    place.setPlace(widget);
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/Jorania.png",
                  height: 250,
                ),
                SizedBox(height: 20),
                //nama user field
                TextFormField(
                  controller: nameController,
                  autofocus: false,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.name,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("Sila isi butiran nama");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("masukkan minimum 3 huruf");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_circle),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                //emel field
                TextFormField(
                  controller: emelController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Sila isi butiran emel");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Sila masukkan emel yang sah");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emelController.text = value!;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText: 'Emel',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                //kata laluan field
                TextFormField(
                  controller: passwordController,
                  autofocus: false,
                  cursorColor: Colors.white,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Sila isi butiran kata laluan");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Masukkan minima 6 digit/huruf");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText: 'Kata laluan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                //pengesahan kata laluan field
                TextFormField(
                  controller: confirmPasswordController,
                  autofocus: false,
                  obscureText: true,
                  cursorColor: Colors.white,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (confirmPasswordController.text !=
                        passwordController.text) {
                      return "Kata laluan tidak sepadan";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    confirmPasswordController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                    labelText: 'Pengesahan kata laluan',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 20),
                //LOG MASUK button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      primary: Color(0xffFE8C4A)),
                  icon: Icon(Icons.app_registration, size: 32),
                  label: Text(
                    'DAFTAR',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    // EasyLoading.showSuccess('Pendaftaran akaun berjaya!');
                    authService
                        .signUp(emelController.text, passwordController.text)
                        .then((value) {
                      if (value != "") {
                        EasyLoading.showError(authService.error);
                      } else {
                        EasyLoading.show();
                        fireStoreService
                            .createUserData(
                                nameController.text,
                                FirebaseAuth.instance.currentUser!.uid,
                                emelController.text,
                                role)
                            .then((value) {
                          EasyLoading.showSuccess('Pendaftaran akaun berjaya!');
                          EasyLoading.dismiss();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => LoginScreen()));
                        });
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 19,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Sudah mendaftar?"),
                  TextButton(
                      onPressed: () {
                        //button to new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Log masuk ",
                        style: TextStyle(color: Color(0xff375DBF)),
                      ))
                ]),
              ],
            ),
          )),
    );
  }
}
