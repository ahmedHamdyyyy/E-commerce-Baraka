import 'package:firebase_auth/firebase_auth.dart';

import '../../../config/constants/constance.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/cache_services.dart';
import '../../../models/admin.dart';
import '../../../models/user.dart';

class AdminData {
  const AdminData(this._api, this._cache);
  final ApiServices _api;
  final CacheServices _cache;

  Future<UserCredential> signIn(String email, String password) async =>
      await _api.auth
          .signInWithEmailAndPassword(email: email, password: password);

  Future<AdminModel?> admin(String id) async {
    final admin =
        await _api.fireStore.collection(AppConst.adminCollection).doc(id).get();
    if (!admin.exists || admin.data() == null) return null;
    return AdminModel.fromMap(admin.data()!, id);
  }

  Future<bool> idStore(String id) async =>
      await _cache.shared.setString(AppConst.id, id);
  Future<bool> typeStore() async =>
      await _cache.shared.setString(AppConst.type, AppConst.adminScreen);
  Future<AdminModel?> getAdmin(String id) async {
    final snapshot =
        await _api.fireStore.collection(AppConst.adminCollection).doc(id).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return AdminModel.fromMap(snapshot.data()!, id);
  }

  //HOME ADMIN

  Future<UserCredential> addUser(String email, String password) async =>
      await _api.auth
          .createUserWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> addAdmin(String email, String password) async =>
      await _api.auth
          .createUserWithEmailAndPassword(email: email, password: password);
  Future<void> storeAdmin(AdminModel user) async => await _api.fireStore
      .collection(AppConst.adminCollection)
      .doc(user.id)
      .set(user.toMap());

  Future<void> storeUser(UserModel user) async => await _api.fireStore
      .collection(AppConst.userCollection)
      .doc(user.id)
      .set(user.toMap());

  Future<void> deleteUser(String id) async =>
      await _api.fireStore.collection(AppConst.userCollection).doc(id).delete();
  Future<List<UserModel>> getUsers() async {
    final snapShot =
        await _api.fireStore.collection(AppConst.userCollection).get();
    if (snapShot.docs.isEmpty) return [];
    return snapShot.docs
        .map((dos) => UserModel.fromMap(dos.data(), dos.id))
        .toList();
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
