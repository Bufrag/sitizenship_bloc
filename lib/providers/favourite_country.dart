import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/country_model.dart';

final favoriteCountriesProvider =
    StateNotifierProvider<FavoriteCountriesNotifire, List<Countries>>(
        (ref) => FavoriteCountriesNotifire());

class FavoriteCountriesNotifire extends StateNotifier<List<Countries>> {
  FavoriteCountriesNotifire() : super([]);

  void addToFavorites(Countries country) {
    state = [...state, country];
  }

  void removeFrotFavorites(Countries country) {
    state = state.where((c) => c != country).toList();
  }

  int? getIndexOfCountry(Countries country) {
    final index = state.indexWhere((c) => c == country);
    return index != -1 ? index : null;
  }
}
