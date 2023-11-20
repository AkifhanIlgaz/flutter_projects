import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);

    favoritePlaces.forEach(
      (element) {
        print("elemt title");
        print(element.title);
      },
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const AddPlaceScreen();
                  },
                ));
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ],
        title: Text(
          "Your Places",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.black,
      ),
      body: favoritePlaces.isEmpty
          ? Center(
              child: Text("No places added yet.",
                  style: Theme.of(context).textTheme.titleSmall),
            )
          : ListView.builder(
              itemCount: favoritePlaces.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    favoritePlaces[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              },
            ),
    );
  }
}
