import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/user/widgets/Loding.dart';
import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';

import '../../../../../core/services/service_locator.dart';
import '../../../../home/screens/forgot_password/search_outline_input_border.dart';
import '../../../logic/customer_cubit.dart';
import '../../../widgets/body_of_home_app.dart';
import '../../../widgets/icon_btn_with_counter.dart';
import '../../../widgets/search_view_list.dart';
import '../cart/cart_screen.dart';

class AllOffersCustomer extends StatelessWidget {
  AllOffersCustomer({super.key});
  final control = TextEditingController();
  final uId = getit<CustomerCubit>().getId();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<CustomerCubit>()..getCartCustomer(uId),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => getit<CustomerCubit>().getCartCustomer(uId),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BlocBuilder<CustomerCubit, CustomerState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextFormSearchProduct(control: control, state: state),
                          const SizedBox(width: 8),
                          IconBtnWithCounter(
                            state: state,
                            svgSrc: "assets/icons/Cart Icon.svg",
                            numOfItem: state.cartsProducts.length,
                            press: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                )),
                          ),
                          const SizedBox(width: 5),
                          IconBtnWithCounter(
                            state: state,
                            svgSrc: "assets/icons/Bell.svg",
                            press: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductScreen(),));
                            },
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CustomerCubit, CustomerState>(
                      builder: (context, state) {
                        return switch (state.searchProductsState) {
                          Status.initial => BodyOfHomeApp(),
                          Status.loading => Loading(),
                          Status.success => ListSearchViw(
                              state: state,
                            ),
                          Status.error => Text("Error In Server"),
                        };
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextFormSearchProduct extends StatelessWidget {
  TextFormSearchProduct({
    super.key,
    required this.control,
    required this.state,
  });
  CustomerState state;

  final TextEditingController control;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextFormField(
      style: TextStyle(color: kTextColor[state.theme]),
      controller: control,
      onChanged: (value) {
        getit<CustomerCubit>().search(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: kTextColor[state.theme].withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        border: searchOutlineInputBorder,
        focusedBorder: searchOutlineInputBorder,
        enabledBorder: searchOutlineInputBorder,
        hintText: "Search product",
        prefixIcon: const Icon(Icons.search),
        suffixIcon: InkWell(
            onTap: () {
              getit<CustomerCubit>().deleteSearch();
              control.clear();
            },
            child: const Icon(Icons.close)),
      ),
    ));
  }
}
