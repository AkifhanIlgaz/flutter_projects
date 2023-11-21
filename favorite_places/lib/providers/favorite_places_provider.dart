import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesProvider extends StateNotifier<List<Place>> {
  FavoritePlacesProvider() : super(<Place>[]);

  void addFavoritePlace(String title, File image, PlaceLocation location) {
    state = [Place(title: title, image: image, location: location), ...state];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesProvider, List<Place>>(
        (ref) => FavoritePlacesProvider());
