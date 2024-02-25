
import 'package:flutter/material.dart';
import 'package:shop/config/services/my_app_functions.dart';
import '../../../config/services/assets_manager.dart';
import '../screens/add_product_screen.dart';
import '../screens/all_product_user.dart';
import '../screens/chat/chats_all_customers.dart';


class DashboardButtonsModel {
  final String text, imagePath;
  final Function onPressed;

  DashboardButtonsModel({
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  static List<DashboardButtonsModel> dashboardBtnList(context) => [
        DashboardButtonsModel(
          text: "Add a new product",

          imagePath: AssetsManager.cloud,
          onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddProductScreen() ,));
            //Navigator.pushNamed(context, EditOrUploadProductScreen.routeName);
          },
        ),
        DashboardButtonsModel(
          text: "View all products",
          imagePath: AssetsManager.shoppingCart,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProductUser(),));

            // Navigator.pushNamed(context, SearchScreen.routeName);
          },
        ),
        DashboardButtonsModel(
          text: "View Orders",
          imagePath: AssetsManager.order,
          onPressed: () {

            // Navigator.pushNamed(context, OrdersScreenFree.routeName);
          },
        ),

    DashboardButtonsModel(
          text: "Messenger",
          imagePath: AssetsManager.messanger,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AllCustomersChatScreen(),))
  ;         // Navigator.pushNamed(context, OrdersScreenFree.routeName);
          },
        ),
    DashboardButtonsModel(
          text: "Log out",
          imagePath: "assets/images/logout.jpg",
          onPressed: () {
            MyAppFunctions.showErrorOrWarningDialog(context: context, subtitle: "Do you want logout", fct: (){



            });
          },
        ),
      ];
}
