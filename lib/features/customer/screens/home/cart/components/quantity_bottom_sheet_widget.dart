import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/colors/colors.dart';
import 'package:shop/core/services/service_locator.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';
import 'package:shop/models/cart_model.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  QuantityBottomSheetWidget(
      {super.key, required this.cartModel, required this.state});

  // final CartModelCustomer cartModel;
  final CartModelCustomer cartModel;
  final CustomerState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 25,
              itemBuilder: (context, index) {
                return BlocBuilder<CustomerCubit, CustomerState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        getit<CustomerCubit>().updateQtyCart(
                          CartModelCustomer(
                              cartId: cartModel.cartId,
                              productId: cartModel.productId,
                              quantity: index + 1),
                        );
                        Navigator.pop(context);
                      },
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: kTextColor[state.theme],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,

                            //color: Colors.black,
                          ),
                        ),
                      )),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
