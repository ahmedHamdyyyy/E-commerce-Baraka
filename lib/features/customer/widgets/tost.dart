import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: non_constant_identifier_names
void showToast({required String text, required ToastState State}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(State),
        textColor: Colors.white,
        fontSize: 16.0);

// ignore: constant_identifier_names
enum ToastState { SUCCESS, ERROR, WARNING }

Color choseToastColor(ToastState saute) {
  Color color;
  switch (saute) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Color nameColor(String name) {
  Color color;
  switch (name) {
    case "a":
    case "ا":
      color = Colors.green;
      break;
    case "b":
    case "ب":
    case "E":
      color = Colors.redAccent;
      break;
    case "N":
      color = Colors.deepPurple;
      break;
    case "F":
    case "f":
    case "ف":
    case "ك":
    case "م":
    case "L":
    case "l":
      color = Colors.black87;
      break;
    case "s":
    case "س":
    case "ش":
    case "M":
      color = Colors.amberAccent;
      break;
    default:
      color = Colors.pinkAccent;
      break;
  }
  return color;
}
