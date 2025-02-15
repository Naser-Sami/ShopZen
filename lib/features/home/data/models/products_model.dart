import 'package:equatable/equatable.dart';

class ProductsModel extends Equatable {
  const ProductsModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<ProductModel> products;
  final num? total;
  final num? skip;
  final num? limit;

  ProductsModel copyWith({
    List<ProductModel>? products,
    num? total,
    num? skip,
    num? limit,
  }) {
    return ProductsModel(
      products: products ?? this.products,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      products: json["products"] == null
          ? []
          : List<ProductModel>.from(
              json["products"].map((x) => ProductModel.fromJson(x))),
      total: json["total"],
      skip: json["skip"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "products": products.map((x) => x.toJson()).toList(),
        "total": total,
        "skip": skip,
        "limit": limit,
      };

  @override
  String toString() {
    return "$products, $total, $skip, $limit, ";
  }

  @override
  List<Object?> get props => [
        products,
        total,
        skip,
        limit,
      ];
}

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  final num? id;
  final String? title;
  final String? description;
  final String? category;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final num? stock;
  final List<String> tags;
  final String? brand;
  final String? sku;
  final num? weight;
  final DimensionsModel? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewModel> reviews;
  final String? returnPolicy;
  final num? minimumOrderQuantity;
  final MetaModel? meta;
  final List<String> images;
  final String? thumbnail;

  ProductModel copyWith({
    num? id,
    String? title,
    String? description,
    String? category,
    num? price,
    num? discountPercentage,
    num? rating,
    num? stock,
    List<String>? tags,
    String? brand,
    String? sku,
    num? weight,
    DimensionsModel? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<ReviewModel>? reviews,
    String? returnPolicy,
    num? minimumOrderQuantity,
    MetaModel? meta,
    List<String>? images,
    String? thumbnail,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      tags: tags ?? this.tags,
      brand: brand ?? this.brand,
      sku: sku ?? this.sku,
      weight: weight ?? this.weight,
      dimensions: dimensions ?? this.dimensions,
      warrantyInformation: warrantyInformation ?? this.warrantyInformation,
      shippingInformation: shippingInformation ?? this.shippingInformation,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      reviews: reviews ?? this.reviews,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
      meta: meta ?? this.meta,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      category: json["category"],
      price: json["price"],
      discountPercentage: json["discountPercentage"],
      rating: json["rating"],
      stock: json["stock"],
      tags: json["tags"] == null ? [] : List<String>.from(json["tags"].map((x) => x)),
      brand: json["brand"],
      sku: json["sku"],
      weight: json["weight"],
      dimensions: json["dimensions"] == null
          ? null
          : DimensionsModel.fromJson(json["dimensions"]),
      warrantyInformation: json["warrantyInformation"],
      shippingInformation: json["shippingInformation"],
      availabilityStatus: json["availabilityStatus"],
      reviews: json["reviews"] == null
          ? []
          : List<ReviewModel>.from(json["reviews"].map((x) => ReviewModel.fromJson(x))),
      returnPolicy: json["returnPolicy"],
      minimumOrderQuantity: json["minimumOrderQuantity"],
      meta: json["meta"] == null ? null : MetaModel.fromJson(json["meta"]),
      images:
          json["images"] == null ? [] : List<String>.from(json["images"].map((x) => x)),
      thumbnail: json["thumbnail"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "category": category,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "tags": tags.map((x) => x).toList(),
        "brand": brand,
        "sku": sku,
        "weight": weight,
        "dimensions": dimensions?.toJson(),
        "warrantyInformation": warrantyInformation,
        "shippingInformation": shippingInformation,
        "availabilityStatus": availabilityStatus,
        "reviews": reviews.map((x) => x.toJson()).toList(),
        "returnPolicy": returnPolicy,
        "minimumOrderQuantity": minimumOrderQuantity,
        "meta": meta?.toJson(),
        "images": images.map((x) => x).toList(),
        "thumbnail": thumbnail,
      };

  @override
  String toString() {
    return "$id, $title, $description, $category, $price, $discountPercentage, $rating, $stock, $tags, $brand, $sku, $weight, $dimensions, $warrantyInformation, $shippingInformation, $availabilityStatus, $reviews, $returnPolicy, $minimumOrderQuantity, $meta, $images, $thumbnail, ";
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        discountPercentage,
        rating,
        stock,
        tags,
        brand,
        sku,
        weight,
        dimensions,
        warrantyInformation,
        shippingInformation,
        availabilityStatus,
        reviews,
        returnPolicy,
        minimumOrderQuantity,
        meta,
        images,
        thumbnail,
      ];
}

class DimensionsModel extends Equatable {
  const DimensionsModel({
    required this.width,
    required this.height,
    required this.depth,
  });

  final num? width;
  final num? height;
  final num? depth;

  DimensionsModel copyWith({
    num? width,
    num? height,
    num? depth,
  }) {
    return DimensionsModel(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }

  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return DimensionsModel(
      width: json["width"],
      height: json["height"],
      depth: json["depth"],
    );
  }

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "depth": depth,
      };

  @override
  String toString() {
    return "$width, $height, $depth, ";
  }

  @override
  List<Object?> get props => [
        width,
        height,
        depth,
      ];
}

class MetaModel extends Equatable {
  const MetaModel({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? barcode;
  final String? qrCode;

  MetaModel copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
  }) {
    return MetaModel(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      barcode: barcode ?? this.barcode,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      barcode: json["barcode"],
      qrCode: json["qrCode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "barcode": barcode,
        "qrCode": qrCode,
      };

  @override
  String toString() {
    return "$createdAt, $updatedAt, $barcode, $qrCode, ";
  }

  @override
  List<Object?> get props => [
        createdAt,
        updatedAt,
        barcode,
        qrCode,
      ];
}

class ReviewModel extends Equatable {
  const ReviewModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  final num? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  ReviewModel copyWith({
    num? rating,
    String? comment,
    DateTime? date,
    String? reviewerName,
    String? reviewerEmail,
  }) {
    return ReviewModel(
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerEmail: reviewerEmail ?? this.reviewerEmail,
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json["rating"],
      comment: json["comment"],
      date: DateTime.tryParse(json["date"] ?? ""),
      reviewerName: json["reviewerName"],
      reviewerEmail: json["reviewerEmail"],
    );
  }

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
        "date": date?.toIso8601String(),
        "reviewerName": reviewerName,
        "reviewerEmail": reviewerEmail,
      };

  @override
  String toString() {
    return "$rating, $comment, $date, $reviewerName, $reviewerEmail, ";
  }

  @override
  List<Object?> get props => [
        rating,
        comment,
        date,
        reviewerName,
        reviewerEmail,
      ];
}
