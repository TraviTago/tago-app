import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';

class ButtonGroup extends StatefulWidget {
  final int buttonCount;
  final List<String> buttonTexts;
  final List<String>? buttonImgs;
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isMultipleSelection;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final Function(List<int>) onButtonSelected; // 콜백 함수 추가
  final bool isModal;
  final List<int>? initialSelectedIndexes;

  const ButtonGroup({
    Key? key,
    required this.buttonCount,
    required this.buttonTexts,
    required this.crossAxisCount,
    required this.childAspectRatio,
    this.buttonImgs,
    this.isMultipleSelection = false,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.isModal = false,
    this.initialSelectedIndexes,
    required this.onButtonSelected, // 콜백 함수 필요
  }) : super(key: key);

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  late List<int> selectedButtons;

  @override
  void initState() {
    super.initState();
    selectedButtons = widget.initialSelectedIndexes ??
        []; // Initialize with selected indexes if they exist, else initialize with an empty list.
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: widget.crossAxisCount,
      childAspectRatio: widget.childAspectRatio,
      mainAxisSpacing: widget.mainAxisSpacing,
      crossAxisSpacing: widget.crossAxisSpacing,
      children: List.generate(
        widget.buttonCount,
        (index) {
          return widget.buttonImgs == null
              ? ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    backgroundColor: MaterialStateProperty.all(
                      selectedButtons.contains(index)
                          ? PRIMARY_COLOR
                          : widget.isModal
                              ? Colors.white
                              : LABEL_BG_COLOR,
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      // borderRadius 설정
                      borderRadius:
                          BorderRadius.circular(widget.isModal ? 10.0 : 5.0),
                    )),
                  ),
                  child: Text(
                    widget.buttonTexts[index],
                    style: TextStyle(
                      fontSize: widget.isModal ? 14 : 12,
                      fontWeight: selectedButtons.contains(index)
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: selectedButtons.contains(index)
                          ? Colors.white
                          : widget.isModal
                              ? const Color(0xFF747474)
                              : LABEL_TEXT_COLOR,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (widget.isMultipleSelection) {
                        if (selectedButtons.contains(index)) {
                          selectedButtons.remove(index);
                        } else {
                          selectedButtons.add(index);
                        }
                      } else {
                        selectedButtons = [index];
                      }
                    });
                    widget.onButtonSelected(selectedButtons);
                  },
                )
              : OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      selectedButtons.contains(index)
                          ? Colors.white
                          : LABEL_BG_COLOR,
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.resolveWith((states) {
                      if (selectedButtons.contains(index)) {
                        return const BorderSide(color: PRIMARY_COLOR, width: 3);
                      } else {
                        return const BorderSide(color: Colors.transparent);
                      }
                    }),
                  ),
                  onPressed: () {
                    setState(() {
                      if (widget.isMultipleSelection) {
                        if (selectedButtons.contains(index)) {
                          selectedButtons.remove(index);
                        } else {
                          selectedButtons.add(index);
                        }
                      } else {
                        selectedButtons = [index];
                      }
                    });
                    widget.onButtonSelected(selectedButtons);
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: selectedButtons.contains(index) ? 1.0 : 0.5,
                          child: Image.asset(
                            'asset/img/${widget.buttonImgs![index]}.png',
                            width: 45.0,
                            height: 45.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.buttonTexts[index],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: selectedButtons.contains(index)
                                ? FontWeight.w500
                                : FontWeight.w500,
                            color: selectedButtons.contains(index)
                                ? const Color(0xFF595959)
                                : LABEL_TEXT_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ));
        },
      ),
    );
  }
}
