import '/features/home/_home.dart';

class ProductsMapper {
  static List<ProductEntity> mapToEntity(List<ProductModel> products) {
    return products.map((product) => ProductEntity.fromModel(product)).toList();
  }

  static List<ProductModel> mapToModel(List<ProductEntity> products) {
    return products.map((product) => product.toModel()).toList();
  }
}
