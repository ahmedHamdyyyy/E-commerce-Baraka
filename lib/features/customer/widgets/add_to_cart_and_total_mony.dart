// ignore_for_file: must_be_immutable

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../../../models/cart.dart';
import '../logic/customer_cubit.dart';
import '../screens/home/chat/chat_with_user.dart';

class AddTOCheckoutCard extends StatelessWidget {
  AddTOCheckoutCard(
      {super.key,
      required this.color,
      required this.state,
      required this.userId,
      required this.index});
  Color color;

  CustomerState state;
  String userId;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: checkOutCartColor[state.theme],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: foreGroundColor[state.theme],
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreenUser(
                          uIdUser: userId,
                        ),
                      )),
                  child: Text("Send him a message ",
                      style: TextStyle(color: kTextColor2[0])),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: checkOutCartColor[state.theme],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      style: TextStyle(
                        fontSize: 16,
                        color: kTextColor2[0],
                      ),
                      children: [
                        TextSpan(
                          text: state.product.productPrice.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: kTextColor2[0],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      getit<CustomerCubit>().addInUserCart(state.products[index].id, 1);
                    },
                    child: Text(
                      !getit<CustomerCubit>().
                      isProdinCart(productId: state.product.id)?   "add To Cart":"in  Cart",
                      style: TextStyle(color: kTextColor[state.theme]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
