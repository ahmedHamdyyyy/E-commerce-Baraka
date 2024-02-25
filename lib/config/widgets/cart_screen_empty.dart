import 'package:flutter/material.dart';

import 'empty_bag.dart';

// ignore: must_be_immutable
class ScreenImpty extends StatelessWidget {
  ScreenImpty({super.key, required this.imagePath, required this.text});
  String imagePath, text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EmptyBagWidget(imagePath: imagePath, title: text),
      ),
    );
  }
}
