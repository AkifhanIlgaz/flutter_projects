import 'dart:io';

import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null) {
      return;
    }

    ref
        .read(favoritePlacesProvider.notifier)
        .addFavoritePlace(enteredTitle, _selectedImage!);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     label: Text(
            //       "Title",
            //       style: Theme.of(context).textTheme.titleSmall,
            //     ),
            //   ),
            //   keyboardType: TextInputType.text,
            //   style: Theme.of(context).textTheme.titleSmall,
            //   validator: (value) {
            //     if (value == null || value.isEmpty || value.trim().isEmpty) {
            //       return "Must be valid title";
            //     }
            //     return null;
            //   },
            //   onChanged: (newValue) {
            //     _enteredTitle = newValue;
            //   },
            // ),
            const SizedBox(height: 10),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 10),
            const LocationInput(),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: const ButtonStyle(
                alignment: Alignment.center,
              ),
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text("Add place"),
            ),
          ],
        ),
      ),
    );
  }
}
