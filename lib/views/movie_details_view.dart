import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/movie_model.dart';
import 'package:proyecto_final/providers/actors_provider.dart';
import 'package:proyecto_final/providers/genres_provider.dart';
import 'package:proyecto_final/providers/movies_provider.dart';

import '../widgets/custom_bottom_navbar.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({Key? key}) : super(key: key);

  void _delete(BuildContext context, int movieId) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Eliminar pelicula'),
          content: const Text('Deseas eliminar esta pelicula?'),
          actions: [
            TextButton(
              onPressed: () {
                moviesProvider.deleteMovie(movieId);
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Película eliminada'),
                    backgroundColor: Colors.indigo,
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: const Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final genresProvider = Provider.of<GenresProvider>(context);
    final actorsProvider = Provider.of<ActorsProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        elevation: 0,
        actions: [
          PopupMenuButton<Menu>(
            // Callback that sets the selected popup menu item.
            onSelected: (Menu item) {
              if (item.index == 0) {
                Navigator.pushNamed(
                  context,
                  'edit-movie',
                  arguments: movie,
                );
              }
              if (item.index == 1) {
                _delete(context, movie.id ?? 1);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem<Menu>(
                value: Menu.itemOne,
                child: Text('Editar'),
              ),
              const PopupMenuItem<Menu>(
                value: Menu.itemTwo,
                child: Text('Eliminar'),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.poster),
                    height: 180,
                  ),
                ),
                const SizedBox(width: 20),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.movie_creation_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(right: 13.0),
                              child: Text(
                                movie.name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.caption,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.language,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(movie.originalLanguage, style: textTheme.caption)
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            movie.release,
                            style: textTheme.caption,
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      const SizedBox(height: 5),
                      FutureBuilder(
                        initialData: const [],
                        future: genresProvider.getMovieGenres(movie.id ?? 1),
                        builder:
                            (context, AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.hasData) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: snapshot.data!
                                    .map(
                                      (genre) => Chip(
                                        label: Text('${genre.name}'),
                                        backgroundColor: Colors.indigo,
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: size.height - 200),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reparto:',
                      style: textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 5),
                    FutureBuilder(
                      future: actorsProvider.getMovieActors(movie.id ?? 1),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isEmpty) {
                            return Column(
                              children: [
                                Text(
                                  'Sin reparto',
                                  style: textTheme.bodyText2,
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          } else {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: snapshot.data!
                                    .map(
                                      (actor) => Row(
                                        children: [
                                          ActionChip(
                                            label: Text('${actor.name}'),
                                            labelStyle: const TextStyle(
                                                color: Colors.black),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                'actor-movies',
                                                arguments: actor,
                                              );
                                            },
                                            backgroundColor: Colors.grey[100],
                                            shape: const StadiumBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: Colors.indigo,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5)
                                        ],
                                      ),
                                    )
                                    .toList(),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                              ),
                            );
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    Text(
                      'Sinopsis:',
                      style: textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.overview,
                      style: textTheme.bodyText2,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () async {
          Navigator.pushNamed(
            context,
            'edit-movie',
            arguments: movie,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
