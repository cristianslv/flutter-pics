import 'package:sqflite/sqflite.dart';

class BancoDeDados {
  static BancoDeDados _instance;

  Database db;

  String onCreateSQL = '''
    CREATE TABLE pics (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      string TEXT,
      title TEXT,
      description TEXT,
      lat TEXT,
      long TEXT,
      date INTEGER
    );
  ''';

  BancoDeDados._privado();

  factory BancoDeDados() {
    return _instance ?? BancoDeDados._privado();
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute(onCreateSQL);
  }

  Future<void> openDb() async {
    if (db == null) {
      return await getDatabasesPath().then((value) async{
        String path = value + "pics.db";

        await openDatabase(path, version: 1, onCreate: onCreate).then((value) {
          db = value;
        });
      });
    }
  }
}