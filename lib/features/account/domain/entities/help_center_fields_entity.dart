import 'package:equatable/equatable.dart';

class HelpCenterFieldsEntity extends Equatable {
  final String icon;
  final String name;

  const HelpCenterFieldsEntity({
    required this.icon,
    required this.name,
  });

  HelpCenterFieldsEntity copyWith({
    String? icon,
    String? name,
  }) =>
      HelpCenterFieldsEntity(
        icon: icon ?? this.icon,
        name: name ?? this.name,
      );

  @override
  List<Object?> get props => [icon, name];
}
