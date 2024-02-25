// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/user/screens/dashboard_screen.dart';
import 'package:shop/features/user/screens/update_screen.dart';
import '../../../config/constants/constance.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/utils.dart';
import '../../../models/product.dart';
import '../logic/user_cubit.dart';
import '../widgets/home_drower.dart';
import '../widgets/Loding.dart';
import 'detiles_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final userId = getit<UserCubit>().getId();
  @override
  void initState() {
    super.initState();
    getit<UserCubit>().getUser(userId);
    getit<UserCubit>().getAllProductUser(userId);
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: getit<UserCubit>(),
    child: BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) =>
          previous.productsUser != current.productsUser,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {

                Navigator.push(context, MaterialPageRoute (builder: (context) => const DashboardScreen(),));
              }, icon: const Icon(Icons.home))
            ],
              title: Text(
            state.user.shopName,
          )),
          drawerScrimColor: Colors.transparent,
          drawer: homeDrawer(context, state),
          body: RefreshIndicator(
            onRefresh: () async =>
                getit<UserCubit>().getAllProductUser(userId),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.getAllProductsUserState == Status.loading
                  ? loading()
                  : state.productsUser.isEmpty
                      ? noProduct()
                      : ListView(
                          children: [
                            Container(
                              color: Colors.grey[0],
                              child: GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                mainAxisSpacing: 1,
                                childAspectRatio: 1 / 1.8,
                                crossAxisSpacing: 1,
                                physics:
                                    const NeverScrollableScrollPhysics(),
                                children: List.generate(
                                  state.productsUser.length,
                                  (index) => itemProduct(
                                      state.productsUser[index],
                                      context,
                                      state,
                                      index),
                                ),
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        );
      },
    ),
  );
}

Container itemProduct(
        ProductModel model, BuildContext context, UserState state, int index) =>
    Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsProductUser(
                                productId: state.productsUser[index].id,
                              ),
                            ));
                      },
                      onLongPress: () {
                        Utils.deleteDialog(context, "هل تريد مسح المنتج ",
                            onPressed: () {
                          getit<UserCubit>().deleteProduct(model);
                          Navigator.pop(context);
                          Utils.successSnackBar(
                              context, "جاررر مسح المنتج برجاء الانتظار.");
                        });
                      },
                      child: Image(
                        image: NetworkImage(model.images[0]),
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                    if (model.discount != 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.red,
                        child: const Text(
                          "تخفيض",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                Text(
                  model.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${model.productPrice.round()}",
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (model.discount != 0)
                      Text(
                        "${model.discount.round()}",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          height: 1.3,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(
                                  id: model.id,
                                ),
                              ));
                        },
                        icon: const Icon(
                          Icons.update,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
