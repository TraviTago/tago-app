import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';

class PersonCounter extends StatefulWidget {
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Color textColor;
  final int min; // 최소값 속성 추가
  final int max; // 최대값 속성 추가

  const PersonCounter({
    Key? key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    required this.min,
    required this.max,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  PersonCounterState createState() => PersonCounterState();
}

class PersonCounterState extends State<PersonCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: SELECTED_BOX_BG_COLOR,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              splashRadius: 18,
              onPressed: widget.count > widget.min ? widget.onDecrement : null,
              icon: Icon(
                Icons.remove,
                size: 18.0,
                color: widget.count > widget.min
                    ? LABEL_TEXT_SUB_COLOR
                    : SELECTED_BOX_BG_COLOR,
              ),
            ),
            Text(
              '${widget.count}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: widget.textColor,
              ),
            ),
            IconButton(
              splashRadius: 18,
              onPressed: widget.count < widget.max ? widget.onIncrement : null,
              icon: Icon(
                Icons.add,
                size: 18.0,
                color: widget.count < widget.max
                    ? LABEL_TEXT_SUB_COLOR
                    : SELECTED_BOX_BG_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
