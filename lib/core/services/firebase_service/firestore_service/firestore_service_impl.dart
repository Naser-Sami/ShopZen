import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '/core/_core.dart';

class FirestoreServiceImpl<T> implements IFirestoreService<T> {
  final FirebaseFirestore _firestore;
  final T Function(Map<String, dynamic> data, String id) _fromJson;

  FirestoreServiceImpl(
    this._fromJson, {
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Result<T>> getDocument(String path) async {
    try {
      final doc = await _firestore.doc(path).get();
      if (doc.exists) {
        return Result.success(_fromJson(doc.data()!, doc.id));
      }
      return Result.failure('Document not found');
    } on FirebaseException catch (e) {
      return Result.failure(_handleFirestoreError(e));
    }
  }

  @override
  Future<Result<List<T>>> getCollection(String path) async {
    try {
      final snapshot = await _firestore.collection(path).get();
      final results = snapshot.docs.map((doc) => _fromJson(doc.data(), doc.id)).toList();
      return Result.success(results);
    } on FirebaseException catch (e) {
      return Result.failure(_handleFirestoreError(e));
    }
  }

  @override
  Future<Result<void>> setDocument(String path, Map<String, dynamic> data) async {
    try {
      log("Attempting to create document at path: $path");
      log("Document data: ${data.toString()}");

      final docRef = _firestore.doc(path);
      await docRef.set(data);

      log("Document created successfully");
      log("Document ID: ${docRef.id}");
      return const Result.success(null);
    } on FirebaseException catch (e) {
      log("Firestore Error: ${e.code}", error: e.stackTrace);
      return Result.failure(_handleFirestoreError(e));
    } catch (e, stack) {
      log("Unexpected Error", error: stack);
      return Result.failure('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Result<void>> updateDocument(String path, Map<String, dynamic> data) async {
    try {
      await _firestore.doc(path).update(data);
      return const Result.success(null);
    } on FirebaseException catch (e) {
      return Result.failure(_handleFirestoreError(e));
    }
  }

  @override
  Future<Result<void>> deleteDocument(String path) async {
    try {
      await _firestore.doc(path).delete();
      return const Result.success(null);
    } on FirebaseException catch (e) {
      return Result.failure(_handleFirestoreError(e));
    }
  }

  @override
  Future<Result<List<T>>> queryCollection({
    required String path,
    required List<QueryCondition> conditions,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(path);

      for (final condition in conditions) {
        query = query.where(
          condition.field,
          isEqualTo: condition.value,
          // For advanced queries, extend QueryCondition with operator and value
        );
      }

      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      final results = snapshot.docs
          .map((doc) => _fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      return Result.success(results);
    } on FirebaseException catch (e) {
      return Result.failure(_handleFirestoreError(e));
    }
  }

  String _handleFirestoreError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'You don\'t have permission to access this resource';
      case 'not-found':
        return 'Requested document not found';
      case 'aborted':
        return 'Operation aborted';
      case 'unavailable':
        return 'Service unavailable';
      default:
        return 'Firestore error: ${e.message}';
    }
  }
}
