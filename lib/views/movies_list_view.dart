import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/actor_model.dart';
import 'package:proyecto_final/models/filmstudio_model.dart';
import 'package:proyecto_final/models/genre_model.dart';
import 'package:proyecto_final/models/movie_model.dart';
import 'package:proyecto_final/providers/db_provider.dart';
import 'package:proyecto_final/providers/movies_provider.dart';
import 'package:proyecto_final/widgets/fab.dart';

import '../widgets/custom_bottom_navbar.dart';

class MoviesListView extends StatelessWidget {
  MoviesListView({Key? key}) : super(key: key);

  // void getAllMovies() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.rawQuery('''
  //     SELECT * FROM movies inner join filmstudios f on f.id = movies.filmStudioId;
  //   ''');
  //   final dbMovies = res.map<Movie>((movie) => Movie.fromJson(movie)).toList();
  // }

  // void getAllActors() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.query('Actors');
  //   final dbActors = res.map<Actor>((actor) => Actor.fromJson(actor)).toList();
  //   print(dbActors.length);
  // }

  // void getAllGenres() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.query('Genres');
  //   final dbGenres = res.map<Genre>((genre) => Genre.fromJson(genre)).toList();
  //   print(dbGenres.length);
  // }

  // void getAllFilmStudios() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.query('Filmstudios');
  //   final dbFs = res.map<FilmStudio>((fs) => FilmStudio.fromJson(fs)).toList();
  //   print(dbFs.length);
  // }

  // void addMovie() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.rawInsert('''
  //     INSERT INTO Movies(title, originalLanguage, poster, overview, release, filmStudioId) VALUES ("Hotel Transylvania: Transformanía", "Inglés", "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xNF8AxJc966FWk4SYqXxGHaZLHZ.jpg", "Drac y la pandilla vuelven, como nunca los habías visto antes en Hotel Transilvania: Transformanía. Volveremos a encontrarnos con nuestros monstruos favoritos en una aventura completamente nueva en la que Drac se enfrentará a una de las situaciones más aterradoras vividas hasta el momento. Cuando el misterioso invento de Van Helsing, el 'Rayo Monstrificador', se vuelve totalmente fuera de control, Drac y sus monstruosos amigos se transforman en humanos, ¡y Johnny se convierte en un monstruo!", "25-02-2022", 1);
  //   ''');
  //   print(res);
  // }

  // void addActor() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!
  //       .insert('Actors', Actor(name: "Actor 1", alias: "El Actor 1").toJson());
  //   print(res);
  // }

  // void addGenre() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.insert('Genres', Genre(name: "Acción").toJson());
  //   print(res);
  // }

  // void addFilmStudio() async {
  //   final db = await DBProvider.db.database;
  //   final res = await db!.insert(
  //       'Filmstudios',
  //       FilmStudio(
  //         name: "Sony Pictures",
  //         logo:
  //             'https://yt3.ggpht.com/J6guHiXR90gNdoXKaI8wcC799HCTggrGmrtQWBSsW-D-7gZTlM3mQ9jBr1fS7lL1c5eP9E_r=s900-c-k-c0x00ffffff-no-rj',
  //       ).toJson());
  //   print(res);
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final f = DateFormat('dd-MM-yyyy');
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas'),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: FutureBuilder(
            initialData: const [],
            future: moviesProvider.loadMovies(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemExtent: 180,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (DismissDirection direction) {
                        moviesProvider.deleteMovie(snapshot.data[index].id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Película eliminada'),
                            backgroundColor: Colors.indigo,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          'details',
                          arguments: snapshot.data[index],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 180,
                          width: size.width,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage(
                                  placeholder:
                                      const AssetImage('assets/no-image.jpg'),
                                  image:
                                      NetworkImage(snapshot.data[index].poster),
                                  fit: BoxFit.cover,
                                  width: size.width * 0.25,
                                  height: 180,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: size.width - 140,
                                    maxHeight: 180,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[index].title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.date_range,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            snapshot.data[index].release,
                                            style: textTheme.caption,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 250),
                                        child: Text(
                                          snapshot.data[index].overview,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
      floatingActionButton: Fab(
        onPressed: () async {
          // final db = await DBProvider.db.database;
          // final res =
          //     await db!.insert('Genres', Genre(name: "Acción").toJson());
          // print(res);
          Navigator.pushNamed(context, 'add-movie');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}





// Container(
//         margin: const EdgeInsets.only(top: 10),
//         child: Column(
//           children: [
//             ElevatedButton(
//               child: const Text('Get movies'),
//               onPressed: () => getAllMovies(),
//             ),
//             ElevatedButton(
//               child: const Text('Add movie'),
//               onPressed: () => addMovie(),
//             ),
//             ElevatedButton(
//               child: const Text('Get film studios'),
//               onPressed: () => getAllFilmStudios(),
//             ),
//             ElevatedButton(
//               child: const Text('Add film studio'),
//               onPressed: () => addFilmStudio(),
//             ),
//             ElevatedButton(
//               child: const Text('Get genres'),
//               onPressed: () => getAllGenres(),
//             ),
//             ElevatedButton(
//               child: const Text('Add genre'),
//               onPressed: () => addGenre(),
//             ),
//             ElevatedButton(
//               child: const Text('Get actors'),
//               onPressed: () => getAllActors(),
//             ),
//             ElevatedButton(
//               child: const Text('Add actor'),
//               onPressed: () => addActor(),
//             ),
//           ],
//         ),
//       ),