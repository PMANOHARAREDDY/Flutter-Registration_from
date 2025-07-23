import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._();
  static Database? _db;
  /// Singleton instance
  DBHelper._();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('users.db');
    return _db!;
  }

  Future<Database> _initDB(String filename) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filename);
    /// users table
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            email TEXT PRIMARY KEY,
            name TEXT,
            mobile TEXT,
            address TEXT,
            password TEXT
          );
        ''');
      },
    );
  }

  /// CRUD methods

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    final result = await db.query('users',
      where: 'email = ?',
      whereArgs: [email]);
    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.update(
      'users',
      user,
      where: 'email = ?',
      whereArgs: [user['email']],
    );
  }

  /// to Check whether certain user is present or not
  Future<bool> userExists(String email) async {
    final db = await database;
    final res = await db.query('users',
      where: 'email = ?',
      whereArgs: [email]
    );
    return res.isNotEmpty;
  }
}
