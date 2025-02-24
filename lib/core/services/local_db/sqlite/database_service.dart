import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService<T> {
  static Database? _database;
  static final List<Future<void> Function(Database)> _createTableCallbacks = [];
  static String dbName = 'app_database';
  static int dbVersion = 1;

  final String tableName;
  final T Function(Map<String, dynamic>) fromMap;
  final Map<String, dynamic> Function(T) toMap;

  DatabaseService({
    required this.tableName,
    required this.fromMap,
    required this.toMap,
    required String createTableQuery,
  }) {
    _createTableCallbacks.add((Database db) async {
      await db.execute(createTableQuery);
    });
  }

  static Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, '$dbName.db');

    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: (Database db, int version) async {
        for (var callback in _createTableCallbacks) {
          await callback(db);
        }
      },
    );
  }

  static Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  Future<int> insert(T item) async {
    final db = await database;
    return await db.insert(
      tableName,
      toMap(item),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<T>> getAll() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return maps.map((map) => fromMap(map)).toList();
  }

  Future<T?> getById(int id, String where, List<dynamic> whereArgs) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    if (maps.isNotEmpty) {
      return fromMap(maps.first);
    }
    return null;
  }

  Future<int> update(T item, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.update(
      tableName,
      toMap(item),
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }
}
