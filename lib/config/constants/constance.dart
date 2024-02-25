import 'package:flutter/material.dart';

import '../../features/user/models/categories_model.dart';
import '../services/assets_manager.dart';

enum Status { initial, loading, success, error }

class AppConst {
//collections
  static const adminCollection = 'Admins';
  static const userCollection = 'Users';
  static const productCollection = 'Products';
  static const cartCollection = 'Carts';
  static const customerCollection = 'Customers';
//variables
  static const id = 'id';
  static const mail = 'mail';
  static const name = 'name';
  static const theme = 'theme';
  static const lang = 'lang';
  static const address = 'address';
  static const city = 'city';
  static const cartId = 'cartId';
  static const location = 'location';
  static const phone = 'phone';
  static const shopName = 'shopName';
  static const imagesFolderId = 'imagesFolderId';
  static const type = 'type';
  static const date = 'date';
  static const desc = 'desc';
  static const discount = 'discount';
  static const count = 'count';
  static const colors = 'colors';
  static const color = 'color';
  static const userId = 'userId';
  static const productId = 'productId';
  static const productQuantity = 'productQuantity';
  static const createdAt = 'createdAt';

  static const customerId = 'customerId';
  static const image = 'image';
  static const images = 'images';
  static const category = 'category';
  static const favorite = 'favorite';
  static const userCart = 'userCart';
  static const quantity = 'quantity';
  static const messages = 'messages';
  static const chats = 'chats';

//screens
  static const splashScreen = '/';
  static const signInScreen = '/signInScreen';
  static const adminScreen = '/adminHomeScreen';
  static const userScreen = '/userHomeScreen';
  static const addProductScreen = '/AddProductScreen';
  static const detailsScreen = '/detailsScreen';
  static const customerScreen = '/customerHomeScreen';
//

//

  //images
  static List<CategoriesModel> categoriesList = [
    CategoriesModel(
      id: "Phones",
      image: AssetsManager.mobiles,
      name: "Phones",
    ),
    CategoriesModel(
      id: "Laptops",
      image: AssetsManager.pc,
      name: "Laptops",
    ),
    CategoriesModel(
      id: "Electronics",
      image: AssetsManager.electronics,
      name: "Electronics",
    ),
    CategoriesModel(
      id: "Watches",
      image: AssetsManager.watch,
      name: "Watches",
    ),
    CategoriesModel(
      id: "Clothes",
      image: AssetsManager.fashion,
      name: "Clothes",
    ),
    CategoriesModel(
      id: "Shoes",
      image: AssetsManager.shoes,
      name: "Shoes",
    ),
    CategoriesModel(
      id: "Books",
      image: AssetsManager.book,
      name: "Books",
    ),
    CategoriesModel(
      id: "Cosmetics",
      image: AssetsManager.cosmetics,
      name: "Cosmetics",
    ),
  ];
  static List<String> categoriesListItem = [
    'Phones',
    'Laptops',
    'Electronics',
    'Watches',
    'Clothes',
    'Shoes',
    'Books',
    'Cosmetics',
    "Accessories",
  ];



  static List<DropdownMenuItem<String>>? get categoriesDropDownList {
    List<DropdownMenuItem<String>>? menuItem =
    List<DropdownMenuItem<String>>.generate(
      categoriesListItem.length,
          (index) => DropdownMenuItem(
        value: categoriesListItem[index],
        child: Text(categoriesListItem[index]),
      ),
    );
    return menuItem;
  }
  static String newId() => DateTime.now()
      .difference(DateTime(2023))
      .inMicroseconds
      .remainder(100000000000000)
      .toString();
}

