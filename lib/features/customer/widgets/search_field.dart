import 'package:flutter/material.dart';

import '../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../../home/screens/forgot_password/search_outline_input_border.dart';
import '../logic/customer_cubit.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key, required this.state});
  final CustomerState state;
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: kTextColor[state.theme]),
      controller: nameController,
      onFieldSubmitted: (value) {
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
              nameController.clear();
            },
            child: const Icon(Icons.close)),
      ),
    );
  }
}
