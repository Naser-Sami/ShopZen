import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class AddressEntity extends Equatable {
  final String id;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String addressNickname;
  final String fullAddress;
  final bool isDefaultAddress;
  final LatLng latLng;

  // constructor
  const AddressEntity({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.addressNickname,
    required this.fullAddress,
    required this.isDefaultAddress,
    required this.latLng,
  });

  // copyWith
  AddressEntity copyWith({
    String? id,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    String? addressNickname,
    String? fullAddress,
    bool? isDefaultAddress,
    LatLng? latLng,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      addressNickname: addressNickname ?? this.addressNickname,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefaultAddress: isDefaultAddress ?? this.isDefaultAddress,
      latLng: latLng ?? this.latLng,
    );
  }

  // empty constructor
  factory AddressEntity.empty() {
    return const AddressEntity(
      id: '',
      street: '',
      city: '',
      state: '',
      zipCode: '',
      country: '',
      addressNickname: '',
      fullAddress: '',
      isDefaultAddress: false,
      latLng: LatLng(0, 0),
    );
  }

  // fromJson
  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    return AddressEntity(
      id: json['id'] as String,
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      addressNickname: json['addressNickname'] as String,
      fullAddress: json['fullAddress'] as String,
      isDefaultAddress: json['isDefaultAddress'] as bool,
      latLng: LatLng(
        json['latLng']['latitude'] as double,
        json['latLng']['longitude'] as double,
      ),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'addressNickname': addressNickname,
      'fullAddress': fullAddress,
      'isDefaultAddress': isDefaultAddress,
      'latLng': {
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      },
    };
  }

  @override
  List<Object?> get props => [
        id,
        street,
        city,
        state,
        zipCode,
        country,
        addressNickname,
        fullAddress,
        isDefaultAddress,
        latLng,
      ];
}
