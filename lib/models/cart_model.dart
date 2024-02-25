import 'package:equatable/equatable.dart';
import 'package:shop/config/constants/constance.dart';

class CartModelCustomer extends Equatable {
  final String cartId;
  final String productId;
  final int quantity;

 const CartModelCustomer({
    required this.cartId,
    required this.productId,
    required this.quantity,
  });


  CartModelCustomer copyWith({
    String? cartId,
    String? productId,
    int? quantity,
  }) {
    return CartModelCustomer(
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppConst.cartId: this.cartId,
      AppConst.productId: this.productId,
      AppConst.quantity: this.quantity,
    };
  }

  factory CartModelCustomer.fromMap(Map<String, dynamic> map) {
    return CartModelCustomer(
      cartId: map[AppConst.cartId] as String,
      productId: map[AppConst.productId] as String,
      quantity: map[AppConst.quantity] as int,
    );
  }
  static const  non=CartModelCustomer(quantity: 1,cartId: "",productId: "",);

  @override
  List<Object> get props => [cartId, productId, quantity];
}
