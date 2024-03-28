import 'package:newtronic_apps/data/model/response_api_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;
  static DatabaseService? _instance;
  DatabaseService._internal() {
    _instance = this;
  }
  factory DatabaseService() => _instance ?? DatabaseService._internal();
  static const String _tblDownloaded = 'tblDownloaded';

  Future<Database> _initDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/video.db', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tblDownloaded(
             id INTEGER PRIMARY KEY,
             title TEXT,
             description TEXT,
             url TEXT,
             type TEXT)''');
    }, version: 1);
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    } else {
      null;
    }

    return _database;
  }

  Future<void> addDownloaded(Playlist playlist) async {
    final db = await database;
    await db?.insert(_tblDownloaded, playlist.toJson());
  }

  Future<List<Playlist>> getDownloaded() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblDownloaded);
    return results.map((res) => Playlist.fromJson(res)).toList();
  }

  Future<Map> getDownloadById(String id) async {
    final db = await database;
    List<Map<String, dynamic>>? results = await db?.query(
      _tblDownloaded,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results?.isNotEmpty == true) {
      return results?.first ?? {};
    } else {
      return {};
    }
  }

  Future<void> deleteDownloaded(String id) async {
    final db = await database;
    await db?.delete(
      _tblDownloaded,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
