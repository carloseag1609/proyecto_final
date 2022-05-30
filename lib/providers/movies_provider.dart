import 'package:flutter/cupertino.dart';
import 'package:proyecto_final/models/movie_model.dart';
import 'package:proyecto_final/providers/db_provider.dart';

class MoviesProvider extends ChangeNotifier {
  List<Movie> movies = [];

  Future<bool> filmStudioInUse(int filmStudioId) async {
    final db = await DBProvider.db.database;
    final res = await db!.rawQuery('''
        select * from movies where filmStudioId = $filmStudioId
    ''');
    return res.length >= 1;
  }

  Future<int> insertMovie(Movie movie) async {
    final db = await DBProvider.db.database;
    final res = await db!.rawInsert('''
        insert into movies (
          title,originalLanguage,overview,poster,release,filmStudioId
        ) values (
          '${movie.title}',
          '${movie.originalLanguage}',
          '${movie.overview}',
          '${movie.poster}',
          '${movie.release}',
          ${movie.filmStudioId}
        )
    ''');
    notifyListeners();
    return res;
  }

  Future<void> addActors(List<int> actorsId, int movieId) async {
    print('Actors id $actorsId');
    final db = await DBProvider.db.database;
    for (var actorId in actorsId) {
      await db!.rawInsert('''
        insert into moviehasactors (
          movieId, actorId
        ) values (
          $movieId,
          $actorId
        )
      ''');
    }
    notifyListeners();
  }

  Future<List<Movie>> loadMovies() async {
    final db = await DBProvider.db.database;
    final res = await db!.rawQuery('''
      SELECT movies.id as id, title, originalLanguage, overview, poster, "release", filmStudioId, f.logo as logo, f.name as name FROM movies inner join filmstudios f on f.id = movies.filmStudioId;
    ''');
    final dbMovies = res.map<Movie>((movie) => Movie.fromJson(movie)).toList();
    movies = dbMovies;
    return dbMovies;
  }

  editMovie(Movie movie) async {
    print(movie.toJson());
    final db = await DBProvider.db.database;
    final res = await db!.rawUpdate('''
        update movies
        set 
          title = ?, 
          originalLanguage = ?,
          overview = ?,
          poster = ?,
          release = ?,
          filmStudioId = ?
        where id = ?
    ''', [
      movie.title,
      movie.originalLanguage,
      movie.overview,
      movie.poster,
      movie.release,
      movie.filmStudioId,
      movie.id
    ]);
    print(res);
    notifyListeners();
  }

  deleteMovie(int id) async {
    final db = await DBProvider.db.database;
    final res = await db!.delete('Movies', where: 'id = ?', whereArgs: [id]);
    final res2 = await db!
        .delete('MovieHasActors', where: 'movieId = ?', whereArgs: [id]);
    loadMovies();
    notifyListeners();
    return res;
  }
}
