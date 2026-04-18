import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await inintialDB();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> inintialDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "Doctor.db");
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  Future<void> _onUpgrade(Database db, int oldversion, int newversion) async {}

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''

CREATE TABLE "Doctor"(

"id" INTEGER PRIMARY KEY AUTOINCREMENT,
"name" TEXT NOT NULL,
"specialty" TEXT NOT NULL,
"Location" TEXT NOT NULL,
"Phone" TEXT NOT NULL,
"email" TEXT NOT NULL,
)
''');
  }

  Future<List<Map<dynamic, dynamic>>> readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
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
