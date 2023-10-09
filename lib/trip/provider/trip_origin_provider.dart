import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

final originProvider =
    StateNotifierProvider<OriginNotifier, TripBaseModel?>((ref) {
  final repository = ref.watch(tripRepositoryProvider);

  final notifier = OriginNotifier(repository: repository);

  return notifier;
});

class OriginNotifier extends StateNotifier<TripBaseModel?> {
  final TripRepository repository;

  OriginNotifier({
    required this.repository,
  }) : super(null);

  Future<void> fetchOriginTrips() async {
    try {
      final data = await repository.getTagoOriginTrips();

      state = data;
    } catch (error) {
      state = TripErrorModel();
      print(error);
    }
  }
}
