import 'package:flutter/material.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';
import 'package:shop/features/customer/widgets/list_Item_cart.dart';

class GridViewItemProducts extends StatelessWidget {
  const GridViewItemProducts({
    super.key,
    required this.state,
  });
  final CustomerState state;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: state.products.length,
      gridDelegate:
      const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 0.6,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) => itemProducts(state, index, context),
    );
  }
}
