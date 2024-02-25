import 'package:equatable/equatable.dart';
import '../config/constants/constance.dart';

class SearchModel extends Equatable {
  const SearchModel({
    required this.id,
    required this.name,
    required this.image,
  });

  final String id;
  final String name;
  final String image;

  SearchModel copyWith({
    String? id,
    String? name,
    String? image,
  }) =>
      SearchModel(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
      );

  factory SearchModel.fromMap(Map<String, dynamic> map, String id) =>
      SearchModel(
        id: id,
        name: map[AppConst.name],
        image: map[AppConst.image],
      );

  @override
  List<Object> get props => [id, name, image];
}
