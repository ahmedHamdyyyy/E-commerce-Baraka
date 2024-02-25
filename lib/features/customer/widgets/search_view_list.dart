import 'package:flutter/material.dart';

import '../../../config/colors/colors.dart';
import '../../../config/services/assets_manager.dart';
import '../logic/customer_cubit.dart';
import '../screens/home/AllOffers/details_screen_search.dart';

class ListSearchViw extends StatelessWidget {
  ListSearchViw({
    super.key,
    required this.state,
  });
  CustomerState state;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return       state.searchProduct.isNotEmpty?   SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.vertical,
          itemCount: state.searchProduct.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.7,
            mainAxisSpacing: 20,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) =>  SizedBox(
            width: 150,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreenProductSearch(
                        index: index,
                        productId: state.searchProduct[index].id,
                      ),
                    ));
              },
              child: Column(
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
                      child: Image.network(state.searchProduct[index].images[0],
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.searchProduct[index].productName,
                    style: TextStyle(color: kTextColor[state.theme]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${state.searchProduct[index].productPrice.toString()}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ):Column(
crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox( height: size.height * 0.20,),
        Image.asset(

          AssetsManager.searchImage,
          width: double.infinity,
          height: size.height * 0.30,
        ),
        SizedBox( height: size.height * 0.03,),
        Text("No Found This Product 💔.",style: TextStyle(
          color: kTextColor[state.theme],
          fontSize: size.height * 0.03,)),

      ],
    );
  }
}