import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:see_more/see_more_widget.dart';

import '../../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../../../models/product.dart';
import '../logic/customer_cubit.dart';

class ProductDescriptionCustomer extends StatelessWidget {
  const ProductDescriptionCustomer({
    super.key,
    required this.index,
    required this.color,
    this.pressOnSeeMore,
    required this.state,
    required this.product,
  });

  final int index;
  final Color color;
  final ProductModel product;
  final CustomerState state;

  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.productName,
                  style: TextStyle(
                      color: color, fontSize: 20, fontFamily: "Muli")),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              getit<CustomerCubit>().favorite(
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
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              width: 48,
              decoration: BoxDecoration(
                color:
                    !state.customer.favorite.contains(state.products[index].id)
                        ? primaryColor[1]
                        : const Color(0xFFFF4848),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                colorFilter: const ColorFilter.mode(
                    /* */ /*  product.isFavourite
                        ? const Color(0xFFFF4848)*/ /*
                        : const*/
                    Color(0xFFDBDEE4),
                    BlendMode.srcIn),
                height: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 64,
            bottom: 20
          ),
          child: SeeMoreWidget(
            product.desc,
            textStyle: TextStyle(
              fontSize: 18,
              color: kTextColor[state.theme],
              fontWeight: FontWeight.w400,
            ),
            animationDuration: Duration(milliseconds: 300),
            seeMoreText: "See More...",
            seeMoreStyle: TextStyle(
              fontSize: 20,
              color: kTextColor[state.theme],
              fontWeight: FontWeight.bold,

            ),
            seeLessText: "See Less...",
            seeLessStyle: TextStyle(
              fontSize: 20,
              color: kTextColor[state.theme],
              fontWeight: FontWeight.bold,
             // color: Colors.red,
            ),
            trimLength: 240,
          ),
        ),
      ],
    );
  }
}
class ProductDescriptionCustomerCaty extends StatelessWidget {
  const ProductDescriptionCustomerCaty({
    super.key,

    required this.color,
    this.pressOnSeeMore,
    required this.state,
    required this.product,
  });


  final Color color;
  final ProductModel product;
  final CustomerState state;

  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.productName,
                  style: TextStyle(
                      color: color, fontSize: 20, fontFamily: "Muli")),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              getit<CustomerCubit>().favorite(
                ProductModel(
                  id: state.product.id,
                  userId: getit<CustomerCubit>().getId(),
                  productName: state.product.productName,
                  category: state.product.category,
                  desc: state.product.desc,
                  productPrice: state.product.productPrice,
                  discount: state.product.discount,
                  folderId: state.product.folderId,
                  images: state.product.images,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              width: 48,
              decoration: BoxDecoration(
                color:
                !state.customer.favorite.contains(state.product.id)
                    ? primaryColor[1]
                    : const Color(0xFFFF4848),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                colorFilter: const ColorFilter.mode(
                  /* */ /*  product.isFavourite
                        ? const Color(0xFFFF4848)*/ /*
                        : const*/
                    Color(0xFFDBDEE4),
                    BlendMode.srcIn),
                height: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20,
              right: 64,
              bottom: 20
          ),
          child: SeeMoreWidget(
            product.desc,
            textStyle: TextStyle(
              fontSize: 18,
              color: kTextColor[state.theme],
              fontWeight: FontWeight.w400,
            ),
            animationDuration: Duration(milliseconds: 300),
            seeMoreText: "See More...",
            seeMoreStyle: TextStyle(
              fontSize: 20,
              color: kTextColor[state.theme],
              fontWeight: FontWeight.bold,

            ),
            seeLessText: "See Less...",
            seeLessStyle: TextStyle(
              fontSize: 20,
              color: kTextColor[state.theme],
              fontWeight: FontWeight.bold,
              // color: Colors.red,
            ),
            trimLength: 240,
          ),
        ),
      ],
    );
  }
}
