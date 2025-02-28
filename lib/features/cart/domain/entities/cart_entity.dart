import 'package:equatable/equatable.dart';

import '/features/cart/data/data.dart';

class CartEntity extends Equatable {
  const CartEntity({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  final num? id;
  final List<CartProductEntity> products;
  final num? total;
  final num? discountedTotal;
  final num? userId;
  final num? totalProducts;
  final num? totalQuantity;

  CartEntity copyWith({
    num? id,
    List<CartProductEntity>? products,
    num? total,
    num? discountedTotal,
    num? userId,
    num? totalProducts,
    num? totalQuantity,
  }) {
    return CartEntity(
      id: id ?? this.id,
      products: products ?? this.products,
      total: total ?? this.total,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      userId: userId ?? this.userId,
      totalProducts: totalProducts ?? this.totalProducts,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  // From Model
  factory CartEntity.fromModel(CartModel model) {
    return CartEntity(
      id: model.id,
      products: model.products.map((e) => CartProductEntity.fromModel(e)).toList(),
      total: model.total,
      discountedTotal: model.discountedTotal,
      userId: model.userId,
      totalProducts: model.totalProducts,
      totalQuantity: model.totalQuantity,
    );
  }

  // To Model
  CartModel toModel() {
    return CartModel(
      id: id,
      products: products.map((e) => e.toModel()).toList(),
      total: total,
      discountedTotal: discountedTotal,
      userId: userId,
      totalProducts: totalProducts,
      totalQuantity: totalQuantity,
    );
  }

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

class CartProductEntity extends Equatable {
  const CartProductEntity({
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

  CartProductEntity copyWith({
    num? id,
    String? title,
    num? price,
    num? quantity,
    num? total,
    num? discountPercentage,
    num? discountedTotal,
    String? thumbnail,
  }) {
    return CartProductEntity(
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

  // From Model
  factory CartProductEntity.fromModel(CartProductModel model) {
    return CartProductEntity(
      id: model.id,
      title: model.title,
      price: model.price,
      quantity: model.quantity,
      total: model.total,
      discountPercentage: model.discountPercentage,
      discountedTotal: model.discountedTotal,
      thumbnail: model.thumbnail,
    );
  }

  // To Model
  CartProductModel toModel() {
    return CartProductModel(
      id: id,
      title: title,
      price: price,
      quantity: quantity,
      total: total,
      discountPercentage: discountPercentage,
      discountedTotal: discountedTotal,
      thumbnail: thumbnail,
    );
  }

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
