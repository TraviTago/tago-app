import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

final tripProvider = StateNotifierProvider<TripStateNotifier, List<TripModel>>(
  (ref) {
    final repository = ref.watch(tripRepositoryProvider);

    final notifier = TripStateNotifier(repository: repository);
    return notifier;
  },
);

class TripStateNotifier extends StateNotifier<List<TripModel>> {
  final TripRepository repository;

  TripStateNotifier({
    required this.repository,
  }) : super([]) {
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();
    state = resp.trips;
  }
}
