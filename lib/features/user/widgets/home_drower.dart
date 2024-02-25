import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import '../../../config/constants/constance.dart';
import '../../../core/services/service_locator.dart';
import '../logic/user_cubit.dart';
import '../screens/chat/chats_all_customers.dart';

Widget homeDrawer(BuildContext context, UserState state) {
  return Container(
    decoration: const BoxDecoration(
      // color: Color.fromARGB(180, 250, 250, 250),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(31, 38, 135, 0.4),
          blurRadius: 10.0,
        )
      ],
    ),
    width: 300,
    height: double.infinity,
    child: Stack(
      children: [
        SizedBox(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.white.withOpacity(0.2),
                  ],
                )),
              ),
            ),
          ),
        ),
        Column(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  const SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(state.user.shopName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          const Text(":اسم المحل",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(state.user.mail,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              )),
                          const Text(":البريد",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllCustomersChatScreen(),
                          ));
                    },
                    leading: const Icon(
                      Icons.people,
                      //color: Colors.blueGrey,
                      size: 33,
                    ),
                    title: const Text("المستخدمين"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppConst.addProductScreen,
                      );
                    },
                    leading: const Icon(
                      Icons.add_box,
                      // color: Colors.blueGrey,
                      size: 35,
                    ),
                    title: const Text("اضافه منتج"),
                  ),
                  ListTile(
                    onTap: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => EditOrUploadProductScreen(),) );
                    },
                    leading: const Icon(
                      Icons.color_lens_rounded,
                      size: 30, /*color: Colors.blueGrey,*/
                    ),
                    title: const Text("شكل التطبيق"),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(
                      Icons.production_quantity_limits,
                      //color: Colors.blueGrey,
                      size: 33,
                    ),
                    title: const Text("منتجاتي "),
                  ),
                  ListTile(
                    onTap: () {

                    },
                    leading: const Icon(
                      Icons.language,
                      //color: Colors.blueGrey,
                      size: 33,
                    ),
                    title: const Text("اللغه"),
                  ),
                  BlocListener<UserCubit, UserState>(
                    listenWhen: (previous, current) =>
                        previous.logOutState != current.logOutState,
                    listener: (context, state) {
                      if (state.logOutState == Status.success) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppConst.signInScreen, (route) => false);
                      }
                    },
                    child: ListTile(
                      onTap: () {
                        getit<UserCubit>().logOut();
                      },
                      leading: const Icon(
                        Icons.logout_outlined,
                        //color: Colors.blueGrey,
                        size: 33,
                      ),
                      title: const Text("تسجيل خروج"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ),
  );
}
