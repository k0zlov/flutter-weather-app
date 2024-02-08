import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler<T> {
  Database? _database;
  final String tableName;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  DatabaseHandler({
    required this.tableName,
    required this.fromJson,
    required this.toJson,
  });

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }


  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        country TEXT NOT NULL,
        city TEXT NOT NULL,
        lat REAL NOT NULL,
        lon REAL NOT NULL
      )
    ''');
  }

  Future<int> insert(T item) async {
    final db = await database;
    return await db.insert(tableName, toJson(item));
  }

  Future<List<T>> getAll({String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName, where: where, whereArgs: whereArgs);
    return List.generate(maps.length, (i) => fromJson(maps[i]));
  }

  Future<int> delete({String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }
}