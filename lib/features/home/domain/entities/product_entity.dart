import 'package:equatable/equatable.dart';
import '/features/home/_home.dart';

class ProductEntity extends Equatable {
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
  final DimensionsEntity? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ReviewEntity> reviews;
  final String? returnPolicy;
  final num? minimumOrderQuantity;
  final MetaEntity? meta;
  final List<String> images;
  final String? thumbnail;

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
  });

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
    );
  }

  // from model method
  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      category: model.category,
      price: model.price,
      discountPercentage: model.discountPercentage,
      rating: model.rating,
      stock: model.stock,
      tags: model.tags,
      brand: model.brand,
      sku: model.sku,
      weight: model.weight,
      dimensions: DimensionsEntity.fromModel(model.dimensions),
      warrantyInformation: model.warrantyInformation,
      shippingInformation: model.shippingInformation,
      availabilityStatus: model.availabilityStatus,
      reviews: model.reviews.map((review) => ReviewEntity.fromModel(review)).toList(),
      returnPolicy: model.returnPolicy,
      minimumOrderQuantity: model.minimumOrderQuantity,
      meta: MetaEntity.fromModel(model.meta),
      images: model.images,
      thumbnail: model.thumbnail,
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
      dimensions: dimensions?.toModel(),
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      reviews: reviews.map((review) => review.toModel()).toList(),
      returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity,
      meta: meta?.toModel(),
      images: images,
      thumbnail: thumbnail,
    );
  }

  // to string method
  @override
  String toString() {
    return 'ProductEntity(id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, tags: $tags, brand: $brand, sku: $sku, weight: $weight, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, reviews: $reviews, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, images: $images, thumbnail: $thumbnail)';
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
        thumbnail
      ];
}

class DimensionsEntity extends Equatable {
  const DimensionsEntity({
    required this.width,
    required this.height,
    required this.depth,
  });

  final num? width;
  final num? height;
  final num? depth;

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

  // from model method
  factory DimensionsEntity.fromModel(DimensionsModel? model) {
    return DimensionsEntity(
      width: model?.width,
      height: model?.height,
      depth: model?.depth,
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

class MetaEntity extends Equatable {
  const MetaEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? barcode;
  final String? qrCode;

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

class ReviewEntity extends Equatable {
  const ReviewEntity({
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

  // from model method
  factory ReviewEntity.fromModel(ReviewModel? model) {
    return ReviewEntity(
      rating: model?.rating,
      comment: model?.comment,
      date: model?.date,
      reviewerName: model?.reviewerName,
      reviewerEmail: model?.reviewerEmail,
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
