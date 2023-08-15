import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class CourseCompleteScreen extends StatelessWidget {
  static String get routeName => 'courseComplete';

  const CourseCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      backBtnComponent: true,
      child: Center(
        child: Text(
          "성",
        ),
      ),
    );
  }
}
