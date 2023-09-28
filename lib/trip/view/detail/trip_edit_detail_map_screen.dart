import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/place/model/place_trip_model.dart';

class TripEditDetailMapScreen extends StatelessWidget {
  final List<PlaceTripModel> places;

  const TripEditDetailMapScreen({
    Key? key,
    required this.places,
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
          
          ${places.asMap().entries.map((entry) {
          final index = entry.key;
          final place = entry.value;
          final imageSrc = snapshot.data![0][index];
          return '''addCustomMarkerAndOverlay(new kakao.maps.LatLng(${place.mapY}, ${place.mapX}), "${place.title}", "$imageSrc");''';
        }).join()}

        ''';

        return DefaultLayout(
          child: Stack(
            children: [
              KakaoMapView(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                kakaoMapKey: dotenv.env['KAKAO_REST_JAVASCRIPT_KEY']!,
                lat: places[0].mapY,
                lng: places[0].mapX,
                customScript: customScript,
                zoomLevel: 8,
                onTapMarker: (message) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message.message)));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
