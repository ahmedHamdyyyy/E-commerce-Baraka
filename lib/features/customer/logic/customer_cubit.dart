import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/features/customer/widgets/tost.dart';
import 'package:shop/models/user.dart';
import '../../../config/constants/constance.dart';
import '../../../models/cart.dart';
import '../../../models/cart_model.dart';
import '../../../models/customer.dart';
import '../../../models/message_model.dart';
import '../../../models/product.dart';
import '../../../models/search.dart';
import '../data/repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit(this._repo) : super(const CustomerState());
  final CustomerRepository _repo;
  Future<Uint8List> getPath(String path) async =>
      await File(path).readAsBytes();
  void googleSignIn() async {
    await _repo.googleSignIn1();
    emit(state.copyWith(searchProductsState: Status.success));
  }

  void inatTheme() {
    emit(state.copyWith(theme: 0));
  }

  void search(String name) async {
    emit(state.copyWith(searchProductsState: Status.loading));

    try {
      final productsSearch = await _repo.search(name);
      emit(state.copyWith(
          searchProduct: productsSearch, searchProductsState: Status.success));
      if (name == "")
        emit(state
            .copyWith(searchProduct: [], searchProductsState: Status.initial));
    } catch (e) {
      emit(state.copyWith(searchProductsState: Status.error));
    }
  }

  void setTheme(int theme) async {
    try {
      emit(state.copyWith(themeStatus: Status.loading));
      final themeResponse = theme == 0 ? 1 : 0;
      await _repo.setTheme(themeResponse);
      emit(state.copyWith(theme: themeResponse, themeStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(themeStatus: Status.error, msg: e.toString()));
    }
  }

  void getTheme() {
    emit(state.copyWith(themeStatus: Status.loading));
    final theme = _repo.theme();
    emit(state.copyWith(theme: theme, themeStatus: Status.success));
  }

  String typeScreen() => _repo.type();
  void signUp(CustomerModel customer, String password) async {
    try {
      emit(state.copyWith(signUpState: Status.loading));
      final newCustomer = await _repo.signUp(customer, password);
      emit(state.copyWith(
          customer: newCustomer,
          msg: 'success process',
          signUpState: Status.success));
    } on Exception catch (e) {
      emit(state.copyWith(
          signUpState: Status.error, msg: e.toString().substring(11)));
    }
  }

  void signIn(String email, String password) async {
    try {
      emit(state.copyWith(signInState: Status.loading));
      final customer = await _repo.signIn(email, password);
      emit(state.copyWith(
          customer: customer,
          msg: 'success process',
          signInState: Status.success));
    } on Exception catch (e) {
      emit(state.copyWith(signInState: Status.error, msg: e.toString()));
    }
  }

  void getAllProducts() async {
    try {
      emit(state.copyWith(getAllProductsStatus: Status.loading));
      final products = await _repo.getAllProducts();
      emit(state.copyWith(
          products: products,
          msg: 'get all products success ',
          getAllProductsStatus: Status.success));
      /*  print(state.msg);*/
    } on Exception catch (e) {
      emit(state.copyWith(
          getAllProductsStatus: Status.error, msg: e.toString()));
    }
  }

  void getProduct(String id) async {
    try {
      emit(state.copyWith(getProductStatus: Status.loading));
      final product = await _repo.getProduct(id);
      emit(state.copyWith(
        product: product,
        getProductStatus: Status.success,
        msg: 'get 1 success process',
      ));
    } on Exception catch (e) {
      emit(state.copyWith(getProductStatus: Status.error, msg: e.toString()));
    }
  }

  void getUser(String id) async {
    try {
      emit(state.copyWith(getUserStatus: Status.loading));
      final product = await _repo.getUser(id);
      emit(state.copyWith(
        user: product,
        getUserStatus: Status.success,
        msg: 'get 1 success process',
      ));
    } on Exception catch (e) {
      emit(state.copyWith(getUserStatus: Status.error, msg: e.toString()));
    }
  }

  void updateCustomer(CustomerModel customerModel) async {
    try {
      emit(state.copyWith(updateCustomerState: Status.loading));
      await _repo.updateCustomer(customerModel);
      emit(state.copyWith(
        updateCustomerState: Status.success,
        msg: 'Update 1 success process',
      ));
    } on Exception catch (e) {
      emit(state.copyWith(getProductStatus: Status.error, msg: e.toString()));
    }
  }

  void getCategoryProducts(String category) async {
    emit(state.copyWith(getCategoryProductsStatus: Status.loading));
    try {
      final products = await _repo.getCategoryProducts(category);
      emit(state.copyWith(
          categoryProducts: products,
          msg: 'success process',
          getCategoryProductsStatus: Status.success));
      log(state.getCategoryProductsStatus.toString());
    } on Exception catch (e) {
      emit(state.copyWith(
          getCategoryProductsStatus: Status.error, msg: e.toString()));
    }
  }

  void getFavoriteProducts() async {
    try {
      emit(state.copyWith(getFavoriteProductsStatus: Status.loading));
      if (state.customer.favorite.isEmpty) {
        return emit(state.copyWith(
            getFavoriteProductsStatus: Status.success, favoritesProducts: []));
      }
      final products = await _repo.getFavoriteProducts(state.customer.favorite);
      emit(state.copyWith(
        favoritesProducts: products,
        msg: 'Get Favorites process ',
        getFavoriteProductsStatus: Status.success,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
          getFavoriteProductsStatus: Status.error, msg: e.toString()));
    }
  }

  void deleteFavorite(String id) async {
    try {
      emit(state.copyWith(favoriteStatus: Status.loading));
      List<String> favorite = List.from(state.customer.favorite);
      favorite.remove(id);
      await _repo.favorite(favorite, state.customer.id);
      emit(state.copyWith(
          favoritesProducts: List.from(state.favoritesProducts)
            ..removeWhere((p) => p.id == id),
          customer: state.customer.copyWith(favorite: favorite),
          favoriteStatus: Status.success,
          msg: "delete in Favorites success "));
    } on Exception catch (e) {
      emit(state.copyWith(favoriteStatus: Status.error, msg: e.toString()));
    }
  }

  void favorite(ProductModel product) async {
    try {
      emit(state.copyWith(favoriteStatus: Status.loading));
      List<String> favorite = List.from(state.customer.favorite);
      if (favorite.contains(product.id)) {
        favorite.remove(product.id);
        emit(state.copyWith(
          favoriteStatus: Status.success,
          msg: "delete in Favorite success ",
          favoritesProducts: List.from(state.favoritesProducts)
            ..removeWhere((p) => p.id == product.id),
        ));
        showToast(
            text: "delete in Favorite success", State: ToastState.WARNING);
      } else {
        favorite.add(product.id);
        emit(state.copyWith(
            favoriteStatus: Status.success,
            favoritesProducts: List.from(state.favoritesProducts)
              ..add(product)));
      }
      await _repo.favorite(favorite, state.customer.id);
      emit(state.copyWith(
          customer: state.customer.copyWith(favorite: favorite),
          favoriteStatus: Status.success,
          msg: "added in Favorite success "));
    } on Exception catch (e) {
      emit(state.copyWith(favoriteStatus: Status.error, msg: e.toString()));
    }
  }
  /*void getFavoriteProducts() async {
    try {
      emit(state.copyWith(getFavoriteProductsStatus: Status.loading));
      if (state.customer.favorite.isEmpty) {
        return emit(state.copyWith(
            getFavoriteProductsStatus: Status.success, favoritesProducts: []));
      }
      final products = await _repo.getFavoriteProducts(state.customer.favorite);
      emit(state.copyWith(
        favoritesProducts: products,
        msg: 'Get Favorites process ',
        getFavoriteProductsStatus: Status.success,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
          getFavoriteProductsStatus: Status.error, msg: e.toString()));
    }
  }*/

  /*void addInUserCart(ProductModel cartUserModel) async {
    try {
      emit(state.copyWith(favoriteStatus: Status.loading));
      List<String> userCart = List.from(state.customer.userCart);
      if (userCart.contains(cartUserModel.)) {
        userCart.remove(cartUserModel.productId);
        emit(state.copyWith(
          msg: "delete in Favorite success ",
          favoritesProducts: List.from(state.cartsProducts)..removeWhere((p) => p.id == cartUserModel.productId),
        ));
      } else {
        userCart.add(cartUserModel.productId);
        emit(state.copyWith(
            favoriteStatus: Status.success,
            cartsProducts: List.from(state.cartsProducts)
              ..add(cartUserModel)));
      }
      await _repo.favorite(userCart, state.customer.id);
      emit(state.copyWith(
          customer: state.customer.copyWith(favorite: userCart),
          favoriteStatus: Status.success,
          msg: "added in Favorite success "));
    } on Exception catch (e) {
      emit(state.copyWith(favoriteStatus: Status.error, msg: e.toString()));
    }
  }*/

  void deleteSearch() {
    emit(
        state.copyWith(searchProduct: [], searchProductsState: Status.initial));
  }

  void searchProduct(String name) {
    try {
      emit(state.copyWith(searchProductsState: Status.loading));
      final productStream = _repo.searchProduct(name);
      productStream.listen((event) {
        emit(state.copyWith(
          searchProduct: event,
          searchProductsState: Status.success,
        ));
      });
    } on Exception {
      emit(state.copyWith(searchProductsState: Status.error));
    }
  }

  void getCustomer(String id) async {
    emit(state.copyWith(getDataUserState: Status.loading));
    try {
      final user = await _repo.getCustomer(id);
      emit(state.copyWith(getDataUserState: Status.success, customer: user));
    } on Exception catch (e) {
      emit(state.copyWith(getDataUserState: Status.error, msg: e.toString()));
    }
  }

  String getId() => _repo.getId()!;

  void addInUserCart(
    String productId,
    int quantity,
  ) async {
    emit(state.copyWith(addCartProductsState: Status.loading));
    try {
      await _repo.addInUserCart(productId, quantity);
      emit(state.copyWith(addCartProductsState: Status.success));
    } catch (e) {
      emit(state.copyWith(addCartProductsState: Status.error));
    }
  }

  void updateQtyCart(CartModelCustomer cartModel) async {
    try {
      emit(state.copyWith(updateCustomerState: Status.loading));

      await _repo.updateQty(cartModel: cartModel);

      Map<String, CartModelCustomer> cartList = Map.from(state.cartsProducts);
      state.cartsProducts.forEach((key, cartItem) {
        if (cartItem.productId == cartModel.productId) {
          emit(state.copyWith(
            cartsProducts: cartList,
            updateCustomerState: Status.success,
            msg: 'Update success process',
          ));
          showToast(text: "Please refresh the page", State: ToastState.SUCCESS);
        }
      });
      // Iterate through the cart products to find the matching cart item

      /*  */ /* // Update the quantity of the matching cart item
          cartItem.quantity = customerModel.quantity*/ /*;*/
    } catch (e) {
      emit(
          state.copyWith(updateCustomerState: Status.error, msg: e.toString()));
    }
  }

  bool isProdinCart({required String productId}) {
    if (state.customer.userCart.contains(productId)) {
      return false;
    }
    return state.cartsProducts.containsKey(productId);
  }

  double getTotal() {
    double total = 0.0;
    state.cartsProducts.forEach((key, value) {
      final getCurrProduct = findByProductId(value.productId);
      if (getCurrProduct == null) {
        total += 0;
      } else {
        total += getCurrProduct.productPrice * value.quantity;
      }
    });
    emit(state.copyWith(
      qty: total,
    ));
    return total;
  }

  ProductModel? findByProductId(String productId) {
    if (state.products.where((element) => element.id == productId).isEmpty) {
      return null;
    }
    final product =
        state.products.firstWhere((element) => element.id == productId);
    return product;
  }

  void removeCartItemFromFirestore({
    required String cartId,
    required String productId,
    required int qty,
  }) async {
    emit(state.copyWith(deleteCartProductState: Status.loading));
    try {
      final Map<String, CartModelCustomer> cartsProducts =
          Map.from(state.cartsProducts);
      cartsProducts.removeWhere((key, value) => value.cartId == cartId);

      await _repo.removeCartItemFromFirestore(
          cartId: cartId, productId: productId, qty: qty);

      emit(state.copyWith(
          cartsProducts: cartsProducts,
          deleteCartProductState: Status.success));
      showToast(text: "delete Item From Cart", State: ToastState.WARNING);
    } catch (e) {
      emit(state.copyWith(deleteCartProductState: Status.error));
    }
  }

  void clearCartFromFirebase() async {
    emit(state.copyWith(deleteCartProductState: Status.loading));
    try {
      await _repo.clearCartFromFirebase();
      emit(state
          .copyWith(deleteCartProductState: Status.success, cartsProducts: {}));
    } catch (e) {
      emit(state.copyWith(deleteCartProductState: Status.error));
    }
  }

  void addInCart(
    CartModel cartModel,
  ) async {
    try {
      emit(state.copyWith(addCartProductsState: Status.loading));
      final List<CartModel> cartList = List.from(state.carts);
      if (cartList.any((element) => element.productId == cartModel.productId)) {
        deleteCartProduct(cartModel.productId);
        emit(state.copyWith(deleteCartProductState: Status.success));
      } else {
        final cart = await _repo.addCard(
          cartModel,
        );
        emit(state.copyWith(
          addCartProductsState: Status.success,
          carts: List<CartModel>.from(state.carts)..add(cart),
        ));
      }
    } catch (e) {
      emit(state.copyWith(addCartProductsState: Status.error));
    }
  }

  void deleteCartProduct(String productId) async {
    emit(state.copyWith(deleteCartProductState: Status.loading));
    final id =
        state.carts.firstWhere((element) => element.productId == productId).id;
    await _repo.deleteCartProduct(id).then((value) {
      final List<CartModel> cartList = List.from(state.carts);
      cartList.removeWhere((element) => element.id == id);
      emit(state.copyWith(
          deleteCartProductState: Status.success, carts: cartList));
    }).catchError((e) {
      emit(state.copyWith(
          deleteCartProductState: Status.error, msg: e.toString()));
    });
  }

  void getCartCustomer(String customerId) async {
    try {
      emit(state.copyWith(getCartsProductStatus: Status.loading));
      final response = await _repo.getCartCustomer(customerId);
      emit(state.copyWith(
        getCartsProductStatus: Status.success,
        cartsProducts: response,
      ));
      ;
      log(state.cartsProducts.length.toString());
    } catch (e) {
      emit(state.copyWith(getCartsProductStatus: Status.error));
    }
  }

  void getCartsProduct(String customerId) async {
    emit(state.copyWith(
      getCartsProductStatus: Status.loading,
    ));
    try {
      final carts = await _repo.getCartsProduct(customerId);
      emit(state.copyWith(
          getCartsProductStatus: Status.success,
          carts: carts,
          msg: "get All Products in Carts"));
    } on Exception catch (e) {
      emit(state.copyWith(
        getCartsProductStatus: Status.error,
        msg: e.toString(),
      ));
    }
  }

  void logOut() async {
    emit(state.copyWith(logOutState: Status.loading));
    try {
      await _repo.logOut();
      emit(state.copyWith(logOutState: Status.success, msg: "خرج بنجاح "));
    } on Exception catch (e) {
      emit(state.copyWith(logOutState: Status.error, msg: e.toString()));
    }
  }

  void search1(String searchNames, String id) async {
    try {
      emit(state.copyWith(searchProductsState: Status.loading));
      final product = await _repo.searchProduct2(searchNames, id);
      emit(state.copyWith(
        searchList: product,
        searchProductsState: Status.success,
      ));
    } on Exception {
      emit(state.copyWith(searchProductsState: Status.error));
    }
  }

  void search4(
    String searchNames,
  ) async {
    try {
      emit(state.copyWith(searchProductsState: Status.loading));
      final product = await _repo.searchProduct4(
        searchNames,
      );
      emit(state.copyWith(
        searchList: product,
        searchProductsState: Status.success,
      ));
    } on Exception {
      emit(state.copyWith(searchProductsState: Status.error));
    }
  }

  void getAllUsers() async {
    emit(state.copyWith(getAllUsersState: Status.loading));
    try {
      final users = await _repo.getAllUsers();
      emit(state.copyWith(users: users, getAllUsersState: Status.success));
    } catch (e) {
      emit(state.copyWith(getAllUsersState: Status.error, msg: "error"));
    }
  }

  Future<String> uploadMessageImage(
    String path,
  ) async {
    final value = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child("messageImage/${Uri.file(path).pathSegments.last}")
        .putFile(File(path));
    return value.ref.getDownloadURL();
  }

  void pickImageMessage({
    required ImageSource source,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    if (pickedFile != null) {
      emit(state.copyWith(imagePath: pickedFile.path));
      log(pickedFile.path);
    }
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dataTime,
    String? imagePost,
  }) async {
    try {
      emit(state.copyWith(sendMessageState: Status.loading));
      MessageModel model = MessageModel(
        text: text,
        senderId: getId(),
        dataTime: dataTime,
        receiverId: receiverId,
        image: imagePost != "" ? await uploadMessageImage(imagePost!) : "",
      );

      CollectionReference senderChatCollection = FirebaseFirestore.instance
          .collection(AppConst.customerCollection)
          .doc(getId())
          .collection("chats")
          .doc(receiverId)
          .collection("messages");

      CollectionReference receiverChatCollection = FirebaseFirestore.instance
          .collection(AppConst.userCollection)
          .doc(receiverId)
          .collection("chats")
          .doc(getId())
          .collection("messages");
      await senderChatCollection.add(model.toMap());
      await receiverChatCollection.add(model.toMap());

      emit(state.copyWith(sendMessageState: Status.success, imagePath: ""));
    } catch (e) {
      emit(state.copyWith(sendMessageState: Status.error));
    }
  }
}
