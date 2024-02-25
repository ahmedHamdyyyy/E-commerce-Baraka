import 'package:equatable/equatable.dart';

import '../config/constants/constance.dart';

class CartModel extends Equatable {
  final String id;
  final String name;
  final String image;
  final String productId;
  final String customerId;

  final int count;

  const CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productId,
    required this.customerId,

    required this.count,
  });
  static const non = CartModel(
    id: "",
    name: "",
    image: "",
    productId: "",
    customerId: "",

    count: 0,
  );

  CartModel copyWith({
    String? id,
    String? name,
    String? image,
    String? productId,
    String? customerId,
    List<String>? color,
    int? count,
  }) =>
      CartModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        productId: productId ?? this.productId,
        customerId: customerId ?? this.customerId,

        count: count ?? this.count,
      );

  Map<String, dynamic> toMap() => {
        //AppConst.id:id,
        AppConst.name: name,
        AppConst.image: image,
        AppConst.productId: productId,
        AppConst.customerId: customerId,

        AppConst.count: count,
      };

  factory CartModel.fromMap(Map<String, dynamic> map, String id) => CartModel(
        id: id,
        name: map[AppConst.name],
        image: map[AppConst.image],
        productId: map[AppConst.productId],
        customerId: map[AppConst.customerId],
        count: map[AppConst.count],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        productId,
        customerId,

        count,
      ];
}
