import 'package:equatable/equatable.dart';
import 'dart:convert';

import '../config/constants/constance.dart';

class AddressModel extends Equatable {
  const AddressModel({
    required this.city,
    required this.location,
  });

  final String city;
  final List<double> location;

  static const non = AddressModel(
    city: '',
    location: [],
  );

  AddressModel copyWith({
    String? city,
    List<double>? location,
  }) =>
      AddressModel(
        city: city ?? this.city,
        location: location ?? this.location,
      );

  Map<String, dynamic> toMap() => {
        AppConst.city: city,
        AppConst.location: location,
      };

  String toJson() => json.encode(toMap());

  factory AddressModel.fromMap(Map<String, dynamic> map) => AddressModel(
        city: map[AppConst.city] as String,
        location: List<double>.from((map[AppConst.location] as List)),
      );

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [
        city,
        location,
      ];
}
