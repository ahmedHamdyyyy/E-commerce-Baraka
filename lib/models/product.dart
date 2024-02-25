import 'package:equatable/equatable.dart';

import '../config/constants/constance.dart';

class ProductModel extends Equatable {
  final String id;
  final String userId;
  final String productName;
  final String category;
  final String desc;
  final int productPrice;
  final int discount;
  final String folderId;

  final List<String> images;

  const ProductModel({
    required this.id,
    required this.userId,
    required this.productName,
    required this.category,
    required this.desc,
    required this.productPrice,
    required this.discount,
    required this.folderId,
    required this.images,
  });
  static const non = ProductModel(
      userId: "",
      id: "",
      productName: "",
      desc: "",
      category: "",
      productPrice: -1,
      discount: -1,
      folderId: "",
      images: []);

  ProductModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? category,
    String? desc,
    int? count,
    int? discount,
    String? folderId,
    List<String>? images,
    List<String>? colors,
  }) =>
      ProductModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productName: name ?? productName,
        category: category ?? this.category,
        desc: desc ?? this.desc,
        productPrice: count ?? productPrice,
        discount: discount ?? this.discount,
        folderId: folderId ?? this.folderId,
        images: images ?? this.images,
      );

  Map<String, dynamic> create() => {
        AppConst.userId: userId,
        AppConst.name: productName,
        AppConst.category: category,
        AppConst.desc: desc,
        AppConst.count: productPrice,
        AppConst.discount: discount,
        AppConst.imagesFolderId: folderId,
        AppConst.images: images,
      };

  Map<String, dynamic> toMap() => {
        AppConst.userId: userId,
        AppConst.name: productName,
        AppConst.category: category,
        AppConst.desc: desc,
        AppConst.count: productPrice,
        AppConst.discount: discount,
        AppConst.imagesFolderId: folderId,
        AppConst.images: images,
      };

  factory ProductModel.fromMap(Map<String, dynamic> map, String id) =>
      ProductModel(
        id: id,
        userId: map[AppConst.userId],
        productName: map[AppConst.name],
        category: map[AppConst.category],
        desc: map[AppConst.desc],
        productPrice: map[AppConst.count],
        discount: map[AppConst.discount],
        folderId: map[AppConst.imagesFolderId],
        images: List<String>.from((map[AppConst.images] as List)),
      );

  @override
  List<Object> get props => [
        id,
        userId,
        productName,
        category,
        desc,
        productPrice,
        discount,
        folderId,
        images,
      ];
}
