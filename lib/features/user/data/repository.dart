import '../../../core/error/error_handler.dart';
import '../../../models/customer.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import 'data.dart';

class UserRepository {
  const UserRepository(this._data, this._handler);
  final UserData _data;
  final ErrorHandler _handler;

  Future<ProductModel> addProduct(ProductModel product) async =>
      await _handler.future(_addProduct(product));
  Future<UserModel> signIn(String email, String password) async =>
      await _handler.future(_signIn(email, password));
  Future<void> logOut() async => await _handler.future(_logOut());
  Future<UserModel> _signIn(String email, String password) async {
    final userCredential = await _data.signIn(email, password);
    if (userCredential.user == null) throw Exception('admin not found');
    final user = await _data.user(userCredential.user!.uid);
    if (user == null) throw Exception('failed to get user');
    bool isStored = await _data.storeId(user.id);
    if (!isStored) throw Exception('failed to store id');
    isStored = await _data.typeStore();
    if (!isStored) throw Exception('failed to store type');
    return user;
  }

  Future<ProductModel> _addProduct(ProductModel product) async {
    List<String> urls = [];
    for (String path in product.images) {
      urls.add(await _data.uploadImage(path, product.folderId));
    }
    product = product.copyWith(images: urls);
    return await _data.addProduct(product);
  }

  Future<void> _logOut() async {
    await _data.logOut();
  }

  Future<ProductModel> getProduct(
    String id,
  ) async =>
      await _handler.future(_data.getProduct(
        id,
      ));

  Future<UserModel?> getUser(String id) async {
    return await _handler.future(_data.getUser(id));
  }

  String? getId() => _handler.normal(_data.getId());

  Future<void> updateProduct(ProductModel product) async =>
      await _handler.future(_updateProduct(product));

  Future<void> _updateProduct(ProductModel product) async {
    return await _data.updateProduct(product);
  }

  Future<CustomerModel?> customer(String id) async {
    return await _handler.future(_data.customer(id));
  }

  Future<List<ProductModel>> search(String name) async {
    return await _data.search(name);
  }
  Future<List<CustomerModel>> getCustomers() async =>
      await _handler.future(_data.getCustomers());
  Future<List<CustomerModel>> searchCustomers(String name) async =>
      await _handler.future(_data.searchCustomers(name));
  Future<List<ProductModel>> getAllProductUser(String userId) async {
    return await _handler.future(_data.getAllProductsUser(userId));
  }

  Future<List<ProductModel>> getAllProducts() async {
    return await _handler.future(_data.getAllProducts());
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      await _deleteImagesFromStorage(product.images, product.folderId);
      await _data.removeProductFromFirestore(product.id);
    } catch (e) {
      throw Exception('Failed to delete product.');
    }
  }

  Future<void> _deleteImagesFromStorage(
    List<String> imageUrls,
    String folderId,
  ) async {
    try {
      await _data.deleteImagesFromStorage(imageUrls, folderId);
    } catch (e) {
      throw Exception('Failed to delete images from storage.');
    }
  }
}
