import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/course/provider/course_provider.dart';
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
}
