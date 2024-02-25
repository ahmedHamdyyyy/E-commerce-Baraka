import 'package:flutter/material.dart';

import '../../customer/widgets/small_product_image.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    super.key,
    required this.images,
    required this.color,
  });

  final List<String> images;
  final Color color;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 238,
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
                image: widget.images[selectedImage],
                placeholder: 'assets/images/loading.gif',
              ),
            ),
          ),
        ),
        // SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  widget.images.length,
                  (index) => SmallProductImage(
                    color: widget.color,
                    isSelected: index == selectedImage,
                    press: () {
                      setState(() {
                        selectedImage = index;
                      });
                    },
                    image: widget.images[index],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
