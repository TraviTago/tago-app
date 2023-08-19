import 'package:flutter/material.dart';

class SpacerContainer extends StatelessWidget {
  const SpacerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 15,
      decoration: const BoxDecoration(color: Color(0xFFF4F4F4)),
    );
  }
}
