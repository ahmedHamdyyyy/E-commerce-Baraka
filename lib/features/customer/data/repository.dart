import 'package:shop/features/customer/logic/customer_cubit.dart';

import '../../../core/error/error_handler.dart';
import '../../../models/cart.dart';
import '../../../models/cart_model.dart';
import '../../../models/customer.dart';
import '../../../models/product.dart';
import '../../../models/search.dart';
import '../../../models/user.dart';
import 'data.dart';

class CustomerRepository {
  const CustomerRepository(this._data, this._handler);
  final CustomerData _data;
  final ErrorHandler _handler;

  String type() => _handler.normal(_isSignedIn());

  String _isSignedIn() => _data.isSignedIn() ? (_data.getType() ?? '') : '';
  int theme() => _data.checkTheme() ? _data.getTheme() ?? 0 : 0;
  Future setTheme(
    int theme,
  ) async =>
      await _data.setTheme(theme) ? null : throw Exception("failed");
  String lang() => _data.checkLang() ? _data.getLang() ?? 'en' : 'en';
  Future setLang(
    String lang,
  ) async =>
      await _data.setLang(lang) ? null : throw Exception("failed");

  Future<CustomerModel> signUp(CustomerModel customer, String password) async =>
      await _handler.future(_signUp(customer, password));
  Future<CustomerModel> signIn(String email, String password) async =>
      await _handler.future(_signIn(email, password));
  Future<CustomerModel?> getCustomer(String id) async =>
      await _handler.future(_getCustomer(id));
  Future<UserModel?> getUser(String id) async =>
      await _handler.future(_getUser(id));
  Future<List<ProductModel>> getAllProducts() async =>
      await _handler.future(_getAllProducts());
  Future<List<UserModel>> getAllUsers() async =>
      await _handler.future(_getAllUsers());
  Future<List<ProductModel>> getCategoryProducts(String category) async =>
      await _handler.future(_getCategoryProducts(category));
  Future<List<ProductModel>> getFavoriteProducts(List<String> ids) async =>
      await _handler.future(_getFavoriteProducts(ids));
  Future<void> deleteCartProduct(
    String id,
  ) async {
    await _handler.future(_deleteCartProduct(id));
  }

  Future<dynamic> googleSignIn1() async {
    await _handler.future(_data.googleSignIn1());
  }

  Future<List<CartModel>> getCartsProduct(String customerId) async =>
      await _handler.future(_getCartsProduct(customerId));

  Future<void> logOut() async => await _handler.future(_logOut());

  Future favorite(List<String> favorite, String id) async =>
      await _handler.future(_favorite(favorite, id));
  Future addInUserCart(String productId,int quantity) async =>
      await _handler.future(_addInUserCart(productId,quantity));

  Future<CustomerModel> _signUp(CustomerModel customer, String password) async {
    final userCredential = await _data.signUp(customer.email, password);
    if (userCredential.user != null) Exception('sign up failed');
    bool isStored = await _data.storeId(userCredential.user!.uid);
    if (!isStored) throw Exception('Failed To Store Id');
    final updatedCustomer = customer.copyWith(id: userCredential.user!.uid);
    isStored = await _data.typeStore();
    if (!isStored) throw Exception('failed to store type');
    await _data.storeCustomer(updatedCustomer);
    return updatedCustomer;
  }

  ProductModel? findByProdId(String productId,CustomerState state) {
    if (state.products.where((element) => element.id == productId).isEmpty) {
      return null;
    }
    return state.products.firstWhere((element) => element.id == productId);
  }


  Future<CustomerModel> _signIn(String email, String password) async {
    final userCredential = await _data.signIn(email, password);
    if (userCredential.user == null) throw Exception('sign in failed');
    final customer = await _data.customer(userCredential.user!.uid);
    if (customer == null) throw Exception('Customer Data Not Found');
    bool isStored = await _data.storeId(customer.id);
    if (!isStored) throw Exception('Failed To Store Id');
    isStored = await _data.typeStore();
    if (!isStored) throw Exception('failed to store type');
    return customer;
  }

  Future<List<ProductModel>> search(String name) async {
    return await _data.search(name);
  }

  Future<void> updateCustomer(CustomerModel customerModel) async =>
      await _handler.future(_data.updateCustomer(customerModel));
  Future<ProductModel> getProduct(String id) async =>
      await _handler.future(_data.getProduct(
        id,
      ));
  Future<List<ProductModel>> _getAllProducts() async =>
      await _data.getAllProducts();
  Future<List<UserModel>> _getAllUsers() async =>
      await _data.getUsers();

  Future<void> _favorite(List<String> favorite, String id) async =>
      await _data.favorite(favorite, id);
  Future<void> _addInUserCart(String userCart,int quantity) async =>
      await _data.addInUserCart(userCart,quantity);

  Future<List<ProductModel>> _getCategoryProducts(String category) async =>
      await _data.getCategoryProducts(category);

  Future<List<ProductModel>> _getFavoriteProducts(List<String> ids) async =>
      await _data.getFavoriteProducts(ids);

  Stream<List<ProductModel>> searchProduct(String searchNames) {
    return _data.searchProduct(searchNames);
  }

  Future<List<SearchModel>> searchProduct2(
      String searchNames, String id) async {
    return await _data.searchProduct2(searchNames, id);
  }

  Future<List<SearchModel>> searchProduct4(
    String searchNames,
  ) async {
    return await _data.searchProduct4(
      searchNames,
    );
  }

  Future<CartModel> addCard(
    CartModel product,
  ) async =>
      await _handler.future(_data.addCard(
        product,
      ));

  Future<Map<String, CartModelCustomer>?> getCartCustomer(String customerId) async {
    return await
    _data.getCartCustomer(customerId);
  }
  Future<void> updateQty({required CartModelCustomer cartModel}) async{

   return await _data.updateQty(cartModel: cartModel);
  }

  String? getId() => _handler.normal(_data.getId());
  Future<CustomerModel?> _getCustomer(String id) async =>
      await _data.getCustomer(id);
  Future<UserModel?> _getUser(String id) async =>
      await _data.getUser(id);
  Future<void> _deleteCartProduct(
    String id,
  ) async {
    await _data.deleteCartProduct(id);
  }

  Future<void> _logOut() async {
    await _data.logOut();
  }
  Future<List<CartModel>> _getCartsProduct(String customerId) async {
    return _data.getCartsProduct(customerId);
  }

  Future<void> removeCartItemFromFirestore({
    required String cartId,
    required String productId,
    required int qty,
  }) async => await _handler.future(_data.removeCartItemFromFirestore(cartId: cartId, productId: productId, qty: qty));
  Future<void> clearCartFromFirebase() async =>await _handler.future(_data. clearCartFromFirebase());

}
