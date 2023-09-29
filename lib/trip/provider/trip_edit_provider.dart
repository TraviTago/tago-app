import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/course/provider/course_provider.dart';
import 'package:tago_app/place/model/place_detail_model.dart';
import 'package:tago_app/place/model/place_model.dart';
import 'package:tago_app/place/model/place_trip_model.dart';
import 'package:tago_app/place/repository/place_repository.dart';
import 'package:tago_app/trip/model/trip_edit_model.dart';

final tripEditProvider =
    ChangeNotifierProvider.family<TripEditProvider, TripEditModel>(
  (ref, initialModel) => TripEditProvider(ref, initialModel),
);

class TripEditProvider with ChangeNotifier {
  final Ref ref;
  TripEditModel _originalModel;
  TripEditModel _tempModel;

  TripEditProvider(this.ref, TripEditModel model)
      : _originalModel = model,
        _tempModel = model.copyWith();

  TripEditModel get model => _tempModel;

  void updateTempModel(TripEditModel model) {
    _tempModel = model;
    notifyListeners();
  }

  void commitChanges() {
    _originalModel = _tempModel;
    // Commit시 Course state 업데이트
    ref.read(courseProvider.notifier).updateCourse(editModel: _originalModel);
    notifyListeners();
  }

  void removePlaceAt(int index) {
    if (_tempModel.places.length <= 1) {
      // 표시되는 경고 메시지는 아래의 코드로 구현될 것입니다.
      return;
    }

    List<PlaceTripModel> updatedPlaces = List.from(_tempModel.places);
    updatedPlaces.removeAt(index);
    _tempModel = _tempModel.copyWith(places: updatedPlaces);
    notifyListeners();
  }

  void addPlaces(List<PlaceModel> places, BuildContext context) async {
    List<PlaceTripModel> updatedPlaces = List.from(_tempModel.places);

    for (PlaceModel place in places) {
      // Check for duplicates
      if (updatedPlaces.any((placeTrip) => placeTrip.id == place.id)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('중복된 여행지입니다')),
        );
        break;
      }

      PlaceDetailModel detailModel = await ref
          .read(placeRepositoryProvider)
          .getDetailPlace(placeId: place.id);

      PlaceTripModel newTrip = PlaceTripModel(
          mapX: detailModel.mapX,
          mapY: detailModel.mapY,
          id: detailModel.id,
          imageUrl: detailModel.imageUrl,
          overview: detailModel.overview,
          title: detailModel.title);

      updatedPlaces.add(newTrip);
    }

    _tempModel = _tempModel.copyWith(places: updatedPlaces);
    notifyListeners();
  }
}
