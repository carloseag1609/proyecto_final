import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proyecto_final/providers/ui_provider.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: uiProvider.selectedMenuOpt,
      onTap: (int index) => uiProvider.selectedMenuOpt = index,
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
      ],
    );
  }
}
