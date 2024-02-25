import 'package:flutter/material.dart';

import '../../../config/services/my_app_functions.dart';
import '../logic/customer_cubit.dart';

AppBar appBarCart(CustomerState state,BuildContext context){
  return AppBar(
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
            onPressed: () {
              MyAppFunctions.showDeleteCartgDialog(
                  state: state,
                  context: context, subtitle: " Do you want delete all \n of products in Cart ? ", fct: (){});
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 35,
            )),
      )
    ],
    title: Column(
      children: [
        const Text(
          "Your Cart",
        ),
        Text(
          "${state.cartsProducts.length} items",
          //style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}