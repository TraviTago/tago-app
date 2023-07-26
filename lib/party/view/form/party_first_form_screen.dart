import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class PartyFirstFormScreen extends StatelessWidget {
  const PartyFirstFormScreen({super.key});

  static String get routeName => 'partyForm1';

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'a',
      child: Center(
        child: Text(
          '첫번째 입력',
        ),
      ),
    );
  }
}
