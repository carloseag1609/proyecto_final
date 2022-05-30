import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/ui_provider.dart';
import 'package:proyecto_final/views/film_studio_list_view.dart';
import 'package:proyecto_final/views/movies_list_view.dart';
import 'package:proyecto_final/widgets/custom_bottom_navbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomBottomNavbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add');
        },
        child: const Icon(
          Icons.add,
        ),
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final index = uiProvider.selectedMenuOpt;
    switch (index) {
      case 0:
        return MoviesListView();
      case 1:
        return FilmStudioListView();
      default:
        return MoviesListView();
    }
  }
}
