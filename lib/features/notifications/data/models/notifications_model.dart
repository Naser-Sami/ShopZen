import 'package:equatable/equatable.dart';

class NotificationsModel extends Equatable {
  final String id;
  final String title;
  final String body;
  final String? data;
  final DateTime createdAt;
  final bool isRead;
  final String icon;
  final String type;

  const NotificationsModel({
    required this.id,
    required this.title,
    required this.body,
    this.data,
    required this.createdAt,
    required this.isRead,
    required this.icon,
    required this.type,
  });

  // from map
  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      id: map['id'] ?? "",
      title: map['title'] ?? "",
      body: map['body'] ?? "",
      data: map['data'] ?? "",
      createdAt: DateTime.parse(map['createdAt']),
      isRead: map['isRead'] ?? false,
      icon: map['icon'] ?? "",
      type: map['type'] ?? "",
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'data': data,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
      'icon': icon,
      'type': type,
    };
  }

  // string
  @override
  String toString() {
    return 'NotificationsModel(id: $id, title: $title, body: $body, data: $data, createdAt: $createdAt, isRead: $isRead, icon: $icon, type: $type)';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        data,
        createdAt,
        isRead,
        icon,
        type,
      ];
}
