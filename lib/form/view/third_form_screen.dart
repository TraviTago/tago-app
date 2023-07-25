import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class ThirdFormScreen extends StatelessWidget {
  static String get routeName => 'form3';

  const ThirdFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('third_form_screen'),
            ElevatedButton(
              onPressed: () => context.go('/form4'),
              child: const Text('다음'),
            )
          ],
        ),
      ),
    );
  }
}
