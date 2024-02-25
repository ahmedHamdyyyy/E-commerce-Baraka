
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../components/top_rounded_container.dart';
import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../user/widgets/Loding.dart';
import '../../../../user/widgets/product_images.dart';
import '../../../logic/customer_cubit.dart';
import '../../../widgets/add_to_cart_and_total_mony.dart';
import '../../../widgets/product_description.dart';

class DetailsScreenFromCatygory extends StatefulWidget {
  const DetailsScreenFromCatygory(
      {super.key, required this.productId, });

  final String productId;


  @override
  State<DetailsScreenFromCatygory> createState() => _DetailsScreenProductState();
}

class _DetailsScreenProductState extends State<DetailsScreenFromCatygory> {
  @override
  void initState() {
    super.initState();
    getit<CustomerCubit>().getProduct(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<CustomerCubit>(),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    backgroundColor: foreGroundColor[state.theme],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: backGroundColorIcon[state.theme],
                    size: 20,
                  ),
                ),
              ),
              actions: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: foreGroundColor[state.theme],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "4.7",
                            style: TextStyle(
                              fontSize: 14,
                              //  color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset("assets/icons/Star Icon.svg"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: state.getProductStatus == Status.loading
                ? loading()
                : ListView(
              children: [
                ProductImages(
                    color: foreGroundColor[state.theme],
                    images: state.product.images),
                TopRoundedContainer(
                  color: foreGroundColor[state.theme],
                  child: Column(
                    children: [
                      ProductDescriptionCustomerCaty(

                        state: state,
                        product: state.product,
                        color: kTextColor[state.theme],
                        pressOnSeeMore: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar:AddTOCheckoutCardCary(
              userId: state.product.userId,
              color: checkOutCartColor[state.theme],
              state: state,
            ),
          );
        },
      ),
    );
  }
}
