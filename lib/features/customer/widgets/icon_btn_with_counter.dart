import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';

import '../../../config/colors/colors.dart';

// ignore: must_be_immutable
class IconBtnWithCounter extends StatelessWidget {
  IconBtnWithCounter({
    super.key,
    required this.svgSrc,
    this.numOfItem = 0,
    this.width = 46,
    this.height = 46,
    required this.state,
    required this.press,
  });

  final String svgSrc;
  final int numOfItem;
  final double width;
  final double height;
  CustomerState state;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: kTextColor[0].withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              svgSrc,
              color: kTextColor[state.theme],
              width: 30,
              height: 30,
            ),
          ),
          //if (numOfItem != 0)
          Positioned(
            top: -3,
            right: 0,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: const Color(0xFFFF4848),
                shape: BoxShape.circle,
                border: Border.all(width: 1.5, color: Colors.white),
              ),
              child: Center(
                child: Text(
                  "$numOfItem",
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
