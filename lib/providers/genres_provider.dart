import 'package:flutter/cupertino.dart';
import 'package:proyecto_final/models/genre_model.dart';
import 'package:proyecto_final/providers/db_provider.dart';

class GenresProvider extends ChangeNotifier {
  List<Genre> genres = [];

  // void newMovie(Movie movie) async {
  //   final id = await DBProvider.db.nuevoScan(nuevoScan);
  //   nuevoScan.id = id;
  //   if (tipoSeleccionado == nuevoScan.tipo) {
  //     scans.add(nuevoScan);
  //     notifyListeners();
  //   }
  // }

  // select g.id, g.name FROM moviehasgenres inner join genres g on g.id = moviehasgenres.genreId where movieId = 1

  Future<List<Genre>> getMovieGenres(int movieId) async {
    final db = await DBProvider.db.database;
    final res = await db!.rawQuery('''
      select g.id, g.name FROM moviehasgenres inner join genres g on g.id = moviehasgenres.genreId where movieId = $movieId
    ''');
    final movieGenres =
        res.map<Genre>((genre) => Genre.fromJson(genre)).toList();
    return movieGenres;
  }

  // Future<List<>> getAllMovies() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.rawQuery('''
  //     SELECT * FROM movies inner join filmstudios f on f.id = movies.filmStudioId;
  //   ''');
  //   final dbMovies = res.map<Movie>((movie) => Movie.fromJson(movie)).toList();
  //   movies = dbMovies;
  // }

  // void cargarScansPorTipo(String tipo) async {
  //   final scans = await DBProvider.db.getScansByType(tipo);
  //   this.scans = [...scans];
  //   tipoSeleccionado = tipo;
  //   notifyListeners();
  // }

  // borrarTodos() async {
  //   await DBProvider.db.deleteAllScans();
  //   scans = [];
  //   notifyListeners();
  // }

  // borrarPorTipo() async {
  //   await DBProvider.db.deleteScansByType(tipoSeleccionado);
  //   cargarScansPorTipo(tipoSeleccionado);
  // }

  // borarScanPorId(int id) async {
  //   await DBProvider.db.deleteScan(id);
  //   cargarScansPorTipo(tipoSeleccionado);
  // }
}
