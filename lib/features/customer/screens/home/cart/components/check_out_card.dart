import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/core/services/service_locator.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../logic/customer_cubit.dart';

// ignore: must_be_immutable
class CheckoutCard extends StatelessWidget {
  CheckoutCard({
    super.key,
    required this.color,
  });

  Color color;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
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
                    Text("Send Order", style: TextStyle(color: kTextColor[1])),
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
                            color: kTextColor[1],
                          ),
                          children: [
                            TextSpan(
                              text: /*state.qty.toString()*/
                                  "\$${getit<CustomerCubit>().getTotal().toString()}",
                              style: TextStyle(
                                fontSize: 16,
                                color: kTextColor[1],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Check Out",
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
      },
    );
  }
}
