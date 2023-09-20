import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/place/model/place_model.dart';
import 'package:tago_app/place/repository/place_repository.dart';

final placeRecommendProvider =
    StateNotifierProvider<PlaceRecommendNotifier, PlaceListModel?>((ref) {
  final repository = ref.watch(placeRepositoryProvider);

  final notifier = PlaceRecommendNotifier(repository: repository);

  return notifier;
});

class PlaceRecommendNotifier extends StateNotifier<PlaceListModel?> {
  final PlaceRepository repository;

  PlaceRecommendNotifier({
    required this.repository,
  }) : super(null);

  Future<void> fetchRecommendPlaces(Function(String)? onImageChange) async {
    try {
      if (state != null) {
        onImageChange?.call(state!.places[0].imageUrl);

        return;
      }
      final data = await repository.getRecommendPlaces();

      state = data;
      onImageChange?.call(data.places[0].imageUrl);
    } catch (error) {
      print(error);
    }
  }
}
