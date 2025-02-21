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
  final UserType userType;
  final String fcmToken;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profilePic,
    required this.token,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.userType,
    required this.fcmToken,
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
    UserType? userType,
    String? fcmToken,
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
        userType: userType ?? this.userType,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  // fromJson method
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'] ?? "",
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        profilePic: json['profilePic'] ?? "",
        token: json['token'] ?? "",
        phone: json['phone'] ?? "",
        address: json['address'] ?? "",
        createdAt: DateTime.parse(json['createdAt']),
        userType: UserType.values.byName(json['userType']),
        fcmToken: json['fcmToken'] ?? "",
      );

  // toMap method
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'email': email,
        'profilePic': profilePic,
        'token': token,
        'phone': phone,
        'address': address,
        'createdAt': createdAt?.toIso8601String(),
        'userType': userType.name,
        'fcmToken': fcmToken,
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
    this.userType = UserType.user,
    this.fcmToken = '',
  });

  // string
  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, profilePic: $profilePic, token: $token, phone: $phone, address: $address, createdAt: $createdAt, userType: $userType, fcmToken: $fcmToken)';
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
        userType,
        fcmToken,
      ];
}
