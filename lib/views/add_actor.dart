import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/actor_model.dart';
import 'package:proyecto_final/providers/actors_provider.dart';

import '../widgets/custom_bottom_navbar.dart';
import '../widgets/fab.dart';

class AddActorView extends StatefulWidget {
  AddActorView({Key? key}) : super(key: key);

  @override
  State<AddActorView> createState() => _AddActorViewState();
}

class _AddActorViewState extends State<AddActorView> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formValues = {
    'name': 'Benedict Wong',
    'alias': 'Wong',
  };

  @override
  Widget build(BuildContext context) {
    final actorsProvider = Provider.of<ActorsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar un nuevo actor'),
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
                    hintText: 'Nombre del actor',
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
                  initialValue: formValues['alias'],
                  decoration: const InputDecoration(
                    hintText: 'Alias del actor',
                    labelText: 'Alias',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => formValues['alias'] = value,
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
                      Actor newActor = Actor.fromJson(formValues);
                      await actorsProvider.insertFilmStudios(newActor);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Actor guardado'),
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
