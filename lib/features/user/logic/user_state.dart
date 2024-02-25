part of 'user_cubit.dart';

class UserState extends Equatable {
  final String msg;
  final String imagePath;
  final String imageMessagePath;
  final Status signInState;
  final Status getAllProductsStatus;
  final Status getAllProductsUserState;
  final Status searchProductsState;
  final Status updateProductStatus;
  final Status getCategoryProductsStatus;
  final Status searchCostomerStatus;
  final Status deleteProductStatus;
  final Status getAllCustomersStatus;
  final Status sendMessageStatus;
  final Status getDataUserState;
  final Status addProductStatus;
  final Status getProductStatus;
  final Status logOutState;
  final Status getCustomerStatus;
  final UserModel user;
  final CustomerModel customer;
  final ProductModel product;
  final List<ProductModel> products;
  final List<ProductModel> searchProduct;
  final List<CustomerModel> customers;
  final List<CustomerModel> searchCustomers;
  final List<ProductModel> productsUser;
  final List<ProductModel> categoryProducts;
  final List<ProductModel> userProducts;

  const UserState({
    this.msg = '',
    this.imagePath = '',
    this.imageMessagePath = '',
    this.getDataUserState = Status.initial,
    this.signInState = Status.initial,
    this.getAllProductsStatus = Status.initial,
    this.updateProductStatus = Status.initial,
    this.getAllProductsUserState = Status.initial,
    this.deleteProductStatus = Status.initial,
    this.getAllCustomersStatus = Status.initial,
    this.getCategoryProductsStatus = Status.initial,
    this.addProductStatus = Status.initial,
    this.logOutState = Status.initial,
    this.getCustomerStatus = Status.initial,
    this.sendMessageStatus = Status.initial,
    this.searchCostomerStatus = Status.initial,
    this.getProductStatus = Status.initial,
    this.searchProductsState = Status.initial,
    this.user = UserModel.non,
    this.product = ProductModel.non,
    this.customer = CustomerModel.non,
    this.products = const [],
    this.customers = const [],
    this.productsUser = const [],
    this.searchProduct = const [],
    this.categoryProducts = const [],
    this.userProducts = const [], this.searchCustomers = const [],
  });

  UserState copyWith({
    String? msg,
    String? imagePath,
    String? imageMessagePath,
    Status? signInState,
    Status? deleteProductStatus,
    Status? logOutState,
    Status? getAllProductsStatus,
    Status? sendMessageStatus,
    Status? getAllCustomersStatus,
    Status? searchProductsState,
    Status? searchCostomerStatus,
    Status? getDataUserState,
    Status? updateProductStatus,
    Status? getAllProductsUserState,
    Status? getCategoryProductsStatus,
    Status? addProductStatus,
    Status? getProductStatus,
    Status? getCustomerStatus,
    UserModel? user,
    CustomerModel? customer,
    ProductModel? product,
    List<ProductModel>? products,
    List<CustomerModel>? customers,
    List<CustomerModel>? searchCustomers,
    List<ProductModel>? productsUser,
    List<ProductModel>? searchProduct,
    List<ProductModel>? categoryProducts,
    List<ProductModel>? userProducts,
  }) =>
      UserState(
        msg: msg ?? this.msg,
        customer: customer ?? this.customer,
        searchCostomerStatus: searchCostomerStatus ?? this.searchCostomerStatus,
        searchCustomers: searchCustomers ?? this.searchCustomers,
        imageMessagePath: imageMessagePath ?? this.imageMessagePath,
        imagePath: imagePath ?? this.imagePath,
        getCustomerStatus: getCustomerStatus ?? this.getCustomerStatus,
        sendMessageStatus: sendMessageStatus ?? this.sendMessageStatus,
        customers: customers ?? this.customers,
        logOutState: logOutState ?? this.logOutState,
        product: product ?? this.product,
        searchProduct: searchProduct ?? this.searchProduct,
        getAllCustomersStatus:
            getAllCustomersStatus ?? this.getAllCustomersStatus,
        getDataUserState: getDataUserState ?? this.getDataUserState,
        deleteProductStatus: deleteProductStatus ?? this.deleteProductStatus,
        updateProductStatus: updateProductStatus ?? this.updateProductStatus,
        getAllProductsUserState:
            getAllProductsUserState ?? this.getAllProductsUserState,
        signInState: signInState ?? this.signInState,
        getProductStatus: getProductStatus ?? this.getProductStatus,
        getAllProductsStatus: getAllProductsStatus ?? this.getAllProductsStatus,
        getCategoryProductsStatus:
            getCategoryProductsStatus ?? this.getCategoryProductsStatus,
        addProductStatus: addProductStatus ?? this.addProductStatus,
        user: user ?? this.user,
        products: products ?? this.products,
        productsUser: productsUser ?? this.productsUser,
        categoryProducts: categoryProducts ?? this.categoryProducts,
        userProducts: userProducts ?? this.userProducts,
        searchProductsState: searchProductsState ?? this.searchProductsState,
      );

  @override
  List<Object> get props => [
        msg,
        getCustomerStatus,
        customer,
    searchProduct,
    searchProductsState,
        customers,
        updateProductStatus,
        getAllCustomersStatus,
        logOutState,
        product,
        signInState,
    searchCustomers,
        productsUser,
        deleteProductStatus,
        getProductStatus,imagePath,

        getDataUserState,
    sendMessageStatus,
        getAllProductsStatus,
        getAllProductsUserState,
        getCategoryProductsStatus,
    searchCostomerStatus,
        addProductStatus,
        user,
        products,
        categoryProducts,
        userProducts,
    imageMessagePath,      ];
}
