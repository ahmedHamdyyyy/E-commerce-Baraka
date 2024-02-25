import 'package:flutter/material.dart';

import '../../../config/colors/colors.dart';
import '../../../config/services/assets_manager.dart';
import '../../../config/widgets/cart_screen_empty.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/utils.dart';
import '../logic/user_cubit.dart';
import '../screens/update_screen.dart';

class BodyAllProducts extends StatelessWidget {
  BodyAllProducts({
    super.key,
    required this.state,
  });
  UserState state;
  @override
  Widget build(BuildContext context) {
    return state.productsUser.isNotEmpty? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: state.productsUser.length,
                gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: kTextColor[0].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: GestureDetector(
                              onLongPress: () {
                                Utils.deleteDialog(
                                    context, "هل تريد مسح المنتج ",
                                    onPressed: () {
                                      getit<UserCubit>().deleteProduct(
                                          state.productsUser[index]);
                                      Navigator.pop(context);
                                      Utils.successSnackBar(context,
                                          "جاررر مسح المنتج برجاء الانتظار.");
                                    });
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          UpdateScreen(
                                            id: state
                                                .productsUser[index].id,
                                          ),
                                    ));
                              },
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(20.0),
                                child: FadeInImage.assetNetwork(
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: double.infinity,
                                  image: state
                                      .productsUser[index].images[0],
                                  placeholder:
                                  'assets/images/loading.gif',
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        style: TextStyle(
                          color: kTextColor[0],
                        ),
                        state.productsUser[index].productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.productsUser[index].productPrice
                                .toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: kTextColor[0],
                            ),
                          ),
                          Text(
                            state.productsUser[index].discount.toString(),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
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
        ],
      ),
    ): ScreenImpty(imagePath:  AssetsManager.orderEmpty,  text: "NO Product added ");
  }
}