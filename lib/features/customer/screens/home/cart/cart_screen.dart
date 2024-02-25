import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/widgets/cart_screen_empty.dart';
import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../user/widgets/Loding.dart';
import '../../../logic/customer_cubit.dart';
import '../../../widgets/app_bar_cart.dart';
import '../AllOffers/details_screen_from_cart.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String customerId = getit<CustomerCubit>().getId();
  @override
  void initState() {
    getit<CustomerCubit>().getCustomer(customerId);
    // getit<CustomerCubit>().getCartsProduct(customerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<CustomerCubit>()
        ..getCartCustomer(getit<CustomerCubit>().getId()),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        // buildWhen: (previous, current) =>previous.cartsProducts !=current.cartsProducts || previous.updateCustomerState !=current.updateCustomerState ,
        builder: (context, state) {
          return state.cartsProducts.isEmpty
              ? ScreenImpty(
                  imagePath: "assets/images/cartImpty.jpg",
                  text: "Your cart is empty 💔",
                )
              : Scaffold(
                  appBar: appBarCart(state, context),
                  body: RefreshIndicator(
                      onRefresh: () async => getit<CustomerCubit>()
                          .getCartCustomer(getit<CustomerCubit>().getId()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: state.deleteCartProductState == Status.loading
                            ? Loading()
                            : ListView.builder(
                                itemCount: state.cartsProducts.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Dismissible(
                                      direction: DismissDirection.horizontal,
                                      background:
                                          const LinearProgressIndicator(),
                                      key: Key(state.cartsProducts.values
                                          .toList()[index]
                                          .cartId),
                                      onDismissed: (direction) =>
                                          getit<CustomerCubit>()
                                              .removeCartItemFromFirestore(
                                                  cartId:
                                                      state
                                                          .cartsProducts.values
                                                          .toList()[index]
                                                          .cartId,
                                                  productId: state
                                                      .cartsProducts.values
                                                      .toList()[index]
                                                      .productId,
                                                  qty: state
                                                      .cartsProducts.values
                                                      .toList()[index]
                                                      .quantity),
                                      child: InkWell(onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreenFromCart(
                                                index: index,
                                                productId: state
                                                    .cartsProducts.values
                                                    .toList()[index]
                                                    .productId,
                                              ),
                                            ));
                                      }, child: BlocBuilder<CustomerCubit,
                                          CustomerState>(
                                        builder: (context, state) {
                                          return CartCard(
                                            cartModel: state
                                                .cartsProducts.values
                                                .toList()[index],
                                            state: state,
                                          );
                                        },
                                      ))),
                                ),
                              ),
                      )),
                  bottomNavigationBar: CheckoutCard(
                    color: foreGroundColor[state.theme],
                  ));
        },
      ),
    );
  }
}
