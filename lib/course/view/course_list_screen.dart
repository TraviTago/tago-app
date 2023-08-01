import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/course/component/course_card.dart';
import 'package:tago_app/course/component/course_recommend_card.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 55,
          height: 55,
          child: FloatingActionButton.extended(
            shape: const CircleBorder(),
            label: const Icon(
              Icons.add,
              size: 45,
            ),
            onPressed: () {
              context.go('/courseForm1');
            },
            backgroundColor: PRIMARY_COLOR,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '당신에게 딱 맞는 여행!',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            CourseRecommendCard.fromModel(model: courseData),
            CourseCard.fromModel(model: courseCardData),
          ],
        ),
      ),
    );
  }
}
