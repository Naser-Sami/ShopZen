import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

import '/features/_features.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity extends Equatable {
  @HiveField(0)
  final num id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final num price;

  @HiveField(5)
  final num discountPercentage;

  @HiveField(6)
  final num rating;

  @HiveField(7)
  final num stock;

  @HiveField(8)
  final List<String> tags;

  @HiveField(9)
  final String brand;

  @HiveField(10)
  final String sku;

  @HiveField(11)
  final num weight;

  @HiveField(12)
  final DimensionsEntity dimensions;

  @HiveField(13)
  final String warrantyInformation;

  @HiveField(14)
  final String shippingInformation;

  @HiveField(15)
  final String availabilityStatus;

  @HiveField(16)
  final List<ReviewEntity> reviews;

  @HiveField(17)
  final String returnPolicy;

  @HiveField(18)
  final num minimumOrderQuantity;

  @HiveField(19)
  final MetaEntity meta;

  @HiveField(20)
  final List<String> images;

  @HiveField(21)
  final String thumbnail;

  @HiveField(22)
  final bool isFavorite;

  const ProductEntity({
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
    this.isFavorite = false,
  });

  // from model method
  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      id: model.id ?? 0,
      title: model.title ?? '',
      description: model.description ?? '',
      category: model.category ?? '',
      price: model.price ?? 0,
      discountPercentage: model.discountPercentage ?? 0,
      rating: model.rating ?? 0,
      stock: model.stock ?? 0,
      tags: model.tags,
      brand: model.brand ?? '',
      sku: model.sku ?? '',
      weight: model.weight ?? 0,
      dimensions: DimensionsEntity.fromModel(model.dimensions),
      warrantyInformation: model.warrantyInformation ?? '',
      shippingInformation: model.shippingInformation ?? '',
      availabilityStatus: model.availabilityStatus ?? '',
      reviews: model.reviews.map((review) => ReviewEntity.fromModel(review)).toList(),
      returnPolicy: model.returnPolicy ?? '',
      minimumOrderQuantity: model.minimumOrderQuantity ?? 0,
      meta: MetaEntity.fromModel(model.meta),
      images: model.images,
      thumbnail: model.thumbnail ?? '',
    );
  }

  // to model method
  ProductModel toModel() {
    return ProductModel(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags.map((tag) => tag.toString()).toList(),
      brand: brand,
      sku: sku,
      weight: weight,
      dimensions: dimensions.toModel(),
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      reviews: reviews.map((review) => review.toModel()).toList(),
      returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity,
      meta: meta.toModel(),
      images: images,
      thumbnail: thumbnail,
    );
  }

  // copyWith method
  ProductEntity copyWith({
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
    DimensionsEntity? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<ReviewEntity>? reviews,
    String? returnPolicy,
    num? minimumOrderQuantity,
    MetaEntity? meta,
    List<String>? images,
    String? thumbnail,
    bool? isFavorite,
  }) {
    return ProductEntity(
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
      isFavorite: isFavorite ?? this.isFavorite,
    );
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
        isFavorite
      ];
}

// DimensionsEntity Adapter
@HiveType(typeId: 1)
class DimensionsEntity extends Equatable {
  @HiveField(0)
  final num width;

  @HiveField(1)
  final num height;

  @HiveField(2)
  final num depth;

  const DimensionsEntity({
    required this.width,
    required this.height,
    required this.depth,
  });

  // from model method
  factory DimensionsEntity.fromModel(DimensionsModel? model) {
    return DimensionsEntity(
      width: model?.width ?? 0,
      height: model?.height ?? 0,
      depth: model?.depth ?? 0,
    );
  }

  // to model method
  DimensionsModel toModel() {
    return DimensionsModel(
      width: width,
      height: height,
      depth: depth,
    );
  }

  DimensionsEntity copyWith({
    num? width,
    num? height,
    num? depth,
  }) {
    return DimensionsEntity(
      width: width ?? this.width,
      height: height ?? this.height,
      depth: depth ?? this.depth,
    );
  }

  @override
  List<Object?> get props => [width, height, depth];
}

// MetaEntity Adapter
@HiveType(typeId: 2)
class MetaEntity extends Equatable {
  @HiveField(0)
  final DateTime? createdAt;

  @HiveField(1)
  final DateTime? updatedAt;

  @HiveField(2)
  final String? barcode;

  @HiveField(3)
  final String? qrCode;

  const MetaEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  // from model method
  factory MetaEntity.fromModel(MetaModel? model) {
    return MetaEntity(
      createdAt: model?.createdAt,
      updatedAt: model?.updatedAt,
      barcode: model?.barcode,
      qrCode: model?.qrCode,
    );
  }

  // to model method
  MetaModel toModel() {
    return MetaModel(
      createdAt: createdAt,
      updatedAt: updatedAt,
      barcode: barcode,
      qrCode: qrCode,
    );
  }

  MetaEntity copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
  }) {
    return MetaEntity(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      barcode: barcode ?? this.barcode,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  @override
  List<Object?> get props => [createdAt, updatedAt, barcode, qrCode];
}

// ReviewEntity Adapter
@HiveType(typeId: 3)
class ReviewEntity extends Equatable {
  @HiveField(0)
  final num rating;

  @HiveField(1)
  final String comment;

  @HiveField(2)
  final DateTime? date;

  @HiveField(3)
  final String reviewerName;

  @HiveField(4)
  final String reviewerEmail;

  const ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  // from model method
  factory ReviewEntity.fromModel(ReviewModel? model) {
    return ReviewEntity(
      rating: model?.rating ?? 0,
      comment: model?.comment ?? '',
      date: model?.date,
      reviewerName: model?.reviewerName ?? '',
      reviewerEmail: model?.reviewerEmail ?? '',
    );
  }

  // to model method
  ReviewModel toModel() {
    return ReviewModel(
      rating: rating,
      comment: comment,
      date: date,
      reviewerName: reviewerName,
      reviewerEmail: reviewerEmail,
    );
  }

  ReviewEntity copyWith({
    num? rating,
    String? comment,
    DateTime? date,
    String? reviewerName,
    String? reviewerEmail,
  }) {
    return ReviewEntity(
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      reviewerName: reviewerName ?? this.reviewerName,
      reviewerEmail: reviewerEmail ?? this.reviewerEmail,
    );
  }

  @override
  List<Object?> get props => [rating, comment, date, reviewerName, reviewerEmail];
}
