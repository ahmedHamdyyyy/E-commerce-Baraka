import 'package:equatable/equatable.dart';
import '../config/constants/constance.dart';
import 'address.dart';

class CustomerModel extends Equatable {
  const CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.favorite,
    required this.address,
    required this.userCart,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final List<String> favorite;
  final List userCart;
  final AddressModel address;

  static const non = CustomerModel(
    id: '',
    name: '',
    email: '',
    phone: '',
    favorite: [],
    userCart: [],
    address: AddressModel.non,
  );

  CustomerModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    List<String>? favorite,
    List? userCart,
    AddressModel? address,
  }) =>
      CustomerModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        favorite: favorite ?? this.favorite,
        userCart: userCart ?? this.userCart,
        address: address ?? this.address,
      );

  Map<String, dynamic> toMap() => {
        AppConst.name: name,
        AppConst.mail: email,
        AppConst.phone: phone,
        AppConst.favorite: favorite,
      AppConst.userCart: userCart,


        AppConst.address: address.toMap(),
      };

  factory CustomerModel.fromMap(Map<String, dynamic> map, String id) =>
      CustomerModel(
        id: id,
        name: map[AppConst.name],
        email: map[AppConst.mail],
        phone: map[AppConst.phone],
        favorite: List.from(map[AppConst.favorite]).cast<String>(),
        userCart: List.from(map[AppConst.userCart]),
        address: AddressModel.fromMap(map[AppConst.address]),
      );

  @override
  List<Object> get props => [
        id,
        name,
        userCart,
        email,
        phone,
        favorite,
        address,
      ];
}
