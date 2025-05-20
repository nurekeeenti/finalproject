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

  Future<void> _onCreate(Database db, int version) async {
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

  // Create
  Future<int> insertTrip(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('trips', row);
  }

  // Read All
  Future<List<Map<String, dynamic>>> getAllTrips() async {
    final db = await instance.database;
    return await db.query('trips', orderBy: 'id DESC');
  }

  // Read by ID
  Future<Map<String, dynamic>?> getTripById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'trips',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update
  Future<int> updateTrip(int id, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.update(
      'trips',
      row,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete by ID
  Future<int> deleteTrip(int id) async {
    final db = await instance.database;
    return await db.delete(
      'trips',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all
  Future<int> deleteAllTrips() async {
    final db = await instance.database;
    return await db.delete('trips');
  }

  // Close DB
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
