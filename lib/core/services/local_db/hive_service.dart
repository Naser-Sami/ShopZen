import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class IHiveService<T> {
  Future<void> init();
  Future<void> add(T item);
  Future<void> put(dynamic key, T item);
  T? get(dynamic key);
  List<T> getAll();
  Future<void> delete(dynamic key);
  Future<void> clear();
}

@singleton
class HiveService<T> implements IHiveService<T> {
  final String boxName;
  final bool isEncrypted;
  final bool crashRecovery;
  final TypeAdapter<T>? adapter;
  late Box<T> _box;

  HiveService({
    required this.boxName,
    this.adapter,
    this.isEncrypted = false,
    this.crashRecovery = true,
  });

  @override
  Future<void> init() async {
    Hive.initFlutter();
    // ..registerAdapter<T>(adapter); // Replace with your adapter

    if (isEncrypted && !Hive.isBoxOpen(boxName)) {
      // Implement your encryption key management
      final encryptionKey = await getEncryptionKey();
      _box = await Hive.openBox<T>(
        boxName,
        encryptionCipher: encryptionKey != null ? HiveAesCipher(encryptionKey) : null,
        crashRecovery: crashRecovery,
      );
    } else {
      _box = await Hive.openBox<T>(boxName);
    }
  }

  @override
  Future<void> add(T item) async => await _box.add(item);

  @override
  Future<void> put(dynamic key, T item) async => await _box.put(key, item);

  @override
  T? get(dynamic key) => _box.get(key);

  @override
  List<T> getAll() => _box.values.toList();

  @override
  Future<void> delete(dynamic key) async => await _box.delete(key);

  @override
  Future<void> clear() async => await _box.clear();

  Future<Uint8List?> getEncryptionKey() async {
    // Implement secure key storage/retrieval
    // Consider using SecureStorageService
    return null;
  }
}
