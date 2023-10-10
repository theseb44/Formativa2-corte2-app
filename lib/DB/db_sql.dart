import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:parcial2/movie_class.dart';

export 'db_sql.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  final String tableName = 'Movieos';

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._internal();
    }
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final path = join('lib/DB/database', 'movies.db');

    final db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        codigo TEXT,
        nombre TEXT,
        genero REAL,
        director REAL
      )
    ''');
    });

    return db;
  }

  Future<int> insertMovie(Movie movie) async {
    final db = await database;
    return await db.insert(tableName, movie.toMap());
  }

 
  Future<List<Map<String, dynamic>>> getAllMovies() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(tableName);
  return maps;
}

  
  Future<int> updateMovie(Movie movie) async {
    final db = await database;
    return await db.update(tableName, movie.toMap(),
        where: 'id = ?', whereArgs: [movie.id]);
  }


  Future<int> deleteMovie(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
