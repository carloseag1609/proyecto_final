import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/movies_provider.dart';

import 'package:proyecto_final/providers/ui_provider.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: uiProvider.selectedMenuOpt,
      onTap: (int index) {
        uiProvider.selectedMenuOpt = index;
        switch (index) {
          case 0:
            moviesProvider.loadMovies();
            Navigator.pushNamed(context, 'movies');
            break;
          case 1:
            Navigator.pushNamed(context, 'film-studios');
            break;
          case 2:
            Navigator.pushNamed(context, 'actors');
            break;
          default:
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_creation_outlined),
          label: 'Películas',
          activeIcon: Icon(Icons.movie_creation),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_movies_outlined),
          label: 'Productoras',
          activeIcon: Icon(Icons.local_movies_rounded),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined),
          label: 'Actores',
          activeIcon: Icon(Icons.people_alt_rounded),
        ),
      ],
    );
  }
}
