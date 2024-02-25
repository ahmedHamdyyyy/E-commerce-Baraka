import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/firebase_options.dart';

class ApiServices {
  late FirebaseAuth auth;
  late FirebaseStorage storage;
  late FirebaseFirestore fireStore;
  Future<bool> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      auth = FirebaseAuth.instance;
      storage = FirebaseStorage.instance;
      fireStore = FirebaseFirestore.instance;
      return true;
    } on Exception catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }
}
