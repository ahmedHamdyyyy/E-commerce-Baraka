import 'package:firebase_auth/firebase_auth.dart';

import '../../../config/constants/constance.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/cache_services.dart';
import '../../../models/customer.dart';
import '../../../models/product.dart';
import 'dart:io';

import '../../../models/user.dart';

class UserData {
  const UserData(this._api, this._cache);
  final ApiServices _api;
  final CacheServices _cache;

  String? getId() => _cache.shared.getString(AppConst.id);
  Future<bool> storeId(String id) async =>
      await _cache.shared.setString(AppConst.id, id);
  Future<bool> typeStore() async =>
      await _cache.shared.setString(AppConst.type, AppConst.userScreen);
  Future<void> logOut() async {
    await _api.auth.signOut().then((value) {
      _cache.shared.remove(AppConst.id).then((value) {
        _cache.shared.remove(AppConst.type);
      });
    });
  }

  Future<ProductModel> addProduct(ProductModel product) async {
    final doc = await _api.fireStore
        .collection(AppConst.productCollection)
        .add(product.create());
    return product.copyWith(id: doc.id);
  }

  Future<String> uploadImage(String path, String folderId) async {
    final file = await _api.storage
        .ref(AppConst.productCollection)
        .child('/$folderId')
        .child('/${AppConst.newId()}.${path.split('.').last}')
        .putFile(File(path));
    return await file.ref.getDownloadURL();
  }

  Future<UserCredential> signIn(String email, String password) async =>
      await _api.auth
          .signInWithEmailAndPassword(email: email, password: password);

  Future<UserModel?> user(String id) async {
    final user =
        await _api.fireStore.collection(AppConst.userCollection).doc(id).get();
    if (!user.exists || user.data() == null) return null;
    return UserModel.fromMap(user.data()!, id);
  }

  Future<void> storeUser(UserModel user) async => await _api.fireStore
      .collection(AppConst.userCollection)
      .doc(user.id)
      .set(user.toMap());

  Future<UserModel?> getUser(String id) async {
    final snapshot =
        await _api.fireStore.collection(AppConst.userCollection).doc(id).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return UserModel.fromMap(snapshot.data()!, id);
  }
  Future<CustomerModel?> getCustomer(String id) async {
    final snapshot =
        await _api.fireStore.collection(AppConst.customerCollection).doc(id).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return CustomerModel.fromMap(snapshot.data()!, id);
  }

  Future<ProductModel?> getProduct(String id) async {
    final snapshot = await _api.fireStore
        .collection(AppConst.productCollection)
        .doc(id)
        .get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return ProductModel.fromMap(snapshot.data()!, id);
  }

  Future<List<ProductModel>> getAllProducts() async {
    final doc =
        await _api.fireStore.collection(AppConst.productCollection).get();
    if (doc.docs.isEmpty) return [];
    return doc.docs.map((e) => ProductModel.fromMap(e.data(), e.id)).toList();
  }

  Future<List<ProductModel>> getAllProductsUser(String userId) async {
    final doc = await _api.fireStore
        .collection(AppConst.productCollection)
        .where("userId", isEqualTo: userId)
        .get();
    if (doc.docs.isEmpty) return [];
    return doc.docs.map((e) => ProductModel.fromMap(e.data(), e.id)).toList();
  }

  Future<CustomerModel?> customer(String id) async {
    final customer = await _api.fireStore
        .collection(AppConst.customerCollection)
        .doc(id)
        .get();
    if (!customer.exists || customer.data() == null) return null;
    return CustomerModel.fromMap(customer.data()!, id);
  }

  Future<List<CustomerModel>> getCustomers() async {
    final snapShot =
        await _api.fireStore.collection(AppConst.customerCollection).get();
    if (snapShot.docs.isEmpty) return [];
    return snapShot.docs
        .map((dos) => CustomerModel.fromMap(dos.data(), dos.id))
        .toList();
  }
  Future<List<CustomerModel>> searchCustomers(String name) async {
    final snapShot =
        await _api.fireStore.collection(AppConst.customerCollection).orderBy("name")
            .startAt([name]).endAt(["$name\uf8ff"]).get();
    if (snapShot.docs.isEmpty) return [];
    return snapShot.docs
        .map((dos) => CustomerModel.fromMap(dos.data(), dos.id))
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

  Future<void> updateProduct(ProductModel product) async {
    return await _api.fireStore
        .collection(AppConst.productCollection)
        .doc(product.id)
        .update(product.toMap());
  }

  Future<void> removeProductFromFirestore(String id,) async {
    await _api.fireStore
        .collection(AppConst.productCollection)
        .doc(id)
        .delete();
  }

  Future<void> deleteImagesFromStorage(
      List<String> imageUrls, String folderId) async {
    for (final imageUrl in imageUrls) {
      final storageRef = _api.storage.refFromURL(imageUrl);
      await storageRef.delete();
    }
  }

  Future<void> deleteImagesFromStorageIfFolderEmpty(String folderId) async {
    final folderRef =
        _api.storage.ref().child(AppConst.productCollection).child(folderId);
    final folderResult = await folderRef.listAll();
    if (folderResult.items.isEmpty && folderResult.prefixes.isEmpty) {
      await folderRef.delete();
    }
  }

  Future<void> clearProductImages(String folderId) async {
    await _api.storage
        .ref(AppConst.productCollection)
        .child('/$folderId')
        .delete();
  }

  Future<void> updateProductImages(String id, List<String> images) async {
    await _api.fireStore
        .collection(AppConst.productCollection)
        .doc(id)
        .update({AppConst.images: images});
  }


}
