import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class CourseDetailOverViewScreen extends StatelessWidget {
  const CourseDetailOverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        child: Column(
      children: [
        Row(
          children: [
            Column(),
            Icon(
              Icons.add,
              size: 45,
            ),
          ],
        ),
      ],
    ));
  }
}
