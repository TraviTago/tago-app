import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

final recommendProvider =
    StateNotifierProvider<RecommendNotifier, TripModel?>((ref) {
  final repository = ref.watch(tripRepositoryProvider);

  final notifier = RecommendNotifier(repository: repository);

  return notifier;
});

class RecommendNotifier extends StateNotifier<TripModel?> {
  final TripRepository repository;

  RecommendNotifier({
    required this.repository,
  }) : super(null);

  Future<void> fetchRecommendTrip() async {
    try {
      final data = await repository.getRecommendTrip();

      // 만약 현재 state가 null이 아니면서, 현재 state의 tripId와 새롭게 불러온 tripId가 다르면 state를 갱신
      if (state == null || (state != null && state!.tripId != data.tripId)) {
        state = data;
      }
    } catch (error) {
      print(error);
    }
  }
}
