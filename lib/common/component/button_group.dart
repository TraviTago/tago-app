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
  final bool prefix;
  final bool isProfileStyle;

  final Function(List<String>) onButtonSelected;
  final bool isModal;
  final List<int>? initialSelectedIndexes;

  const ButtonGroup({
    Key? key,
    required this.buttonCount,
    required this.buttonTexts,
    required this.crossAxisCount,
    required this.childAspectRatio,
    this.prefix = false,
    this.buttonImgs,
    this.isProfileStyle = false,
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
                              ? BUTTON_BG_COLOR
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

                    // 인덱스를 텍스트로 변환합니다.
                    List<String> selectedTexts = selectedButtons
                        .map((i) => widget.buttonTexts[i])
                        .toList();

                    // 변환된 텍스트 리스트를 콜백 함수에 전달합니다.
                    widget.onButtonSelected(selectedTexts);
                  },
                )
              : OutlinedButton(
                  style: ButtonStyle(
                    padding: widget.isProfileStyle
                        ? MaterialStateProperty.all(EdgeInsets.zero)
                        : null,
                    backgroundColor: MaterialStateProperty.all(
                      selectedButtons.contains(index)
                          ? Colors.white
                          : LABEL_BG_COLOR,
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.resolveWith((states) {
                      if (widget.isProfileStyle) {
                        if (selectedButtons.contains(index)) {
                          return const BorderSide(
                              color: PRIMARY_COLOR, width: 5);
                        } else {
                          return const BorderSide(color: Colors.transparent);
                        }
                      } else {
                        if (selectedButtons.contains(index)) {
                          return const BorderSide(
                              color: PRIMARY_COLOR, width: 3);
                        } else {
                          return const BorderSide(color: Colors.transparent);
                        }
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

                    // 인덱스를 텍스트로 변환합니다.
                    List<String> selectedTexts = selectedButtons
                        .map((i) => widget.buttonTexts[i])
                        .toList();

                    // 변환된 텍스트 리스트를 콜백 함수에 전달합니다.
                    widget.onButtonSelected(selectedTexts);
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!widget.isProfileStyle)
                          Opacity(
                            opacity:
                                selectedButtons.contains(index) ? 1.0 : 0.5,
                            child: widget.prefix
                                ? Image.network(
                                    widget.buttonImgs![index],
                                  )
                                : Image.asset(
                                    'asset/img/${widget.buttonImgs![index]}.png',
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                          ),
                        if (widget.isProfileStyle)
                          Stack(
                            children: [
                              if (widget.prefix)
                                Image.network(
                                  widget.buttonImgs![index],
                                ),
                              if (!widget.prefix)
                                Image.asset(
                                  'asset/img/${widget.buttonImgs![index]}.png',
                                ),
                              if (selectedButtons.contains(index))
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius:
                                            const BorderRadius.only()),
                                    child: const Center(
                                      child: Text(
                                        '선택',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        if (!widget.isProfileStyle) const SizedBox(height: 10),
                        if (!widget.isProfileStyle)
                          Text(
                            widget.buttonTexts[index],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: selectedButtons.contains(index)
                                  ? FontWeight.w500
                                  : FontWeight.w500,
                              color: selectedButtons.contains(index)
                                  ? LABEL_TEXT_SUB_COLOR
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
