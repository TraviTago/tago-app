import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/common/model/pagination_params.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

final tripProvider =
    StateNotifierProvider<TripStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(tripRepositoryProvider);

    final notifier = TripStateNotifier(repository: repository);
    return notifier;
  },
);

class TripStateNotifier extends StateNotifier<CursorPaginationBase> {
  final TripRepository repository;

  TripStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
    bool isPet = false,
    bool sameGender = false,
  }) async {
    try {
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.hasNext) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      PaginationParams paginationParams = PaginationParams(
          limit: fetchCount,
          isPet: isPet,
          sameGender: sameGender,
          cursorId: 0,
          cursorDate: DataUtils.formatDateTimeToParams(DateTime.now()));

      //fetchMore
      if (fetchMore) {
        final pState = state as CursorPagination;
        state = CursorPaginationFetchingMore(
          hasNext: pState.hasNext,
          contents: pState.contents,
        );
        paginationParams = paginationParams.copyWith(
          cursorId: pState.contents.last.tripId,
          cursorDate:
              DataUtils.formatDateTimeToParams(pState.contents.last.dateTime),
        );
      }
      //데이터를 처음부터 가져오는 상황
      else {
        //만약 데이터가 있는 상황이라면
        //기존 데이터를 보존한채로 Fetch를 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          state = CursorPaginationRefetching(
            hasNext: pState.hasNext,
            contents: pState.contents,
          );
        }
        //나머지 상황
        else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        state = resp.copyWith(
          contents: [
            ...pState.contents,
            ...resp.contents,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e) {
      print(e);
      state = CursorPaginationError(
        message: "데이터를 가져오지 못했습니다.",
      );
    }
  }
}
