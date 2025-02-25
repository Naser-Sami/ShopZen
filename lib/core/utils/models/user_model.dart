import 'package:equatable/equatable.dart';
import '/core/_core.dart';

class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String profilePic;
  final String token;
  final String phone;
  final String address;
  final DateTime? createdAt;
  final String? dateOfBirth;
  final UserType userType;
  final String fcmToken;
  final String gender;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.token,
    required this.phone,
    required this.address,
    this.createdAt,
    this.dateOfBirth,
    required this.userType,
    required this.fcmToken,
    required this.gender,
  });

  // copy with method
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? profilePic,
    String? token,
    String? phone,
    String? address,
    DateTime? createdAt,
    String? dateOfBirth,
    UserType? userType,
    String? fcmToken,
    String? gender,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        email: email ?? this.email,
        profilePic: profilePic ?? this.profilePic,
        token: token ?? this.token,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        createdAt: createdAt ?? this.createdAt,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        userType: userType ?? this.userType,
        fcmToken: fcmToken ?? this.fcmToken,
        gender: gender ?? this.gender,
      );

  // fromJson method
  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      uid: id,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      profilePic: json['profilePic'] ?? "",
      token: json['token'] ?? "",
      phone: json['phone'] ?? "",
      address: json['address'] ?? "",
      createdAt: DateTime.tryParse(json['createdAt']),
      dateOfBirth: json['dateOfBirth'] ?? "",
      userType: UserType.values.byName(json['userType']),
      fcmToken: json['fcmToken'] ?? "",
      gender: json['gender'] ?? "",
    );
  }

  // toMap method
  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'profilePic': profilePic,
        'token': token,
        'phone': phone,
        'address': address,
        'createdAt': createdAt?.toIso8601String(),
        'dateOfBirth': dateOfBirth,
        'userType': userType.name,
        'fcmToken': fcmToken,
        'gender': gender,
      };

  // empty constructor
  const UserModel.empty({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.profilePic = '',
    this.token = '',
    this.phone = '',
    this.address = '',
    this.createdAt,
    this.dateOfBirth = '',
    this.userType = UserType.user,
    this.fcmToken = '',
    this.gender = '',
  });

  // string
  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, profilePic: $profilePic, token: $token, phone: $phone, address: $address, createdAt: $createdAt, dateOfBirth: $dateOfBirth userType: $userType, fcmToken: $fcmToken, gender: $gender)';
  }

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        profilePic,
        token,
        phone,
        address,
        createdAt,
        dateOfBirth,
        userType,
        fcmToken,
        gender,
      ];
}
