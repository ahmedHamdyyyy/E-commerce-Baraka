import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../logic/customer_cubit.dart';
import '../screens/home/AllOffers/details_screen_product.dart';

GridView gridViewCatigory(CustomerState state) {
  return GridView.builder(
    itemCount: state.categoryProducts.length,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 0.7,
      mainAxisSpacing: 20,
      crossAxisSpacing: 16,
    ),
    itemBuilder: (context, index) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kTextColor[state.theme].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreenProduct(
                          index: index,
                          productId: state.categoryProducts[index].id,
                        ),
                      ));
                },
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.fill,
                  height: 100,
                  image: state.categoryProducts[index].images[0],
                  placeholder: 'assets/images/loading.gif',
                )),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          style: TextStyle(
            color: kTextColor[state.theme],
          ),
          state.categoryProducts[index].productName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${state.categoryProducts[index].productPrice.toString()}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kTextColor[state.theme],
              ),
            ),
            InkWell(
              onTap: () {
               /* getit<CustomerCubit>().addInCart(CartModel(
                    id: "",
                    name: state.favoritesProducts[index].productName,
                    image: state.favoritesProducts[index].images[0],
                    productId: state.favoritesProducts[index].id,
                    customerId: getit<CustomerCubit>().getId(),
                    count: state.favoritesProducts[index].productPrice));*/
              },
              child: SvgPicture.asset(
                "assets/icons/Cart Icon.svg",
                width: 23,
                height: 23,
              ),
            ),
            InkWell(
              onTap: () => getit<CustomerCubit>()
                  .deleteFavorite(state.favoritesProducts[index].id),
              child: Container(
                padding: const EdgeInsets.all(6),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: kTextColor[state.theme].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  colorFilter: const ColorFilter.mode(
                      Color(0xFFFF4848), BlendMode.srcIn),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

GridView gridViewFavorites(CustomerState state) {
  return GridView.builder(
    itemCount: state.favoritesProducts.length,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 0.7,
      mainAxisSpacing: 25,
      crossAxisSpacing: 20,
    ),
    itemBuilder: (context, index) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.20,

          child: Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: kTextColor[state.theme].withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreenProduct(
                          index: index,
                          productId: state.favoritesProducts[index].id,
                        ),
                      ));
                },
                child:   ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),

                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.fill,

                    image: state.favoritesProducts[index].images[0],
                    placeholder: 'assets/images/loading.gif',
                  ),
                )),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          style: TextStyle(
            color: kTextColor[state.theme],
          ),
          state.favoritesProducts[index].productName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${state.favoritesProducts[index].productPrice.toString()}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kTextColor[state.theme],
              ),
            ),
            InkWell(
              onTap: () {

                getit<CustomerCubit>().addInUserCart(state.favoritesProducts[index].id, 1);
             /*   getit<CustomerCubit>().addInCart(CartModel(
                    id: "",
                    name: state.favoritesProducts[index].productName,
                    image: state.favoritesProducts[index].images[0],
                    productId: state.favoritesProducts[index].id,
                    customerId: getit<CustomerCubit>().getId(),
                    count: state.favoritesProducts[index].productPrice));
             */ },
              child: !getit<CustomerCubit>().isProdinCart(productId: state.favoritesProducts[index].id)? SvgPicture.asset(
                "assets/icons/Cart Icon.svg",
                width: 28,
                color: kTextColor[state.theme],
                height: 28,
              ):SvgPicture.asset(
                "assets/icons/Check mark rounde.svg",
                width: 32,
                height: 32,
              ),
            ),
            InkWell(
              onTap: () => getit<CustomerCubit>()
                  .deleteFavorite(state.favoritesProducts[index].id),
              child: Container(
                padding: const EdgeInsets.all(6),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: kTextColor[state.theme].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/icons/Heart Icon_2.svg",
                  colorFilter: const ColorFilter.mode(
                      Color(0xFFFF4848), BlendMode.srcIn),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
