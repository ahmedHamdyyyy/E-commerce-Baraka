import 'package:flutter/material.dart';

import '../../../../../config/widgets/empty_bag.dart';

class NoCatigoryProduct extends StatelessWidget {
  NoCatigoryProduct({
    super.key,


  });

  @override
  Widget build(BuildContext context) {
    return EmptyBagWidget(
        imagePath: "assets/images/blob.jpg",
        title: "This category has no products ");




  }
}