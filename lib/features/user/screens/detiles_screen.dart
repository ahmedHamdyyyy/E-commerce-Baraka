import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/constants/constance.dart';
import '../../../core/services/service_locator.dart';
import '../logic/user_cubit.dart';
import '../widgets/Loding.dart';
import '../widgets/app_bar_de.dart';
import '../widgets/detiles_screen_widget.dart';
import '../widgets/product_images.dart';

class DetailsProductUser extends StatefulWidget {
  const DetailsProductUser({super.key, required this.productId});

  final String productId;

  @override
  State<DetailsProductUser> createState() => _DetailsProductUserState();
}

class _DetailsProductUserState extends State<DetailsProductUser> {
  @override
  void initState() {
    super.initState();
    getit<UserCubit>().getProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<UserCubit>(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: const Color(0xFFF5F6F9),
            appBar: appBarDetialis(context),
            body: state.getProductStatus == Status.loading
                ? loading()
                : ListView(
                    children: [
                      ProductImages(
                          color: Colors.white10, images: state.product.images),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CartWidget(
                            productDescription: state.product.desc,
                            productName: state.product.productName,
                            price: state.product.productPrice.toDouble(),
                            discount: state.product.discount.toDouble()),
                      )

                    ],
                  ),
          );
        },
      ),
    );
  }

}
