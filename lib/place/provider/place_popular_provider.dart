import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/place/model/place_model.dart';
import 'package:tago_app/place/repository/place_repository.dart';

final placePopularProvider =
    StateNotifierProvider<PlacePopularNotifier, List<PlaceModel>?>((ref) {
  final repository = ref.watch(placeRepositoryProvider);

  final notifier = PlacePopularNotifier(repository: repository);

  return notifier;
});

class PlacePopularNotifier extends StateNotifier<List<PlaceModel>?> {
  final PlaceRepository repository;

  PlacePopularNotifier({
    required this.repository,
  }) : super(null);

  Future<void> fetchPopularPlaces() async {
    try {
      if (state != null) {
        return;
      }
      final data = await repository.getPopularPlaces();

      state = data;
    } catch (error) {
      print(error);
    }
  }
}
