import 'dart:io';

import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesProvider extends StateNotifier<List<Place>> {
  FavoritePlacesProvider() : super(<Place>[]);

  void addFavoritePlace(String title, File image) {
    state = [Place(title: title, image: image), ...state];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesProvider, List<Place>>(
        (ref) => FavoritePlacesProvider());
