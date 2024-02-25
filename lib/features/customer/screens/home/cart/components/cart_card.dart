// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop/core/services/service_locator.dart';
import 'package:shop/features/customer/screens/home/cart/components/quantity_bottom_sheet_widget.dart';
import 'package:shop/models/cart_model.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../logic/customer_cubit.dart';

class CartCard extends StatefulWidget {
  CartCard({
    super.key, // Add the "Key" type and fix the parameter name
    required this.state,
    required this.cartModel,
  });

  CartModelCustomer cartModel;
  CustomerState state;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    final cart =
        getit<CustomerCubit>().findByProductId(widget.cartModel.productId);

    return Row(
      children: [
        SizedBox(
          width: 90,
          child: AspectRatio(
            aspectRatio: 0.89,
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: foreGroundColor[widget.state.theme],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    height: 100,
                    width: double.infinity,
                    image: cart!.images[0],
                    placeholder: 'assets/images/loading.gif',
                  ),
                )),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cart.productName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16, color: kTextColor[widget.state.theme]),
                    maxLines: 3,
                  ),
                  IconButton(
                      onPressed: () {
                        getit<CustomerCubit>().removeCartItemFromFirestore(
                            cartId: widget.cartModel.cartId,
                            productId: widget.cartModel.productId,
                            qty: widget.cartModel.quantity);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                      await showModalBottomSheet(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return QuantityBottomSheetWidget(
                            state: widget.state,
                            // index: widget.index,
                            cartModel: widget.cartModel,
                            //cartModel: cartModel,
                          );
                        },
                      );
                    },
                    icon: const Icon(IconlyLight.arrowDown2),
                    label: Text("Qty: ${widget.cartModel.quantity}"),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "\$${cart.productPrice}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kTextColor[widget.state.theme],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
