import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBHelper {
  static final DBHelper instance = DBHelper._();
  static Database? _db;

  DBHelper._();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('trips.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE trips(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      imageUrl TEXT,
      date TEXT,
      description TEXT,
      guests INTEGER
    )
  ''');
  }

  Future<int> insertTrip(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('trips', row);
  }

}
