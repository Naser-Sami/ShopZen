import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:shop_zen/core/_core.dart';

class TestModel {
  final int id;
  final String name;

  TestModel({required this.id, required this.name});

  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}

void main() {
  late DatabaseService<TestModel> databaseService;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    databaseService = DatabaseService<TestModel>(
      tableName: 'test_table',
      fromMap: (map) => TestModel.fromMap(map),
      toMap: (model) => model.toMap(),
      createTableQuery:
          'CREATE TABLE test_table (id INTEGER PRIMARY KEY, name TEXT)',
    );
    await databaseService.database;
  });

  test('Database initializes correctly', () async {
    final db = await databaseService.database;
    expect(db.isOpen, true);
  });

  test('Insert and retrieve data', () async {
    final db = await databaseService.database;
    final model = TestModel(id: 2, name: 'Test Name 2');
    await db.insert('test_table', model.toMap());

    final result =
        await db.query('test_table', where: 'id = ?', whereArgs: [1]);
    expect(result.isNotEmpty, true);
    expect(result.first['name'], 'Test Name');
  });

  test('Delete data', () async {
    final db = await databaseService.database;
    await db.delete('test_table', where: 'id = ?', whereArgs: [1]);

    final result =
        await db.query('test_table', where: 'id = ?', whereArgs: [1]);
    expect(result.isEmpty, true);
  });
}
