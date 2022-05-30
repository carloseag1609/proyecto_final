import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/actor_model.dart';
import 'package:proyecto_final/models/movie_model.dart';
import 'package:proyecto_final/providers/actors_provider.dart';
import 'package:proyecto_final/providers/film_studios_provider.dart';
import 'package:proyecto_final/providers/movies_provider.dart';

import '../widgets/custom_bottom_navbar.dart';

class AddMovieView extends StatefulWidget {
  AddMovieView({Key? key}) : super(key: key);

  @override
  State<AddMovieView> createState() => _AddMovieViewState();
}

class _AddMovieViewState extends State<AddMovieView> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final Map<String, dynamic> formValues = {
    'title': 'Doctor Strange: Hechicero supremo ',
    'originalLanguage': 'Ingles',
    'poster':
        'https://image.tmdb.org/t/p/w600_and_h900_bestv2/gUNRlH66yNDH3NQblYMIwgZXJ2u.jpg',
    'overview':
        'Viaja a lo desconocido con el Doctor Strange, quien, con la ayuda de tanto antiguos como nuevos aliados místicos, recorre las complejas y peligrosas realidades alternativas del multiverso para enfrentarse a un nuevo y misterioso adversario.',
    'release': '2022-03-01',
    'filmStudioId': 1,
  };
  List<int> actors = [];
  int tmpActorId = 0;

  void _showModal(BuildContext context) {
    final actorsProvider = Provider.of<ActorsProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return FutureBuilder(
          future: actorsProvider.getAllActors(),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              tmpActorId = snapshot.data![0].id;
              return AlertDialog(
                title: const Text('Agregar actor'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Selecciona el actor'),
                    Form(
                      key: _formKey2,
                      child: DropdownButtonFormField<String>(
                        value: '1',
                        items: snapshot.data!
                            .map(
                              (actor) => DropdownMenuItem(
                                value: '${actor.id}',
                                child: Text('${actor.name}'),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          tmpActorId = int.parse(value ?? '1');
                          print('Value $tmpActorId');
                        },
                      ),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      bool existe = true;
                      if (!actors.contains(tmpActorId)) {
                        actors.add(tmpActorId);
                        existe = false;
                      }
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(existe
                              ? "El actor ya existe en el reparto"
                              : "Actor agregado"),
                          backgroundColor:
                              existe ? Colors.amber : Colors.indigo,
                          duration: const Duration(seconds: 1),
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
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filmStudiosProvider = Provider.of<FilmStudiosProvider>(context);
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar una nueva película'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _showModal(context),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text('Agregar actor'),
                    ),
                  ),
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
                      final bool filmStudioTaken = await moviesProvider
                          .filmStudioInUse(formValues['filmStudioId']);
                      if (filmStudioTaken) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'La productora ya cuenta con una película',
                            ),
                            backgroundColor: Colors.amberAccent,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        Movie newMovie = Movie.fromJson(formValues);
                        final movieId =
                            await moviesProvider.insertMovie(newMovie);
                        actors.isNotEmpty
                            ? await moviesProvider.addActors(actors, movieId)
                            : null;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Película guardada'),
                            backgroundColor: Colors.indigo,
                            duration: Duration(seconds: 1),
                          ),
                        );
                        Navigator.pop(context);
                      }
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
