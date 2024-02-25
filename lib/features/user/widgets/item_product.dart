import 'package:flutter/material.dart';

import '../../../models/Product.dart';

Widget itemProduct(
  ProductModel model,
) =>
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.images[0]),
                      height: 200,
                      width: double.infinity,
                    ),
                    if (model.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.red,
                        child: const Text(
                          "تخفيض",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  model.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${model.productPrice.round()}",
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (model.discount != 0)
                      Text(
                        "${model.discount.round()}",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          height: 1.3,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
