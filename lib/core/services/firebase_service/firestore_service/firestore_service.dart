import '/core/_core.dart';

abstract class IFirestoreService<T> {
  Future<Result<String>> addDocument(String path, Map<String, dynamic> data);
  Future<Result<T>> getDocument(String path);
  Future<Result<List<T>>> getCollection(String path);
  Future<Result<void>> setDocument(String path, Map<String, dynamic> data);
  Future<Result<void>> updateDocument(String path, Map<String, dynamic> data);
  Future<Result<void>> deleteDocument(String path);
  Future<Result<List<T>>> queryCollection({
    required String path,
    required List<QueryCondition> conditions,
    int? limit,
  });
}
