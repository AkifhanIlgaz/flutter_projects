import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesProvider extends StateNotifier<List<Place>> {
  FavoritePlacesProvider() : super(<Place>[]);

  void addFavoritePlace(String title) {
    state = [...state, Place(title: title)];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesProvider, List<Place>>(
        (ref) => FavoritePlacesProvider());
