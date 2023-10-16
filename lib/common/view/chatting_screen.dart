import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class ChattingScreen extends StatelessWidget {
  static String get routeName => 'chatting';

  const ChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        titleComponet: Text(
          '타고챗',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Center(
          child: Text('aa'),
        ));
  }
}
