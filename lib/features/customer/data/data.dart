import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/models/cart_model.dart';
import 'package:shop/models/user.dart';
import 'package:uuid/uuid.dart';
import '../../../config/constants/constance.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/cache_services.dart';
import '../../../models/cart.dart';
import '../../../models/customer.dart';
import '../../../models/product.dart';
import '../../../models/search.dart';
import '../widgets/tost.dart';

class CustomerData {
  CustomerData(this._api, this._cache);
  final ApiServices _api;
  final CacheServices _cache;
  //final GoogleSignIn _googleSignIn =      GoogleSignIn(scopes: ["email"]);

  bool isSignedIn() => _cache.shared.containsKey(AppConst.type);
  String? getType() => _cache.shared.getString(AppConst.type);
  Future<bool> typeStore() async =>
      await _cache.shared.setString(AppConst.type, AppConst.customerScreen);
//

  Future<bool> storeId(String id) async =>
      await _cache.shared.setString(AppConst.id, id);
  bool checkTheme() => _cache.shared.containsKey(AppConst.theme);
  Future<bool> setTheme(int theme) async =>
      await _cache.shared.setInt(AppConst.theme, theme);
  int? getTheme() => _cache.shared.getInt(AppConst.theme);
  Future<bool> setLang(String lang) async =>
      await _cache.shared.setString(AppConst.lang, lang);
  String? getLang() => _cache.shared.getString(AppConst.lang);
  bool checkLang() => _cache.shared.containsKey(AppConst.lang);

  Future<void> googleSignIn1() async {}

  Future<UserCredential> signUp(String email, String password) async =>
      await _api.auth
          .createUserWithEmailAndPassword(email: email, password: password);

  Future<void> storeCustomer(CustomerModel customer) async =>
      await _api.fireStore
          .collection(AppConst.customerCollection)
          .doc(customer.id)
          .set(customer.toMap());

  Future<UserCredential> signIn(String email, String password) async =>
      await _api.auth
          .signInWithEmailAndPassword(email: email, password: password);

  Future<CustomerModel?> customer(String id) async {
    final customer = await _api.fireStore
        .collection(AppConst.customerCollection)
        .doc(id)
        .get();
    if (!customer.exists || customer.data() == null) return null;
    return CustomerModel.fromMap(customer.data()!, id);
  }

  Future<void> updateCustomer(CustomerModel customerModel) async =>
      await _api.fireStore
          .collection(AppConst.customerCollection)
          .doc(customerModel.id)
          .update(customerModel.toMap());

  Future<List<ProductModel>> getAllProducts() async {
    final products =
        await _api.fireStore.collection(AppConst.productCollection).get();
    if (products.docs.isEmpty) return [];
    return products.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<ProductModel>> search(String searchNames) async {
    final products = await _api.fireStore
        .collection(AppConst.productCollection)
        .orderBy("name")
        .startAt([searchNames]).endAt(["$searchNames\uf8ff"]).get();
    if (products.docs.isEmpty) return [];
    return products.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<ProductModel>> search2(String searchNames) async {
    final products = await _api.fireStore
        .collection(AppConst.productCollection)
        .orderBy("name")
        .where("name", isLessThanOrEqualTo: searchNames)
        .get();
    if (products.docs.isEmpty) return [];
    return products.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<ProductModel>> getCategoryProducts(String category) async {
    final products = await _api.fireStore
        .collection(AppConst.productCollection)
        .where(AppConst.category, isEqualTo: category)
        .get();
    if (products.docs.isEmpty) return [];
    return products.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<ProductModel>> getFavoriteProducts(List<String> ids) async {
    final products = await _api.fireStore
        .collection(AppConst.productCollection)
        .where(FieldPath.documentId, whereIn: ids)
        .get();
    if (products.docs.isEmpty) return [];
    return products.docs.map((doc) {
      return ProductModel.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Future<List<ProductModel>> getCartProducts(List<String> ids) async {
    final products = await _api.fireStore
        .collection(AppConst.productCollection)
        .where(FieldPath.documentId, whereIn: ids)
        .get();
    if (products.docs.isEmpty) return [];
    return products.docs.map((doc) {
      return ProductModel.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Future<Map<String, CartModelCustomer>?> getCartCustomer(
      String customerId) async {
    Map<String, CartModelCustomer> carts = {};
    final userDoc = await _api.fireStore
        .collection(AppConst.customerCollection)
        .doc(customerId)
        .get();
    final data = userDoc.data();
    if (data == null || !data.containsKey(AppConst.userCart)) {
      return null;
    }
    final userCart = userDoc.get(AppConst.userCart).length;

    for (int index = 0; index < userCart; index++) {
      carts.putIfAbsent(
          userDoc.get(AppConst.userCart)[index][AppConst.productId],
          () => CartModelCustomer(
                quantity: userDoc.get(AppConst.userCart)[index]
                    [AppConst.quantity],
                cartId: userDoc.get(AppConst.userCart)[index]['cartId'],
                productId: userDoc.get(AppConst.userCart)[index]['productId'],
              ));
    }
    return carts;
  }

  Future<void> favorite(List<String> favorite, String id) async =>
      await _api.fireStore
          .collection(AppConst.customerCollection)
          .doc(id)
          .update({AppConst.favorite: favorite});

  Future<void> removeCartItemFromFirestore({
    required String cartId,
    required String productId,
    required int qty,
  }) async =>
      await _api.fireStore
          .collection(AppConst.customerCollection)
          .doc(getId())
          .update({
        AppConst.userCart: FieldValue.arrayRemove([
          {
            AppConst.cartId: cartId,
            AppConst.productId: productId,
            AppConst.quantity: qty,
          }
        ])
      });

  Future<void> clearCartFromFirebase() async => await _api.fireStore
      .collection(AppConst.customerCollection)
      .doc(getId())
      .update({AppConst.userCart: []});
  Future<void> addInUserCart(String productId, int quantity) async {
    final cartId = const Uuid().v4();
    final userCartRef =
        _api.fireStore.collection(AppConst.customerCollection).doc(getId());
    final userCartSnapshot = await userCartRef.get();
    final userCartData = userCartSnapshot.data();
    if (userCartData != null && userCartData.containsKey(AppConst.userCart)) {
      final userCart = userCartData[AppConst.userCart] as List<dynamic>;
      final cartItem = userCart.firstWhere(
          (item) => item[AppConst.productId] == productId,
          orElse: () => null);
      if (cartItem != null) {
        showToast(
            text: "Product is already in the cart", State: ToastState.SUCCESS);
        return;
      }
      showToast(text: "Added In Cart Successfully", State: ToastState.SUCCESS);
    }

    await userCartRef.update({
      AppConst.userCart: FieldValue.arrayUnion([
        {
          AppConst.cartId: cartId,
          AppConst.productId: productId,
          AppConst.quantity: quantity,
        }
      ])
    });
  }

  Future<void> updateQty({required CartModelCustomer cartModel}) async {
    final response = await _api.fireStore
        .collection(AppConst.customerCollection)
        .doc(getId())
        .get();
    final userData = response.data()?[AppConst.userCart] ?? [];
    int index = userData
        .indexWhere((item) => item[AppConst.productId] == cartModel.productId);
    if (index != -1) {
      userData[index][AppConst.quantity] = cartModel.quantity;
      //print(userData[index][AppConst.quantity]);
      await _api.fireStore
          .collection(AppConst.customerCollection)
          .doc(getId())
          .update({AppConst.userCart: userData});
    }
  }

  Future<CustomerModel?> getCustomer(String id) async {
    final snapshot = await _api.fireStore
        .collection(AppConst.customerCollection)
        .doc(id)
        .get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return CustomerModel.fromMap(snapshot.data()!, id);
  }

  Future<UserModel?> getUser(String id) async {
    final snapshot =
        await _api.fireStore.collection(AppConst.userCollection).doc(id).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return UserModel.fromMap(snapshot.data()!, id);
  }

  Future<List<UserModel>> getUsers() async {
    final snapShot =
        await _api.fireStore.collection(AppConst.userCollection).get();
    if (snapShot.docs.isEmpty) return [];
    return snapShot.docs
        .map((dos) => UserModel.fromMap(dos.data(), dos.id))
        .toList();
  }

  Future<ProductModel?> getProduct(String id) async {
    final snapshot = await _api.fireStore
        .collection(AppConst.productCollection)
        .doc(id)
        .get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return ProductModel.fromMap(snapshot.data()!, id);
  }

  Stream<List<ProductModel>> searchProduct(String searchNames) {
    return _api.fireStore
        .collection(AppConst.productCollection)
        .orderBy("name")
        .startAt([searchNames])
        .endAt(["$searchNames\uf8ff"])
        .snapshots()
        .map((event) {
          List<ProductModel> list = [];
          for (var element in event.docs) {
            list.add(ProductModel.fromMap(element.data(), element.id));
          }
          return list;
        });
  }

  Future<List<SearchModel>> searchProduct2(
      String searchNames, String id) async {
    return await _api.fireStore
        .collection(AppConst.productCollection)
        .where("name", isEqualTo: searchNames)
        .get()
        .then((value) => value.docs
            .map((doc) => SearchModel.fromMap(doc.data(), id))
            .toList());
  }

  Future<List<SearchModel>> searchProduct4(
    String searchNames,
  ) async {
    final response = await _api.fireStore
        .collection(AppConst.productCollection)
        .where("name", isEqualTo: searchNames)
        .get();
    if (response.docs.isEmpty) return [];
    return response.docs
        .map((doc) => SearchModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<SearchModel>> searchProduct3(
      String searchNames, String id) async {
    final querySnapshot = await _api.fireStore
        .collection(AppConst.productCollection)
        .where("name", isEqualTo: searchNames)
        .get();
    List<SearchModel> searchModels = [];
    for (var doc in querySnapshot.docs) {
      ProductModel productModel = ProductModel.fromMap(doc.data(), id);
      SearchModel searchModel = SearchModel(
          id: productModel.id,
          name: productModel.productName,
          image: productModel.images[
              0]); // Assuming you have a constructor in the SearchModel class that accepts a ProductModel object
      searchModels.add(searchModel);
    }
    return searchModels;
  }

  String? getId() => _cache.shared.getString(AppConst.id);

  Future<CartModel> addCard(
    CartModel cartModel,
  ) async {
    final doc = await _api.fireStore
        .collection(AppConst.cartCollection)
        .add(cartModel.toMap());
    return cartModel.copyWith(id: doc.id);
  }

  Future<void> deleteCartProduct(
    String id,
  ) async {
    await _api.fireStore.collection(AppConst.cartCollection).doc(id).delete();
  }

  Future<List<CartModel>> getCartsProduct(String customerId) async {
    final carts = await _api.fireStore
        .collection(AppConst.cartCollection)
        .where("customerId", isEqualTo: customerId)
        .get();
    if (carts.docs.isEmpty) return [];
    return carts.docs
        .map((doc) => CartModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> logOut() async {
    await _api.auth.signOut();
    await _cache.shared.remove(AppConst.id);
    await _cache.shared.remove(AppConst.theme);
    await _cache.shared.remove(AppConst.type);
  }
}
