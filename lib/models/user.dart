import 'package:equatable/equatable.dart';
import '../config/constants/constance.dart';
import 'address.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.mail,
    required this.phone,
    required this.shopName,
    required this.date,
    required this.address,
  });
  final String id;
  final String mail;
  final String phone;
  final String shopName;
  final String date;
  final AddressModel address;

  static const non = UserModel(
    id: '',
    mail: '',
    phone: '',
    shopName: '',
    date: '',
    address: AddressModel.non,
  );

  UserModel copyWith({
    String? id,
    String? mail,
    String? phone,
    String? shopName,
    String? date,
    AddressModel? address,
  }) =>
      UserModel(
        id: id ?? this.id,
        mail: mail ?? this.mail,
        phone: phone ?? this.phone,
        shopName: shopName ?? this.shopName,
        date: date ?? this.date,
        address: address ?? this.address,
      );

  Map<String, dynamic> toMap() => {
        AppConst.mail: mail,
        AppConst.phone: phone,
        AppConst.shopName: shopName,
        AppConst.date: date,
        AppConst.address: address.toMap(),
      };

  factory UserModel.fromMap(Map<String, dynamic> map, String id) => UserModel(
        id: id,
        mail: map[AppConst.mail],
        phone: map[AppConst.phone],
        shopName: map[AppConst.shopName],
        date: map[AppConst.date],
        address: AddressModel.fromMap(map[AppConst.address]),
      );

  @override
  List<Object> get props => [
        id,
        mail,
        phone,
        shopName,
        date,
        address,
      ];
}
