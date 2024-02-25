import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/widgets/cart_screen_empty.dart';
import 'package:shop/core/services/service_locator.dart';

import '../../../../../config/constants/constance.dart';
import '../../../../../config/widgets/empty_bag.dart';
import '../../../../user/widgets/Loding.dart';
import '../../../logic/customer_cubit.dart';
import '../../../widgets/grid_view_category_products.dart';
import '../../../widgets/list_Item_cart.dart';

import 'no_catygory_product.dart';

class CatycoryScreenProduct extends StatefulWidget {
  const CatycoryScreenProduct({super.key, required this.catygory});
  final String catygory;

  @override
  State<CatycoryScreenProduct> createState() => _CatycoryScreenProductState();
}

class _CatycoryScreenProductState extends State<CatycoryScreenProduct> {
  @override
  void initState() {
    getit<CustomerCubit>().getCategoryProducts(widget.catygory);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.catygory,
        style: TextStyle(
          fontSize: 20,
        ),
      )),
      body: RefreshIndicator(
        onRefresh: () async =>
            getit<CustomerCubit>().getCategoryProducts(widget.catygory),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
              child: BlocBuilder<CustomerCubit, CustomerState>(
                builder: (context, state) {
                  return state.getCategoryProductsStatus == Status.loading
                      ? Loading()
                      : state.categoryProducts.isNotEmpty
                          ? GridViewCategoryProducts(
                              state: state,
                            )
                          : NoCatigoryProduct();
                },
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
