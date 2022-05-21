import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_final/models/movie_model.dart';

class MoviesListView extends StatelessWidget {
  MoviesListView({Key? key}) : super(key: key);

  final List<Movie> movies = [
    Movie(
      id: 1,
      title: 'Hotel Transylvania: Transformanía ',
      originalLanguage: 'Inglés',
      poster:
          'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xNF8AxJc966FWk4SYqXxGHaZLHZ.jpg',
      actors: [
        'Selena Gomez',
        'Andy Samberg',
        'Kathryn Hahn',
        'Jim Gaffigan',
        'Steve Buscemi'
      ],
      releaseDate: DateTime.utc(2022, 02, 25),
      genres: ['Animación', 'Familia', 'Fantasía', 'Comedia', 'Aventura'],
      duration: '1h 27m',
    ),
    Movie(
      id: 2,
      title: 'Hotel Transylvania: Transformanía ',
      originalLanguage: 'Inglés',
      poster:
          'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xNF8AxJc966FWk4SYqXxGHaZLHZ.jpg',
      actors: [
        'Selena Gomez',
        'Andy Samberg',
        'Kathryn Hahn',
        'Jim Gaffigan',
        'Steve Buscemi'
      ],
      releaseDate: DateTime.utc(2022, 02, 25),
      genres: ['Animación', 'Familia', 'Fantasía', 'Comedia', 'Aventura'],
      duration: '1h 27m',
    ),
    Movie(
      id: 3,
      title: 'Hotel Transylvania: Transformanía ',
      originalLanguage: 'Inglés',
      poster:
          'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xNF8AxJc966FWk4SYqXxGHaZLHZ.jpg',
      actors: [
        'Selena Gomez',
        'Andy Samberg',
        'Kathryn Hahn',
        'Jim Gaffigan',
        'Steve Buscemi'
      ],
      releaseDate: DateTime.utc(2022, 02, 25),
      genres: ['Animación', 'Familia', 'Fantasía', 'Comedia', 'Aventura'],
      duration: '1h 27m',
    ),
    Movie(
      id: 4,
      title: 'Hotel Transylvania: Transformanía ',
      originalLanguage: 'Inglés',
      poster:
          'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xNF8AxJc966FWk4SYqXxGHaZLHZ.jpg',
      actors: [
        'Selena Gomez',
        'Andy Samberg',
        'Kathryn Hahn',
        'Jim Gaffigan',
        'Steve Buscemi'
      ],
      releaseDate: DateTime.utc(2022, 02, 25),
      genres: ['Animación', 'Familia', 'Fantasía', 'Comedia', 'Aventura'],
      duration: '1h 27m',
    ),
    Movie(
      id: 5,
      title: 'Hotel Transylvania: Transformanía ',
      originalLanguage: 'Inglés',
      poster:
          'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xNF8AxJc966FWk4SYqXxGHaZLHZ.jpg',
      actors: [
        'Selena Gomez',
        'Andy Samberg',
        'Kathryn Hahn',
        'Jim Gaffigan',
        'Steve Buscemi'
      ],
      releaseDate: DateTime.utc(2022, 02, 25),
      genres: ['Animación', 'Familia', 'Fantasía', 'Comedia', 'Aventura'],
      duration: '1h 27m',
    ),
    Movie(
      id: 6,
      title: 'Hotel Transylvania: Transformanía ',
      originalLanguage: 'Inglés',
      poster:
          'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/xNF8AxJc966FWk4SYqXxGHaZLHZ.jpg',
      actors: [
        'Selena Gomez',
        'Andy Samberg',
        'Kathryn Hahn',
        'Jim Gaffigan',
        'Steve Buscemi'
      ],
      releaseDate: DateTime.utc(2022, 02, 25),
      genres: ['Animación', 'Familia', 'Fantasía', 'Comedia', 'Aventura'],
      duration: '1h 27m',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final f = DateFormat('dd-MM-yyyy');
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              print(movies[index].id);
            },
            child: ListTile(
              onTap: () {},
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movies[index].poster),
                  fit: BoxFit.cover,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_right_rounded,
                color: Colors.indigo,
              ),
              title: Text(movies[index].title),
              subtitle: Text(
                  f.format(movies[index].releaseDate).replaceAll('-', '/')),
            ),
          );
        },
      ),
    );
  }
}
// SingleChildScrollView(
//       child: Container(
//         width: double.infinity,
//         height: size.height * 0.5,
//         margin: EdgeInsets.only(top: 50),
//         child: Swiper(
//           itemCount: movies.length,
//           layout: SwiperLayout.STACK,
//           itemWidth: size.width * 0.7,
//           itemHeight: size.height * 0.9,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onTap: () => Navigator.pushNamed(
//                 context,
//                 'details',
//                 arguments: 'movie-instance',
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: FadeInImage(
//                   placeholder: const AssetImage('assets/no-image.jpg'),
//                   image: NetworkImage(movies[index].poster),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
