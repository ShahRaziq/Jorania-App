import 'package:Jorania/providers/place_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:Jorania/screen/login_screen.dart';
import 'package:Jorania/services/auth_service.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final emelController = TextEditingController();

  AuthService authService = AuthService();
  @override
  void dispose() {
    emelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var place = Provider.of<PlaceProvider>(context);
    place.place = widget;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Tetapan semula kata laluan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "asset/Jorania.png",
                  height: 300,
                ),
                const Text(
                  'Terima emel untuk menetapkan semula kata laluan anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.purple),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emelController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Emel',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
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
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      primary: const Color(0xffFE8C4A),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    icon: const Icon(Icons.email),
                    label: const Text(
                      'Tetap semula kata laluan',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if (emelController.text == "") {
                        EasyLoading.showError('Sila isi butiran emel');
                      } else {
                        resetPassword();
                      }
                    }),
                const SizedBox(height: 30),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Kembali ke"),
                  TextButton(
                      onPressed: () {
                        //button to new screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Log masuk ",
                        style: TextStyle(color: Color(0xff375DBF)),
                      ))
                ]),
              ],
            )),
      ),
    );
  }

  Future resetPassword() async {
    String error = "";

    EasyLoading.show(status: 'sedang diproses..');

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emelController.text.trim());

      EasyLoading.showSuccess('Penetapan semula kata laluan telah dihantar');
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      print(e);
      e.toString();

      EasyLoading.showToast(error);
      Navigator.of(context).pop();
    }
  }
}
