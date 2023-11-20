import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const PlacesList(),
    );
  }
}
