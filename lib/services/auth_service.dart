import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //log in
  String error = "";
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signIn(String email, String password) async {
    UserCredential? user;
    try {
      user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        error = 'Emel tidak sah. Sila masukkan emel yang sah!';
      } else if (e.code == "user-not-found") {
        error = 'Emel belum didaftar!';
      } else if (e.code == "wrong-password") {
        error = 'Kata laluan salah!';
      } else {
        error = "Sila isi butiran di atas dengan betul";
      }
      log(e.code);
    } catch (e) {
      print(e);
    }
    return user;
  }
  
   Future<String> signUp(String email, String password) async {
   
    try {
     await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      error= e.message!;

      if (e.code == "invalid-email") {
        error = 'Emel tidak sah. Sila masukkan emel yang sah!';
      } else if (e.code == "user-not-found") {
        error = 'Emel belum didaftar!';
      } else if (e.code == "wrong-password") {
        error = 'Kata laluan salah!';
      } else if (e.code == "email-already-in-use"){
        error = "Emel ini sudah digunakan";
      }else {
        error= "Masalah dijumpai";
      }
      log(e.code);
    } catch (e) {
      print(e);
    }
    return error;
  }


}
