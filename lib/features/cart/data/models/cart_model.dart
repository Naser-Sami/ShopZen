import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  const CartModel({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  final num? id;
  final List<CartProductModel> products;
  final num? total;
  final num? discountedTotal;
  final num? userId;
  final num? totalProducts;
  final num? totalQuantity;

  CartModel copyWith({
    num? id,
    List<CartProductModel>? products,
    num? total,
    num? discountedTotal,
    num? userId,
    num? totalProducts,
    num? totalQuantity,
  }) {
    return CartModel(
      id: id ?? this.id,
      products: products ?? this.products,
      total: total ?? this.total,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      userId: userId ?? this.userId,
      totalProducts: totalProducts ?? this.totalProducts,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"],
      products: json["products"] == null
          ? []
          : List<CartProductModel>.from(
              json["products"]!.map((x) => CartProductModel.fromJson(x))),
      total: json["total"],
      discountedTotal: json["discountedTotal"],
      userId: json["userId"],
      totalProducts: json["totalProducts"],
      totalQuantity: json["totalQuantity"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": products.map((x) => x.toJson()).toList(),
        "total": total,
        "discountedTotal": discountedTotal,
        "userId": userId,
        "totalProducts": totalProducts,
        "totalQuantity": totalQuantity,
      };

  @override
  String toString() {
    return "$id, $products, $total, $discountedTotal, $userId, $totalProducts, $totalQuantity, ";
  }

  @override
  List<Object?> get props => [
        id,
        products,
        total,
        discountedTotal,
        userId,
        totalProducts,
        totalQuantity,
      ];
}

class CartProductModel extends Equatable {
  const CartProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  final num? id;
  final String? title;
  final num? price;
  final num? quantity;
  final num? total;
  final num? discountPercentage;
  final num? discountedTotal;
  final String? thumbnail;

  CartProductModel copyWith({
    num? id,
    String? title,
    num? price,
    num? quantity,
    num? total,
    num? discountPercentage,
    num? discountedTotal,
    String? thumbnail,
  }) {
    return CartProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json["id"],
      title: json["title"],
      price: json["price"],
      quantity: json["quantity"],
      total: json["total"],
      discountPercentage: json["discountPercentage"],
      discountedTotal: json["discountedTotal"],
      thumbnail: json["thumbnail"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "quantity": quantity,
        "total": total,
        "discountPercentage": discountPercentage,
        "discountedTotal": discountedTotal,
        "thumbnail": thumbnail,
      };

  @override
  String toString() {
    return "$id, $title, $price, $quantity, $total, $discountPercentage, $discountedTotal, $thumbnail, ";
  }

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        quantity,
        total,
        discountPercentage,
        discountedTotal,
        thumbnail,
      ];
}
