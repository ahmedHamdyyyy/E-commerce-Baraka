// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/features/customer/widgets/tost.dart';
import '../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../../../models/cart.dart';
import '../../../models/product.dart';
import '../logic/customer_cubit.dart';
import '../screens/home/AllOffers/details_screen_product.dart';

Widget itemProductCatiogoryProduct(
    CustomerState state, int index, BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreenProduct(
                    index: index,
                    productId: state.categoryProducts[index].id,
                  ),
                )),
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kTextColor[state.theme].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    height: 100,
                    width: double.infinity,
                    image: state.categoryProducts[index].images[0],
                    placeholder: 'assets/images/loading.gif',
                  ),
                )),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.categoryProducts[index].productName,
          style: TextStyle(
            color: kTextColor[state.theme],
          ),
          maxLines: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${state.categoryProducts[index].productPrice.toString()}",
              style: TextStyle(
                fontSize: 14,
                color: kTextColor[state.theme],
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                if (!getit<CustomerCubit>().isProdinCart(
                    productId: state.categoryProducts[index].id)) {
                  //showToast(text: " product added in cart successfully", State: ToastState.SUCCESS);
                  return getit<CustomerCubit>()
                      .addInUserCart(state.categoryProducts[index].id, 1);
                }
              },
              child: !getit<CustomerCubit>()
                      .isProdinCart(productId: state.categoryProducts[index].id)
                  ? SvgPicture.asset(
                      color: kTextColor[state.theme],
                      "assets/icons/Cart Icon.svg",
                      width: 28,
                      height: 28,
                    )
                  : SvgPicture.asset(
                      "assets/icons/Check mark rounde.svg",
                      width: 32,
                      height: 32,
                    ),
            ),
            InkWell(
              onTap: () => getit<CustomerCubit>().favorite(
                ProductModel(
                  id: state.categoryProducts[index].id,
                  userId: getit<CustomerCubit>().getId(),
                  productName: state.categoryProducts[index].productName,
                  category: state.categoryProducts[index].category,
                  desc: state.categoryProducts[index].desc,
                  productPrice: state.categoryProducts[index].productPrice,
                  discount: state.categoryProducts[index].discount,
                  folderId: state.categoryProducts[index].folderId,
                  images: state.categoryProducts[index].images,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(6),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: !state.customer.favorite
                          .contains(state.categoryProducts[index].id)
                      ? primaryColor[1]
                      : const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  height: 29,
                  width: 29,
                  "assets/icons/Heart Icon_2.svg",
                  colorFilter: const ColorFilter.mode(
                      Color(0xffffffff), BlendMode.srcIn),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Widget itemProducts(CustomerState state, int index, BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreenProduct(
                    index: index,
                    productId: state.products[index].id,
                  ),
                )),
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kTextColor[state.theme].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    height: 100,
                    width: double.infinity,
                    image: state.products[index].images[0],
                    placeholder: 'assets/images/loading.gif',
                  ),
                )),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.products[index].productName,
          style: TextStyle(
            color: kTextColor[state.theme],
          ),
          maxLines: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${state.products[index].productPrice.toString()}",
              style: TextStyle(
                fontSize: 14,
                color: kTextColor[state.theme],
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                if (getit<CustomerCubit>()
                    .isProdinCart(productId: state.products[index].id)) {
                  return;
                }
                return getit<CustomerCubit>()
                    .addInUserCart(state.products[index].id, 1);
              },
              child: !getit<CustomerCubit>()
                      .isProdinCart(productId: state.products[index].id)
                  ? SvgPicture.asset(
                      "assets/icons/Cart Icon.svg",
                      width: 28,
                      color: kTextColor[state.theme],
                      height: 28,
                    )
                  : SvgPicture.asset(
                      "assets/icons/Check mark rounde.svg",
                      width: 32,
                      height: 32,
                    ),
            ),
            InkWell(
              onTap: () => getit<CustomerCubit>().favorite(
                ProductModel(
                  id: state.products[index].id,
                  userId: getit<CustomerCubit>().getId(),
                  productName: state.products[index].productName,
                  category: state.products[index].category,
                  desc: state.products[index].desc,
                  productPrice: state.products[index].productPrice,
                  discount: state.products[index].discount,
                  folderId: state.products[index].folderId,
                  images: state.products[index].images,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(6),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: !state.customer.favorite
                          .contains(state.products[index].id)
                      ? primaryColor[1]
                      : const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  height: 29,
                  width: 29,
                  "assets/icons/Heart Icon_2.svg",
                  colorFilter: const ColorFilter.mode(
                      Color(0xffffffff), BlendMode.srcIn),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
