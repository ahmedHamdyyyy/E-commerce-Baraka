import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class ErrorHandler {
  Future<dynamic> future(Future<dynamic> method) async {
    try {
      return await method;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  dynamic normal(dynamic method) {
    try {
      return method;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
