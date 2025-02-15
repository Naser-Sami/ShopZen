import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
  final String name;
  final String image;

  const CategoriesEntity({
    required this.name,
    required this.image,
  });

  // copyWith method
  CategoriesEntity copyWith({
    String? name,
    String? image,
  }) {
    return CategoriesEntity(
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  // to string method
  @override
  String toString() {
    return 'CategoriesEntity(name: $name, image: $image)';
  }

  @override
  List<Object?> get props => [name, image];
}
