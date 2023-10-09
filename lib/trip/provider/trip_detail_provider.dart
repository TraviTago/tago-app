import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tago_app/common/storage/secure_storage.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

final tripDetailProvider =
    StateNotifierProvider<TripDetailNotifier, TripDetailBaseModel?>((ref) {
  final repository = ref.watch(tripRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  final notifier = TripDetailNotifier(repository: repository, storage: storage);

  return notifier;
});

class TripDetailNotifier extends StateNotifier<TripDetailBaseModel?> {
  final TripRepository repository;
  final FlutterSecureStorage storage;
  TripDetailNotifier({
    required this.repository,
    required this.storage,
  }) : super(null);

  Future<void> fetchDetailTrip(int tripId, String userType) async {
    try {
      TripDetailBaseModel data;

      if (userType == "USER") {
        data = await repository.getDetailTrip(tripId: tripId);
      } else {
        data = await repository.getDetailTripDriver(tripId: tripId);
      }

      state = data;
    } catch (error) {
      state = TripDetailErrorModel();
    }
  }
}
