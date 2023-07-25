import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';

class ButtonGroup extends StatefulWidget {
  final int buttonCount;
  final List<String> buttonTexts;
  final int crossAxisCount;
  final double childAspectRatio;

  const ButtonGroup({
    Key? key,
    required this.buttonCount,
    required this.buttonTexts,
    required this.crossAxisCount,
    required this.childAspectRatio,
  }) : super(key: key);

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  int selectedButton = -1;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: widget.crossAxisCount,
      childAspectRatio: widget.childAspectRatio,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: List.generate(widget.buttonCount, (index) {
        return ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            backgroundColor: MaterialStateProperty.all(
              selectedButton == index ? PRIMARY_COLOR : LABEL_BG_COLOR,
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Text(
            widget.buttonTexts[index],
            style: TextStyle(
              fontWeight:
                  selectedButton == index ? FontWeight.w700 : FontWeight.w500,
              color: selectedButton == index ? Colors.white : LABEL_TEXT_COLOR,
            ),
          ),
          onPressed: () {
            setState(() {
              selectedButton = index;
            });
          },
        );
      }),
    );
  }
}
