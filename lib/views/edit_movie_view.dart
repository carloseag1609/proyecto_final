import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/movie_model.dart';
import 'package:proyecto_final/providers/film_studios_provider.dart';
import 'package:proyecto_final/providers/movies_provider.dart';

import '../widgets/custom_bottom_navbar.dart';
import '../widgets/fab.dart';

class EditMovieView extends StatefulWidget {
  EditMovieView({Key? key}) : super(key: key);

  @override
  State<EditMovieView> createState() => _EditMovieViewState();
}

class _EditMovieViewState extends State<EditMovieView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final filmStudiosProvider = Provider.of<FilmStudiosProvider>(context);
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final Map<String, dynamic> formValues = {
      'id': movie.id,
      'title': movie.title,
      'originalLanguage': movie.originalLanguage,
      'poster': movie.poster,
      'overview': movie.overview,
      'release': movie.release,
      'filmStudioId': movie.filmStudioId,
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar película'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: formValues['title'],
                  decoration: const InputDecoration(
                    hintText: 'El título de la película',
                    labelText: 'Título',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => formValues['title'] = value,
                ),
                TextFormField(
                  initialValue: formValues['originalLanguage'],
                  decoration: const InputDecoration(
                    hintText: 'El idioma original de la película',
                    labelText: 'Idioma',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => formValues['originalLanguage'] = value,
                ),
                TextFormField(
                  initialValue: formValues['poster'],
                  decoration: const InputDecoration(
                    hintText: 'Dirección URL del póster de la película',
                    labelText: 'Póster',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => formValues['poster'] = value,
                ),
                TextFormField(
                  initialValue: formValues['release'],
                  decoration: const InputDecoration(
                    hintText: 'Fecha de estreno de la película',
                    labelText: 'Fecha de lanzamiento',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => formValues['release'] = value,
                ),
                TextFormField(
                  initialValue: formValues['overview'],
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Sinopsis de la película',
                    labelText: 'Sinopsis',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => formValues['overview'] = value,
                ),
                FutureBuilder(
                  future: filmStudiosProvider.getAllFilmStudios(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonFormField<String>(
                        value: '1',
                        items: snapshot.data!
                            .map(
                              (filmStudio) => DropdownMenuItem(
                                value: '${filmStudio.id}',
                                child: Text('${filmStudio.name}'),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => formValues['filmStudioId'] =
                            int.parse(value ?? '1'),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Guardando...'),
                          backgroundColor: Colors.indigo,
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Movie editMovie = Movie.fromJson(formValues);
                      await moviesProvider.editMovie(editMovie);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Película actualizada'),
                          backgroundColor: Colors.indigo,
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text('Guardar'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}
