import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_final/models/actor_model.dart';
import 'package:proyecto_final/providers/actors_provider.dart';
import 'package:proyecto_final/widgets/custom_bottom_navbar.dart';

class ActorMoviesView extends StatelessWidget {
  const ActorMoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actorsProvider = Provider.of<ActorsProvider>(context);
    final Actor actor = ModalRoute.of(context)!.settings.arguments as Actor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas de ${actor.name}'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: FutureBuilder(
          future: actorsProvider.getActorMovies(actor.id ?? 1),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(snapshot.data![index].title),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(snapshot.data![index].poster),
                      fit: BoxFit.cover,
                      width: 50,
                      height: 80,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_right,
                    color: Colors.indigo,
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    'details',
                    arguments: snapshot.data![index],
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}
