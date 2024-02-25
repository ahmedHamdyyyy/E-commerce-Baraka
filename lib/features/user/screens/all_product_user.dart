import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/constants/constance.dart';
import 'package:shop/config/services/assets_manager.dart';
import 'package:shop/config/widgets/cart_screen_empty.dart';
import 'package:shop/features/user/logic/user_cubit.dart';
import 'package:shop/features/user/widgets/Loding.dart';
import 'package:shop/features/user/widgets/body_search_list_all_products.dart';

import '../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../../home/screens/forgot_password/search_outline_input_border.dart';
import '../widgets/body_all_products.dart';

class AllProductUser extends StatelessWidget {
  const AllProductUser({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final userId = getit<UserCubit>().getId();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextFormField(
            style: TextStyle(color: kTextColor[0]),
            controller: controller,
            onChanged: (value) {
              getit<UserCubit>().search(controller.text);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: kTextColor[0].withOpacity(0.1),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              border: searchOutlineInputBorder,
              focusedBorder: searchOutlineInputBorder,
              enabledBorder: searchOutlineInputBorder,
              hintText: "Search product",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: InkWell(
                  onTap: () {
                    getit<UserCubit>().deleteSearch();
                    controller.clear();
                  },
                  child: const Icon(Icons.close)),
            ),
          ),
        ),
      ),
      body: BlocProvider.value(
        value: getit<UserCubit>()..getAllProductUser(userId),
        child: SafeArea(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return switch (state.searchProductsState) {
                Status.initial =>
                  state.getAllProductsUserState == Status.loading
                      ? Loading()
                      : BodyAllProducts(
                          state: state,
                        ),
                Status.loading => Loading(),
                Status.success => BodySearchListAllProducts(state: state),
                // TODO: Handle this case.
                Status.error => ScreenImpty(
                    imagePath: AssetsManager.errorImage,
                    text: "There was an Error")
              };
            },
          ),
        ),
      ),
    );
  }
}
