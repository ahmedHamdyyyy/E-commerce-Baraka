import 'package:flutter/material.dart';

import '../logic/customer_cubit.dart';
import '../screens/home/cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

// ignore: must_be_immutable
class HomeHeader extends StatelessWidget {
  HomeHeader({super.key, required this.state});
  CustomerState state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SearchField(
            state: state,
          )),
          const SizedBox(width: 8),
          IconBtnWithCounter(
            state: state,
            svgSrc: "assets/icons/Cart Icon.svg",
            numOfItem: state.carts.length,
            press: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                )),
          ),
          const SizedBox(width: 5),
          IconBtnWithCounter(
            state: state,
            svgSrc: "assets/icons/Bell.svg",
            press: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductScreen(),));
            },
          ),
        ],
      ),
    );
  }
}
