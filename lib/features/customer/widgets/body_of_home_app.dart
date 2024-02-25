import 'package:flutter/material.dart';
import 'package:shop/features/customer/widgets/special_offers.dart';

import 'discount_banner.dart';
import 'item_products.dart';

Column BodyOfHomeApp() {
  return Column(
    children: [
      DiscountBanner(),
      // Categories(),
      SpecialOffers(),
      SizedBox(height: 15),
      ItemProducts(),
      SizedBox(height: 15),
    ],
  );
}