import 'package:flutter/material.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';
import 'package:shop/features/user/logic/user_cubit.dart';

AppBar appBarChat(CustomerState state) {
  return AppBar(
    elevation: 1,
    titleSpacing: 0,
    title: Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
          state.user.shopName,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

AppBar appBarChatUser(UserState state) {
  return AppBar(
    elevation: 1,
    titleSpacing: 0,
    title: Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
          state.customer.name,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}
