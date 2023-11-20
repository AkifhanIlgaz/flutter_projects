import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add new place",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text(
                    "Title",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.titleSmall,
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return "Must be valid title";
                  }
                  return null;
                },
                onChanged: (newValue) {
                  _enteredTitle = newValue;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton.icon(
                  style: const ButtonStyle(
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    ref
                        .watch(favoritePlacesProvider.notifier)
                        .addFavoritePlace(Place(title: _enteredTitle));

                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add place"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
