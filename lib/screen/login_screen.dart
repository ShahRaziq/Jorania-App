import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:Jorania/screen/forgot_password.dart';

import 'package:Jorania/screen/nav_bar.dart';
import 'package:Jorania/screen/signup_screeen.dart';
import 'package:Jorania/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "asset/Jorania.png",
                    height: 400,
                  ),
                  SizedBox(height: 20),
                  //emel field
                  TextFormField(
                    controller: emailController,
                    autofocus: false,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Sila masukkan emel yang sah'
                            : null,
                    onSaved: (value) {
                      emailController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
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
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'masukkan minimum 6 digit/huruf'
                        : null,
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      labelText: 'Kata laluan',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),

                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        primary: Color(0xffFE8C4A)),
                    icon: Icon(Icons.login, size: 32),
                    label: Text(
                      'LOG MASUK',
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      EasyLoading.show(status: "Sedang log masuk");
                      authService
                          .signIn(emailController.text, passwordController.text)
                          .then((value) {
                        if (value == null) {
                          EasyLoading.showError(authService.error);
                        } else {
                          EasyLoading.showToast('Selamat kembali!');
                          EasyLoading.dismiss();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => NavBar()));
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 19,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Baru di aplikasi ini?"),
                    TextButton(
                        onPressed: () {
                          //button to signup screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Text(
                          "Daftar masuk",
                          style: TextStyle(color: Color(0xff375DBF)),
                        ))
                  ]),
                  GestureDetector(
                    child: Text('Lupa kata laluan?',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xff375DBF),
                      fontWeight: FontWeight.bold,
                      
                    ),
                    ),
                    onTap: (){
                      Navigator.push(context,
                       MaterialPageRoute(builder: (c)=>ForgotPassword()));
                    },
                  ),
                ],
              ),
            )),
      );
}