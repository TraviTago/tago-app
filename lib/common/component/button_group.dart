import 'package:cached_network_image/cached_network_image.dart';
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
  final double radius;
  final bool isAdjacent;

  final Function(List<String>) onButtonSelected;
  final bool isModal;
  final List<int>? initialSelectedIndexes;

  final double fontSize;

  const ButtonGroup({
    Key? key,
    required this.buttonCount,
    required this.buttonTexts,
    required this.crossAxisCount,
    required this.childAspectRatio,
    this.isAdjacent = false,
    this.prefix = false,
    this.radius = 5.0,
    this.buttonImgs,
    this.isProfileStyle = false,
    this.isMultipleSelection = false,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.isModal = false,
    this.initialSelectedIndexes,
    required this.fontSize,
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

  BorderRadius _getBorderRadius(int index) {
    if (!widget.isAdjacent) return BorderRadius.circular(widget.radius);

    if (index == 0) {
      // 첫 번째 버튼 (왼쪽 버튼)
      return BorderRadius.only(
        topLeft: Radius.circular(widget.radius),
        bottomLeft: Radius.circular(widget.radius),
      );
    } else if (index == widget.buttonCount - 1) {
      // 마지막 버튼 (오른쪽 버튼)
      return BorderRadius.only(
        topRight: Radius.circular(widget.radius),
        bottomRight: Radius.circular(widget.radius),
      );
    }
    return BorderRadius.zero; // 중간 버튼에는 BorderRadius 적용하지 않음
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
                      borderRadius: _getBorderRadius(index),
                    )),
                  ),
                  child: Text(
                    widget.buttonTexts[index],
                    style: TextStyle(
                      fontSize: widget.fontSize,
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
                                ? CachedNetworkImage(
                                    imageUrl: widget.buttonImgs![index],
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
                                CachedNetworkImage(
                                  imageUrl: widget.buttonImgs![index],
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
