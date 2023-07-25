import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar(
      {super.key,
      required this.begin_percentage,
      required this.end_percentage});

  final double begin_percentage;
  final double end_percentage;

  @override
  // ignore: library_private_types_in_public_api
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween<double>(
            begin: widget.begin_percentage, end: widget.end_percentage)
        .animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _animation.value,
      color: PRIMARY_COLOR,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      minHeight: 10.0,
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
