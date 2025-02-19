import 'package:equatable/equatable.dart';

class AccountFieldsEntity extends Equatable {
  final String icon;
  final String name;

  const AccountFieldsEntity({
    required this.icon,
    required this.name,
  });

  // copy with method
  AccountFieldsEntity copyWith({
    String? icon,
    String? name,
  }) {
    return AccountFieldsEntity(
      icon: icon ?? this.icon,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [icon, name];
}
