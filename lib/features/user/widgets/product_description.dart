import 'package:flutter/material.dart';

import '../../../config/colors/colors.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    super.key,
    required this.desc,
    required this.name,
    required this.price,
    this.pressOnSeeMore,
  });

  final String desc;
  final String name;
  final String price;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(color: Colors.black)),
              const Spacer(),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    style: TextStyle(
                      fontSize: 16,
                      color: kTextColor[0],
                    ),
                    children: [
                      TextSpan(
                        text: price,
                        style: TextStyle(
                          fontSize: 16,
                          color: kTextColor[0],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
          ),
          child: Text(
            desc,
            style: const TextStyle(color: Colors.black),
            maxLines: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: primaryColor[1]),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: primaryColor[1],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
