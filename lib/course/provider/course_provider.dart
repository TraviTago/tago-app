import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/course/model/course_reponse_model.dart';
import 'package:tago_app/course/repository/course_repository.dart';
import 'package:tago_app/trip/model/trip_edit_model.dart';

final courseProvider =
    StateNotifierProvider<CourseStateNotifier, CourseResponseModel?>(
  (ref) {
    final repository = ref.watch(courseRepositoryProvider);

    return CourseStateNotifier(
      repository: repository,
    );
  },
);

class CourseStateNotifier extends StateNotifier<CourseResponseModel?> {
  final CourseRepository repository;

  CourseStateNotifier({
    required this.repository,
  }) : super(null);

  Future<CourseResponseModel> recommendCourse({
    required int? placeId,
    required List<String> tags,
  }) async {
    try {
      final resp = await repository.recommendCourse(
        placeId: placeId,
        tags: tags,
      );

      state = resp;

      return resp;
    } catch (e) {
      // 이 경우에는 state를 변경하지 않고, 예외를 그대로 던진다.
      rethrow;
    }
  }

  void updateCourse({
    required TripEditModel editModel,
  }) {
    state = CourseResponseModel(
        imgUrl: editModel.places[0].imageUrl,
        totalTime: state!.totalTime,
        places: editModel.places);
  }
}
