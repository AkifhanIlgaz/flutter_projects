import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesProvider extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesProvider() : super(<FavoritePlace>[]);

  void addFavoritePlace(FavoritePlace place) {
    state = [...state, place];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesProvider, List<FavoritePlace>>(
        (ref) => FavoritePlacesProvider());
