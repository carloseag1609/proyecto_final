import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/filmstudio_model.dart';
import 'package:proyecto_final/models/movie_model.dart';
import 'package:proyecto_final/providers/film_studios_provider.dart';
import 'package:proyecto_final/providers/movies_provider.dart';

import '../widgets/custom_bottom_navbar.dart';
import '../widgets/fab.dart';

class AddFilmStudiosView extends StatefulWidget {
  AddFilmStudiosView({Key? key}) : super(key: key);

  @override
  State<AddFilmStudiosView> createState() => _AddFilmStudiosViewState();
}

class _AddFilmStudiosViewState extends State<AddFilmStudiosView> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formValues = {
    'name': 'Warner Bros',
    'logo':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Warner_Bros._%282019%29_logo.svg/1200px-Warner_Bros._%282019%29_logo.svg.png',
  };

  @override
  Widget build(BuildContext context) {
    final filmStudiosProvider = Provider.of<FilmStudiosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar una nueva productora'),
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
                  initialValue: formValues['name'],
                  decoration: const InputDecoration(
                    hintText: 'Nombre de la productora',
                    labelText: 'Nombre',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => formValues['name'] = value,
                ),
                TextFormField(
                  initialValue: formValues['logo'],
                  decoration: const InputDecoration(
                    hintText: 'Logo de la productora',
                    labelText: 'Logo',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => formValues['logo'] = value,
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
                      FilmStudio newFS = FilmStudio.fromJson(formValues);
                      await filmStudiosProvider.insertFilmStudios(newFS);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Productora guardada'),
                          backgroundColor: Colors.indigo,
                          duration: Duration(seconds: 1),
                        ),
                      );
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
