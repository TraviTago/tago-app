import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/course/model/course_detail_model.dart';

class CourseDetailMapScreen extends StatelessWidget {
  final CourseDetailModel detailModel;

  const CourseDetailMapScreen({
    Key? key,
    required this.detailModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> loadHtmlAsset() async {
      return await rootBundle.loadString('asset/script/custom_map_script.js');
    }

    final loadedMarkerImages = Future.wait(markerImages);

    return FutureBuilder<List<dynamic>>(
      future: Future.wait([loadedMarkerImages, loadHtmlAsset()]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        String baseHtmlScript = snapshot.data![1];
        final customScript = '''
          $baseHtmlScript
          
          ${detailModel.places.asMap().entries.map((entry) {
          final index = entry.key;
          final place = entry.value;
          final imageSrc = snapshot.data![0][index];
          return '''addCustomMarkerAndOverlay(new kakao.maps.LatLng(${place.mapy}, ${place.mapx}), "${place.title}", "$imageSrc");''';
        }).join()}

        ''';

        return DefaultLayout(
          child: Stack(
            children: [
              Flexible(
                child: KakaoMapView(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  kakaoMapKey: "91fadb9b0a4afdc90a589e16612d6a10",
                  lat: detailModel.places[0].mapy,
                  lng: detailModel.places[0].mapx,
                  customScript: customScript,
                  zoomLevel: 8,
                  onTapMarker: (message) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message.message)));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
