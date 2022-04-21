import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadFile(String path, File file) async {
    final ref = storageRef.child(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
