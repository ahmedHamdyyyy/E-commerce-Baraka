import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/widgets/cart_screen_empty.dart';
import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../config/services/assets_manager.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../user/widgets/Loding.dart';
import '../../../logic/customer_cubit.dart';
import '../../../widgets/grid_view_fav.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<CustomerCubit>()..getFavoriteProducts(),
      child: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => getit<CustomerCubit>()
            ..getFavoriteProducts()
            ..getCustomer(getit<CustomerCubit>().getId()),
          child: BlocBuilder<CustomerCubit, CustomerState>(
            buildWhen: (previous, current) =>
                previous.favoritesProducts != current.favoritesProducts,
            builder: (context, state) {
              return Column(
                children: [
                  Text("Favorites",
                      style: TextStyle(
                          color: kTextColor[state.theme], fontSize: 20)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: state.getFavoriteProductsStatus == Status.loading
                          ? loading()
                          : state.favoritesProducts.isNotEmpty
                              ? gridViewFavorites(state)
                              : ScreenImpty(imagePath:  AssetsManager.wishlistSvg,  text: "NO Product added in Favorites")
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
