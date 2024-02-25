// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget loading() => const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: CircularProgressIndicator())],
    );
Widget noProduct() => const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Text(
          " ..لا يوجد منتجات لديك  برجاء الاضافه",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ))
      ],
    );
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Column(
      children: [
        SizedBox(
          height: size.height * 0.32,
        ),
        loading(),
      ],
    );
  }
}
