import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/common/model/pagination_params.dart';
import 'package:tago_app/place/repository/place_repository.dart';
import 'package:tago_app/place/model/place_summary_model.dart';

final placeProvider =
    StateNotifierProvider<PlaceStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(placeRepositoryProvider);

    final notifier = PlaceStateNotifier(repository: repository);
    notifier.fetchPlaces();

    return notifier;
  },
);

class PlaceStateNotifier extends StateNotifier<CursorPaginationBase> {
  final PlaceRepository repository;

  List<PlaceSummaryModel> _originalPlaces = [];

  PlaceStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading());

  Future<void> fetchPlaces() async {
    try {
      final places = await repository.getPlaces(
        paginationParams: const PaginationParams(
          cursorId: 0,
          limit: 300,
        ),
      );

      // 원본 목록 저장
      _originalPlaces = List.from(places.contents);

      state = CursorPagination(contents: places.contents, hasNext: false);
    } catch (e) {
      state = CursorPaginationError(message: e.toString());
    }
  }

  void filterPlaces(String query) {
    // _originalPlaces를 바탕으로 필터링 진행
    final filteredPlaces = _originalPlaces
        .where(
          (place) => place.title.contains(query),
        )
        .toList();

    state = CursorPagination(contents: filteredPlaces, hasNext: false);
  }

  void resetAndFetchPlaces() {
    _originalPlaces = [];
    fetchPlaces();
  }
}
