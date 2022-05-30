import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/film_studios_provider.dart';
import 'package:proyecto_final/widgets/fab.dart';

import '../widgets/custom_bottom_navbar.dart';

class FilmStudioListView extends StatelessWidget {
  const FilmStudioListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filmStudiosProvider = Provider.of<FilmStudiosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productoras'),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: FutureBuilder(
          initialData: const [],
          future: filmStudiosProvider.getAllFilmStudios(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(snapshot.data[index].logo),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 80,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_right,
                      color: Colors.indigo,
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
      floatingActionButton: Fab(onPressed: () {
        Navigator.pushNamed(context, 'add-film-studios');
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
