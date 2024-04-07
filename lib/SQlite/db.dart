import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DB {

  static Future<Database> init() async {
    final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'notes.db'), onCreate: (db, version) => createDb(db), version: 1);
  } 

  static void createDb(Database db) {
    db.execute("CREATE TABLE users (id TEXT PRIMARY KEY, username TEXT, password TEXT)");
    db.execute("CREATE TABLE contents (id TEXT PRIMARY KEY, content TEXT)");
    db.execute("CREATE TABLE notes (id TEXT PRIMARY KEY, title TEXT, date TEXT)");
    db.execute("CREATE TABLE note_contents (id TEXT PRIMARY KEY, note_id TEXT, content_id TEXT)");
  }

  static Future<List<Map<String, dynamic>>> login({
    required String username, 
    required String password
  }) async {
    final db = await DB.init();
    return db.rawQuery("SELECT username, password FROM users WHERE username = '$username' AND password = '$password'");
  }

  static Future<int?> register({
    required String username,
    required String password
  }) async {
    final db = await DB.init();
    return await db.insert("users", {
      "username": username,
      "password": password
    }, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getNotes() async {
    final db = await DB.init();
    return db.rawQuery("SELECT a.date, a.id note_id, b.id note_content_id, c.id desc_id, GROUP_CONCAT(a.title) parentTitle, c.content FROM notes a LEFT JOIN note_contents b ON a.id = b.note_id LEFT JOIN contents c ON c.id = b.content_id GROUP BY a.id");
  }

}