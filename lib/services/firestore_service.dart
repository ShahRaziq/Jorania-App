import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String error = "";
  Future<void> createUserData(String name, String userid, String email, String role) async {
    try {
      await _firebaseFirestore.collection("user").doc(userid).set({
        "email": email,
        "userid": userid,
        "name": name,
        "role": role,
        
      });
    } catch (e) {
      log(e.toString());
      error = e.toString();
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getdata() async {
    var data = await _firebaseFirestore
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return data;
  }
}
