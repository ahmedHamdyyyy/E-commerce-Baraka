import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../../../config/colors/colors.dart';

class SmallProductImage extends StatefulWidget {
  const SmallProductImage(
      {super.key,
        this.isSelected,
        required this.press,
        required this.color,
        required this.image});

  final bool? isSelected;
  final VoidCallback press;
  final String image;
  final Color color;

  @override
  State<SmallProductImage> createState() => _SmallProductImageState();
}

class _SmallProductImageState extends State<SmallProductImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(8),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: primaryColor[1].withOpacity(widget.isSelected! ? 1 : 0)),
        ),
        child: Image.network(
          widget.image,
        ),
      ),
    );
  }
}
