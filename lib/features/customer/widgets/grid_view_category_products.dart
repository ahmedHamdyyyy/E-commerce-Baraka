import 'package:flutter/material.dart';
import 'package:shop/features/customer/widgets/list_Item_cart.dart';

import '../logic/customer_cubit.dart';

class GridViewCategoryProducts extends StatelessWidget {
  GridViewCategoryProducts({
    super.key,
    required this.state
  });
  CustomerState state;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: state.categoryProducts.length,
      gridDelegate:
      const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 0.6,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) =>
          itemProductCatiogoryProduct(
              state, index, context),
    );
  }
}
