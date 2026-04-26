import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initialDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "Doctor.db");
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database updates here
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
       CREATE TABLE "Doctor"(
        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "full_name" TEXT NOT NULL,
        "medical_specialty" TEXT NOT NULL,
        "commune" TEXT,
        "district" TEXT,
        "address" TEXT,
        "phone_number" TEXT,
        "professional_email" TEXT UNIQUE,
        "appointment_phone" INTEGER DEFAULT 0,
        "appointment_in_person" INTEGER DEFAULT 0,
        "working_hours_from" TEXT,
        "working_hours_to" TEXT,
        "working_days" TEXT,
        "facebook" TEXT,
        "instagram" TEXT,
        "created_at" TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
