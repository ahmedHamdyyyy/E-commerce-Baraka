// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/widgets/cart_screen_empty.dart';
import 'package:shop/core/services/service_locator.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';

import '../../../../config/constants/constance.dart';
import '../../../user/widgets/Loding.dart';
import '../../widgets/grid_view_item_products.dart';

class AllProductCustomerScreen extends StatefulWidget {
  AllProductCustomerScreen({super.key, required this.state});

  CustomerState state;

  @override
  State<AllProductCustomerScreen> createState() =>
      _AllProductCustomerScreenState();
}

class _AllProductCustomerScreenState extends State<AllProductCustomerScreen> {
  @override
  void initState() {
    getit<CustomerCubit>().getAllProducts();

    super.initState();
  }

  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => getit<CustomerCubit>().getAllProducts(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
          child: BlocBuilder<CustomerCubit, CustomerState>(
            //buildWhen: (previous, current) => previous.products !=current.products,
            builder: (context, state) {
              return state.getAllProductsStatus == Status.loading
                  ? Loading()
                  : state.products.isNotEmpty
                      ? GridViewItemProducts(
                          state: state,
                        )
                      : ScreenImpty(
                          imagePath: "assets/images/blob.jpg",
                          text: "No products Found");
            },
          ),
        ),
      ),
    );
  }
}
