import '../../../core/error/error_handler.dart';
import '../../../models/admin.dart';
import '../../../models/user.dart';
import 'data.dart';

class AdminRepository {
  AdminRepository(this._data, this._handler);
  final AdminData _data;
  final ErrorHandler _handler;

  Future<AdminModel> signIn(String email, String password) async =>
      await _handler.future(_signIn(email, password));

  Future<AdminModel> _signIn(String email, String password) async {
    final userCredential = await _data.signIn(email, password);
    if (userCredential.user == null) throw Exception('admin not found');
    final admin = await _data.admin(userCredential.user!.uid);
    if (admin == null) throw Exception('failed to get admin');
    bool isStored = await _data.idStore(admin.id);
    if (!isStored) throw Exception('failed to store id');
    isStored = await _data.typeStore();
    if (!isStored) throw Exception('failed to store type');
    return admin;
  }

  Future<UserModel> addUser(UserModel user, String password) async =>
      await _handler.future(_addUser(user, password));

  Future<AdminModel> addAdmin(AdminModel user, String password) async =>
      await _handler.future(_addAdmin(user, password));

  Future<List<UserModel>> getUsers() async =>
      await _handler.future(_getUsers());

//users
  Future<String> deleteUser(String id) async {
    await _data.deleteUser(id);
    return "delete success";
  }

  Future<AdminModel> _addAdmin(AdminModel user, String password) async {
    final userCredential = await _data.addAdmin(user.mail, password);
    if (userCredential.user == null) throw Exception('sign up failed');
    final updatedCustomer = user.copyWith(id: userCredential.user!.uid);
    await _data.storeAdmin(updatedCustomer);
    return updatedCustomer;
  }

  Future<UserModel> _addUser(UserModel user, String password) async {
    final userCredential = await _data.addUser(user.mail, password);
    if (userCredential.user == null) throw Exception('sign up failed');
    final updatedCustomer = user.copyWith(id: userCredential.user!.uid);
    await _data.storeUser(updatedCustomer);
    return updatedCustomer;
  }

  Future<List<UserModel>> _getUsers() async => await _data.getUsers();

  Future<String> resetPassword(
    String email,
  ) async {
    // ignore: prefer_typing_uninitialized_variables
    var message;
    await _data.resetPassword(email).then((value) {
      message = "Password reset email sent";
    }).catchError((e) {
      message = "Failed to send password reset email";
    });
    return message;
  }
}
