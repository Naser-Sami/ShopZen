part of 'address_cubit.dart';

class AddressState extends Equatable {
  const AddressState({
    required this.address,
    required this.defaultAddress,
    required this.selectedAddress,
  });

  final List<AddressEntity> address;
  final bool defaultAddress;
  final String selectedAddress;

  // copyWith
  AddressState copyWith({
    List<AddressEntity>? address,
    bool? defaultAddress,
    String? selectedAddress,
  }) {
    return AddressState(
      address: address ?? this.address,
      defaultAddress: defaultAddress ?? this.defaultAddress,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }

  // fromJson
  factory AddressState.fromJson(Map<String, dynamic> json) {
    return AddressState(
      address: (json['address'] as List<dynamic>)
          .map((e) => AddressEntity.fromJson(e))
          .toList(),
      defaultAddress: json['defaultAddress'] as bool,
      selectedAddress: json['selectedAddress'] as String,
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'address': address.map((e) => e.toJson()).toList(),
      'defaultAddress': defaultAddress,
      'selectedAddress': selectedAddress,
    };
  }

  @override
  List<Object> get props => [address, defaultAddress, selectedAddress];
}
