import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/scanned_code.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  late Database _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'scanned_codes.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE scanned_codes(id INTEGER PRIMARY KEY AUTOINCREMENT, code TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertScannedCode(String code) async {
    await _database.insert(
      'scanned_codes',
      ScannedCode(code: code).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ScannedCode>> getScannedCodes() async {
    final List<Map<String, dynamic>> maps = await _database.query('scanned_codes');

    return List.generate(maps.length, (i) {
      return ScannedCode(
        id: maps[i]['id'],
        code: maps[i]['code'],
      );
    });
  }
}
