// ignore_for_file: must_be_immutable

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../logic/customer_cubit.dart';
import '../screens/home/chat/chat_with_user.dart';

class AddTOCheckoutCardFromSearch extends StatelessWidget {
  AddTOCheckoutCardFromSearch(
      {super.key,
      required this.color,
      required this.state,
      required this.index});
  Color color;

  CustomerState state;
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
                          uIdUser: state.product.userId,
                        ),
                      )),
                  child: Text("Send him a message",
                      style: TextStyle(
                          color: kTextColor[state.theme], fontSize: 16)),
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
                        color: kTextColor[state.theme],
                      ),
                      children: [
                        TextSpan(
                          text: state.product.productPrice.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: kTextColor[state.theme],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (getit<CustomerCubit>()
                          .isProdinCart(productId: state.product.id)) {
                        return;
                      }
                      getit<CustomerCubit>().addInUserCart(
                        state.searchProduct[index].id,
                        1,
                      );
                    },
                    child: Text(
                      !getit<CustomerCubit>()
                              .isProdinCart(productId: state.product.id)
                          ? "add To Cart"
                          : "in  Cart",
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
