import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/providers/actors_provider.dart';
import 'package:proyecto_final/widgets/fab.dart';

import '../widgets/custom_bottom_navbar.dart';

class ActorsListView extends StatelessWidget {
  ActorsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final actorsProvider = Provider.of<ActorsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actores'),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: FutureBuilder(
          initialData: const [],
          future: actorsProvider.getAllActors(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (DismissDirection direction) {
                      print(snapshot.data[index].id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Actor eliminado'),
                          backgroundColor: Colors.indigo,
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        'actor-movies',
                        arguments: snapshot.data[index],
                      ),
                      child: ListTile(
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(snapshot.data[index].alias),
                        leading: const Icon(
                          Icons.person,
                          color: Colors.indigo,
                        ),
                        trailing: const Icon(
                          Icons.arrow_right,
                          color: Colors.indigo,
                        ),
                      ),
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
        Navigator.pushNamed(context, 'add-actor');
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
