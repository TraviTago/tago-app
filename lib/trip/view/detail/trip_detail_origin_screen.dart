import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class TripDetailOriginScreen extends StatelessWidget {
  static String get routeName => 'tripDetailOrigin';

  const TripDetailOriginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      titleComponet: Text(
        '',
      ),
      child: Center(
        child: Text("aaa"),
      ),
    );
  }
}
