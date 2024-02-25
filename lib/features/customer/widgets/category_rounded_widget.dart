import 'package:flutter/material.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';
import 'package:shop/features/customer/screens/home/category/catigory.dart';

import '../../../config/colors/colors.dart';

// ignore: must_be_immutable
class CategoryRoundedWidget extends StatelessWidget {
  CategoryRoundedWidget({
    super.key,
    required this.image,
    required this.name,
    required this.state,
  });
  CustomerState state;
  final String image, name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CatycoryScreenProduct(catygory: name),
            ));
        ;
        //Navigator.pushNamed(context, SearchScreen.routeName, arguments: name);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kTextColor[state.theme],
              )),
        ],
      ),
    );
  }
}
