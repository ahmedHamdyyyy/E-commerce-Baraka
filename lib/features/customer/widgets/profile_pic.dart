import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/colors/colors.dart';

// ignore: must_be_immutable
class ProfilePic extends StatelessWidget {
  ProfilePic({
    super.key,
    required this.color,
    required this.colorIcon,
  });
  Color color, colorIcon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: color,
            backgroundImage:
                const AssetImage("assets/images/Profile Image.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: colorIcon,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: color),
                  ),
                  backgroundColor:  primaryColor[0],
                ),
                onPressed: () {},
                child: SvgPicture.asset(
                  // color:color ,
                  "assets/icons/Camera Icon.svg",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
