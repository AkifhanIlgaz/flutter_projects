import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritePlaces = ref.watch(favoritePlacesProvider);

    return favoritePlaces.isEmpty
        ? Center(
            child: Text(
              "No places added yet.",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          )
        : ListView.builder(
            itemCount: favoritePlaces.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  favoritePlaces[index].title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                leading: CircleAvatar(
                  radius: 26,
                  backgroundImage: FileImage(favoritePlaces[index].image),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlaceDetailsScreen(place: favoritePlaces[index]);
                      },
                    ),
                  );
                },
              );
            },
          );
  }
}
