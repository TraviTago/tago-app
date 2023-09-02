import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class CustomerServiceQuestionScreen extends StatelessWidget {
  const CustomerServiceQuestionScreen({super.key});
  static String get routeName => 'customerQuestion';

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      titleComponet: Text(
        '자주 묻는 질문',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      child: Center(
        child: Text('자주 묻는 질문'),
      ),
    );
  }
}
