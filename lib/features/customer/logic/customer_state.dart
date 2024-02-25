part of 'customer_cubit.dart';

class CustomerState extends Equatable {
  final String msg;
  final bool isProductInCart;
  final String imagePath;
  final int theme; final double qty;
  final Status signInState;
  final Status getUserStatus;
  final Status signUpState;
  final Status getAllProductsStatus;
  final Status sendMessageState;
  final Status themeStatus;
  final Status getThemeStatus;
  final Status getCategoryProductsStatus;
  final Status searchProductsState;
  final Status getFavoriteProductsStatus;
  final Status addCartProductsState;
  final Status updateCustomerState;
  final Status deleteCartProductState;
  final Status getAllUsersState;
  final Status favoriteStatus;
  final Status logOutState;
  final Status getCartsProductStatus;
  final Status getProductStatus;
  final Status getDataUserState;
  final CustomerModel customer;
  final UserModel user;
  final CartModelCustomer  cart;
  final ProductModel product;
  final ProductModel productInCart;
  final CartModel cartModel;
  final List<ProductModel> products;
  final List<UserModel> users;
  final List<ProductModel> searchProduct;
  final List<CartModel> carts;
  final List<ProductModel> categoryProducts;
  final Map<String, CartModelCustomer> cartsProducts;
  // final List<SearchModel> searchList;
  final List<ProductModel> favoritesProducts;
 // final List<ProductModel> cartsProducts;

  const CustomerState({
    this.msg = '',
    this.isProductInCart=false,
    this.imagePath = '',
    this.theme = 0,this.qty = 1,
    this.signInState = Status.initial,
    this.getUserStatus = Status.initial,
    this.signUpState = Status.initial,
    this.getThemeStatus = Status.initial,
    this.themeStatus = Status.initial,
    this.sendMessageState = Status.initial,
    this.getAllProductsStatus = Status.initial,
    this.getCategoryProductsStatus = Status.initial,
    this.addCartProductsState = Status.initial,
    this.getFavoriteProductsStatus = Status.initial,
    this.getAllUsersState = Status.initial,
    this.favoriteStatus = Status.initial,
    this.getProductStatus = Status.initial,
    this.searchProductsState = Status.initial,
    this.getDataUserState = Status.initial,
    this.getCartsProductStatus = Status.initial,
    this.updateCustomerState = Status.initial,
    this.logOutState = Status.initial,
    this.deleteCartProductState = Status.initial,
    this.customer = CustomerModel.non,
    this.product = ProductModel.non,
    this.user = UserModel.non,
    this.cartModel = CartModel.non,
    this.productInCart = ProductModel.non,
    this.cart = CartModelCustomer.non,
    this.products = const [],
    //this.searchList = const [],
    this.searchProduct = const [],
   // this.cartsProducts = const [],
    this.carts = const [],
    this.categoryProducts = const [],
    this.users = const [],
    this.cartsProducts =  const {},
    this.favoritesProducts = const [],
  });

  CustomerState copyWith({
    String? msg,
    String? imagePath,
    bool? isProductInCart,
    int? theme, double? qty,
    Status? signInState,
    Status? themeStatus,
    Status? getThemeStatus,
    Status? getAllProductsStatus,
    Status? getAllUsersState,
    Status? signUpState,
    Status? getProductStatus,
    Status? getUserStatus,
    Status? updateCustomerState,
    Status? getCategoryProductsStatus,
    Status? getFavoriteProductsStatus,
    Status? getCartsProductStatus,
    Status? addCartProductsState,
    Status? logOutState,
    Status? deleteCartProductState,
    Status? favoriteStatus,
    Status? searchProductsState,
    Status? sendMessageState,
    Status? getDataUserState,
    CustomerModel? customer,
    UserModel? user,
    ProductModel? product,
    ProductModel? productInCart,
    CartModelCustomer?  cart,
    CartModel? cartModel,
    List<ProductModel>? products,
    List<UserModel>? users,
    List<ProductModel>? searchProduct,
    List<ProductModel>? categoryProducts,

    List<CartModel>? carts,
    Map<String, CartModelCustomer>? cartsProducts,
    List<SearchModel>? searchList,
    List<ProductModel>? favoritesProducts,
  }) =>
      CustomerState(
        msg: msg ?? this.msg,
        getUserStatus: getUserStatus ?? this.getUserStatus,
        isProductInCart: isProductInCart ?? this.isProductInCart,
        addCartProductsState: addCartProductsState ?? this.addCartProductsState,
        getAllUsersState: getAllUsersState ?? this.getAllUsersState,
        getThemeStatus: getThemeStatus ?? this.getThemeStatus,
        updateCustomerState: updateCustomerState ?? this.updateCustomerState,
        carts: carts ?? this.carts, cart: cart ?? this.cart,
        imagePath: imagePath ?? this.imagePath,
        theme: theme ?? this.theme,
        users: users ?? this.users,
        cartsProducts: cartsProducts ?? this.cartsProducts,
        user: user ?? this.user,
        productInCart: productInCart ?? this.productInCart,
        qty: qty ?? this.qty,
       // cartsProducts: cartsProducts ?? this.cartsProducts,
        themeStatus: themeStatus ?? this.themeStatus,
        sendMessageState: sendMessageState ?? this.sendMessageState,
        //searchList: searchList ?? this.searchList,
        searchProductsState: searchProductsState ?? this.searchProductsState,
        getProductStatus: getProductStatus ?? this.getProductStatus,
        getDataUserState: getDataUserState ?? this.getDataUserState,
        product: product ?? this.product,
        deleteCartProductState:
            deleteCartProductState ?? this.deleteCartProductState,
        getCartsProductStatus:
            getCartsProductStatus ?? this.getCartsProductStatus,
        signInState: signInState ?? this.signInState,
        signUpState: signUpState ?? this.signUpState,
        logOutState: logOutState ?? this.logOutState,
        searchProduct: searchProduct ?? this.searchProduct,
        getAllProductsStatus: getAllProductsStatus ?? this.getAllProductsStatus,
        getCategoryProductsStatus:
            getCategoryProductsStatus ?? this.getCategoryProductsStatus,
        getFavoriteProductsStatus:
            getFavoriteProductsStatus ?? this.getFavoriteProductsStatus,
        favoriteStatus: favoriteStatus ?? this.favoriteStatus,
        customer: customer ?? this.customer,
        products: products ?? this.products,
        categoryProducts: categoryProducts ?? this.categoryProducts,
        favoritesProducts: favoritesProducts ?? this.favoritesProducts,
        cartModel: cartModel ?? this.cartModel,

      );

  @override
  List<Object> get props => [
        msg,
    qty,
    isProductInCart,
        //searchList,
        product,
    cartsProducts,
    //cartsProducts,
    users,
    sendMessageState,
    productInCart,
    getAllUsersState,
        getThemeStatus,
        theme,
    user,
    getUserStatus,
        favoritesProducts,
        cartModel,
        getProductStatus,
        logOutState,
    imagePath,
        getDataUserState,
        updateCustomerState,
        addCartProductsState,
        deleteCartProductState,
        getCartsProductStatus,
        searchProduct,
        searchProductsState,
        signInState,
        getAllProductsStatus,
        getCategoryProductsStatus,
        getFavoriteProductsStatus,
        favoriteStatus,
        customer,
        products,
        categoryProducts,
        signUpState,
      ];
}
