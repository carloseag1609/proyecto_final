import 'package:flutter/cupertino.dart';
import 'package:proyecto_final/models/actor_model.dart';
import 'package:proyecto_final/models/movie_model.dart';
import 'package:proyecto_final/providers/db_provider.dart';

class ActorsProvider extends ChangeNotifier {
  List<Actor> actors = [];

  Future<void> insertFilmStudios(Actor actor) async {
    final db = await DBProvider.db.database;
    final res = await db!.rawInsert('''
        insert into actors (
          name,alias
        ) values (
          '${actor.name}',
          '${actor.alias}'
        )
    ''');
    notifyListeners();
  }

  // select g.id, g.name FROM moviehasgenres inner join genres g on g.id = moviehasgenres.genreId where movieId = 1

  Future<List<Actor>> getMovieActors(int movieId) async {
    print('Movie id $movieId');
    final db = await DBProvider.db.database;
    final res = await db!.rawQuery('''
      select a.id, a.name, a.alias from moviehasactors inner join actors a on a.id = moviehasactors.actorId where movieId = $movieId;
    ''');
    final res2 = await db!.rawQuery('''
      select * from moviehasactors;
    ''');
    print(res);
    print(res2);
    final movieActors =
        res.map<Actor>((actor) => Actor.fromJson(actor)).toList();
    return movieActors;
  }

  // void getAllActors() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.query('Actors');
  //   final dbActors = res.map<Actor>((actor) => Actor.fromJson(actor)).toList();
  //   print(dbActors.length);
  // }

  Future<List<Actor>> getAllActors() async {
    final db = await DBProvider.db.database;
    final res = await db!.query('Actors');
    final dbActors = res.map<Actor>((actor) => Actor.fromJson(actor)).toList();
    actors = dbActors;
    return actors;
  }

  Future<List<Movie>> getActorMovies(int actorId) async {
    final db = await DBProvider.db.database;
    final res = await db!.rawQuery('''
      select m.id, m.title, m.originalLanguage, m.poster, m."release", m.overview, m.filmStudioId, f.name, f.logo
      from moviehasactors 
        inner join movies m on m.id = moviehasactors.movieId 
        inner join filmstudios f on f.id = m.filmStudioId 
      where actorId = $actorId;
    ''');
    final movies = res.map<Movie>((movie) => Movie.fromJson(movie)).toList();
    return movies;
  }

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
