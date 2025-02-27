import 'package:hive_flutter/hive_flutter.dart';
import '/features/_features.dart';

void registerAllHiveAdapters() {
  // Register all adapters before using Hive
  if (!Hive.isAdapterRegistered(ProductEntityAdapter().typeId)) {
    Hive.registerAdapter(ProductEntityAdapter());
  }
  if (!Hive.isAdapterRegistered(DimensionsEntityAdapter().typeId)) {
    Hive.registerAdapter(DimensionsEntityAdapter());
  }
  if (!Hive.isAdapterRegistered(MetaEntityAdapter().typeId)) {
    Hive.registerAdapter(MetaEntityAdapter());
  }
  if (!Hive.isAdapterRegistered(ReviewEntityAdapter().typeId)) {
    Hive.registerAdapter(ReviewEntityAdapter());
  }
}
