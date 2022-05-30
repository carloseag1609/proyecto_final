import 'package:flutter/cupertino.dart';
import 'package:proyecto_final/models/filmstudio_model.dart';
import 'package:proyecto_final/providers/db_provider.dart';

class FilmStudiosProvider extends ChangeNotifier {
  List<FilmStudio> filmStudios = [];

  Future<void> insertFilmStudios(FilmStudio fs) async {
    final db = await DBProvider.db.database;
    final res = await db!.rawInsert('''
        insert into filmstudios (
          name,logo
        ) values (
          '${fs.name}',
          '${fs.logo}'
        )
    ''');
    notifyListeners();
  }

  // select g.id, g.name FROM moviehasgenres inner join genres g on g.id = moviehasgenres.genreId where movieId = 1

  Future<List<FilmStudio>> getAllFilmStudios() async {
    final db = await DBProvider.db.database;
    final res = await db!.query('FilmStudios');
    print(res);
    final filmStudios =
        res.map<FilmStudio>((fs) => FilmStudio.fromJson(fs)).toList();
    return filmStudios;
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
