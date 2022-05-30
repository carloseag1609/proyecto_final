import 'dart:io';
import 'package:path/path.dart';
import 'package:proyecto_final/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<Database?> initDB() async {
    // Ruta donde se almacenara la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'MoviesDB4.db');

    print(path);

    // Crear la base de datos
    return await openDatabase(
      path,
      version: 10,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS actors(
            id INTEGER PRIMARY KEY,
            name TEXT,
            alias TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS genres(
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS filmstudios(
            id INTEGER PRIMARY KEY,
            name TEXT,
            logo TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS movies(
            id INTEGER PRIMARY KEY,
            title TEXT,
            originalLanguage TEXT,
            overview TEXT,
            poster TEXT,
            release TEXT,
            filmStudioId INTEGER,
            FOREIGN KEY(filmStudioId) REFERENCES filmstudios(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS moviehasactors(
            id  INTEGER PRIMARY KEY NOT NULL,
            movieId INTEGER,
            actorId INTEGER,
            FOREIGN KEY(movieId) REFERENCES movies(id),
            FOREIGN KEY(actorId) REFERENCES actors(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS moviehasgenres(
            id  INTEGER PRIMARY KEY NOT NULL,
            movieId INTEGER,
            genreId INTEGER,
            FOREIGN KEY(movieId) REFERENCES movies(id),
            FOREIGN KEY(genreId) REFERENCES genres(id)
          )
        ''');
      },
    );
  }

  // Future<int> nuevoScan(Movie movie) async {
  //   final db = await database;
  //   final res = await db!.insert('Movies', movie.toJson());
  //   return res;
  // }

  // Future<ScanModel> getScanById(int id) async {
  //   final db = await database;
  //   final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);
  //   return ScanModel.fromJson(res.first);
  // }

  // Future<List<ScanModel>> getAllScans() async {
  //   final db = await database;
  //   final res = await db!.query('Scans');
  //   return res.map<ScanModel>((scan) => ScanModel.fromJson(scan)).toList();
  // }

  // Future<List<ScanModel>> getScansByType(String type) async {
  //   final db = await database;
  //   final res = await db!.query('Scans', where: 'tipo = ?', whereArgs: [type]);
  //   return res.map((rawScan) => ScanModel.fromJson(rawScan)).toList();
  // }

  // Future<int> updateScan(ScanModel nuevoScan) async {
  //   final db = await database;
  //   final res = await db!.update('Scans', nuevoScan.toJson(),
  //       where: 'id = ?', whereArgs: [nuevoScan.id]);
  //   return res;
  // }

  // Future<int> deleteScan(int id) async {
  //   final db = await database;
  //   final res = await db!.delete('Scans', where: 'id = ?', whereArgs: [id]);
  //   return res;
  // }

  // Future<int> deleteScansByType(String type) async {
  //   final db = await database;
  //   final res = await db!.delete('Scans', where: 'tipo = ?', whereArgs: [type]);
  //   return res;
  // }

  // Future<int> deleteAllScans() async {
  //   final Database? db = await database;
  //   final int res = await db!.rawDelete('''
  //     DELETE FROM Scans
  //   ''');
  //   return res;
  // }
}
