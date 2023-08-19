import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class PlaceDetaiLScreen extends StatefulWidget {
  static String get routeName => 'placeDetail';

  const PlaceDetaiLScreen({
    super.key,
  });

  @override
  State<PlaceDetaiLScreen> createState() => _PlaceDetaiLScreenState();
}

class _PlaceDetaiLScreenState extends State<PlaceDetaiLScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final placeId =
        int.parse(GoRouterState.of(context).pathParameters['placeId']!);
    return DefaultLayout(
        title: 'aa',
        child: Center(
          child: Text(placeId.toString()),
        ));
  }
}
