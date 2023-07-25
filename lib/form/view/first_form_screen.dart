import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class FirstFormScreen extends StatelessWidget {
  static String get routeName => 'form1';

  const FirstFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('first_form_page'),
            ElevatedButton(
              onPressed: () => context.go('/form2'),
              child: const Text('다음'),
            )
          ],
        ),
      ),
    );
  }
}
