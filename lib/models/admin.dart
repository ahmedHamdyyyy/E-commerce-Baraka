import 'package:equatable/equatable.dart';

import '../config/constants/constance.dart';

class AdminModel extends Equatable {
  const AdminModel({
    required this.id,
    required this.name,
    required this.mail,
    required this.phone,
  });

  final String id;
  final String name;
  final String mail;
  final String phone;

  static const non = AdminModel(
    id: '',
    name: '',
    mail: '',
    phone: '',
  );

  AdminModel copyWith({
    String? id,
    String? name,
    String? mail,
    String? phone,
  }) =>
      AdminModel(
        id: id ?? this.id,
        name: name ?? this.name,
        mail: mail ?? this.mail,
        phone: phone ?? this.phone,
      );

  Map<String, dynamic> toMap() => {
        AppConst.name: name,
        AppConst.mail: mail,
        AppConst.phone: phone,
      };

  factory AdminModel.fromMap(Map<String, dynamic> map, String id) => AdminModel(
        id: id,
        name: map[AppConst.name],
        mail: map[AppConst.mail],
        phone: map[AppConst.phone],
      );

  @override
  List<Object> get props => [
        id,
        name,
        mail,
        phone,
      ];
}
