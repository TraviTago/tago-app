import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

final recommendProvider =
    StateNotifierProvider<RecommendNotifier, TripBaseModel?>((ref) {
  final repository = ref.watch(tripRepositoryProvider);

  final notifier = RecommendNotifier(repository: repository);

  return notifier;
});

class RecommendNotifier extends StateNotifier<TripBaseModel?> {
  final TripRepository repository;

  RecommendNotifier({
    required this.repository,
  }) : super(null);

  Future<void> fetchRecommendTrip() async {
    try {
      final data = await repository.getRecommendTrip();

      state = data;
    } catch (error) {
      state = TripErrorModel();
    }
  }
}
