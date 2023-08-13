import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class CourseDetailMapScreen extends StatelessWidget {
  const CourseDetailMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(
        child: Text('map'),
      ),
    );
  }
}
