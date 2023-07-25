import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class LastFormScreen extends StatelessWidget {
  static String get routeName => 'form4';

  const LastFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('last_form_screen'),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('시작하기'),
            )
          ],
        ),
      ),
    );
  }
}
