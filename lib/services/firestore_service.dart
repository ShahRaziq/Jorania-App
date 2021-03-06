import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FireStoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //user
  String error = "";
  Future<void> createUserData(
      String name, String userid, String email, String role) async {
    try {
      await _firebaseFirestore.collection("user").doc(userid).set({
        "email": email,
        "userid": userid,
        "name": name,
        "role": role,
        "favLoc": []
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

  //LOCATION
  Future<void> uploadLocationData(GeoPoint geo, String desc, String name,
      List<String> pic, String tips) async {
    await _firebaseFirestore.collection("lokasi").doc().set({
      "loc_desc": desc,
      "loc_geo": geo,
      "loc_name": name,
      "loc_pic": pic,
      "loc_tips": tips
    });
  }

  Future<void> updateLocationData(
      String desc, String name, String tips, String id, pics) async {
    await _firebaseFirestore.collection("lokasi").doc(id).update({
      "loc_desc": desc,
      "loc_name": name,
      "loc_tips": tips,
      "loc_pic": pics
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getdataLocation(
      String id) async {
    var data = await _firebaseFirestore.collection("lokasi").doc(id).get();
    return data;
  }

  //SERVICE
  Future<void> uploadServiceData(String name, String hari, String waktu,
      String tel, String desc, List<String> pic) async {
    await _firebaseFirestore.collection("servis_memancing").doc().set({
      "ser_name": name,
      "ser_hari": hari,
      "ser_waktu": waktu,
      "ser_tel": tel,
      "ser_desc": desc,
      "ser_pic": pic,
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getdataService(
      String id) async {
    var data =
        await _firebaseFirestore.collection("servis_memancing").doc(id).get();
    return data;
  }

  Future<void> updateServiceData(String name, String hari, String waktu,
      String tel, String desc, String id, pics) async {
    await _firebaseFirestore.collection("servis_memancing").doc(id).update({
      "ser_name": name,
      "ser_hari": hari,
      "ser_waktu": waktu,
      "ser_tel": tel,
      "ser_desc": desc,
      "ser_pic": pics
    });
  }
}
