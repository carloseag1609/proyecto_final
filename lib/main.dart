import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/actors_provider.dart';
import 'package:proyecto_final/providers/film_studios_provider.dart';
import 'package:proyecto_final/providers/genres_provider.dart';
import 'package:proyecto_final/providers/movies_provider.dart';
import 'package:proyecto_final/providers/ui_provider.dart';
import 'package:proyecto_final/views/actor_movies_view.dart';
import 'package:proyecto_final/views/actors_view.dart';
import 'package:proyecto_final/views/add_actor.dart';
import 'package:proyecto_final/views/add_film_studios.dart';
import 'package:proyecto_final/views/add_movie_view.dart';
import 'package:proyecto_final/views/edit_movie_view.dart';
import 'package:proyecto_final/views/film_studio_list_view.dart';
import 'package:proyecto_final/views/movie_details_view.dart';
import 'package:proyecto_final/views/movies_list_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => MoviesProvider()),
        ChangeNotifierProvider(create: (_) => GenresProvider()),
        ChangeNotifierProvider(create: (_) => ActorsProvider()),
        ChangeNotifierProvider(create: (_) => FilmStudiosProvider())
      ],
      child: MaterialApp(
        title: 'Proyecto Final',
        debugShowCheckedModeBanner: false,
        initialRoute: 'movies',
        routes: {
          'movies': (_) => MoviesListView(),
          'add-movie': (_) => AddMovieView(),
          'edit-movie': (_) => EditMovieView(),
          'details': (_) => const MovieDetailsView(),
          'film-studios': (_) => const FilmStudioListView(),
          'add-film-studios': (_) => AddFilmStudiosView(),
          'actors': (_) => ActorsListView(),
          'add-actor': (_) => AddActorView(),
          'actor-movies': (_) => ActorMoviesView()
        },
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
      ),
    );
  }
}
