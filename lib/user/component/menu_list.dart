import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';

class MenuList extends StatelessWidget {
  final List<String> titles;
  final List<VoidCallback?>? onTaps; // 각 메뉴 항목에 대한 콜백 함수 목록

  const MenuList({
    Key? key,
    required this.titles, // 콜백 함수 목록을 위한 옵셔널 매개변수
    required this.onTaps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: titles.asMap().entries.map((entry) {
        bool isLast = entry.key == titles.length - 1;
        return _buildMenuEntry(
            context, entry.value, isLast, onTaps?[entry.key]);
      }).toList(),
    );
  }

  Widget _buildMenuEntry(
      BuildContext context, String title, bool isLast, VoidCallback? onTap) {
    return Column(
      children: [
        InkWell(
          // InkWell 위젯으로 버튼 효과 추가
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 30.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: LABEL_TEXT_SUB_COLOR,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Container(
              height: 1.5,
              decoration: const BoxDecoration(color: Color(0xFFF4F4F4)),
            ),
          ),
      ],
    );
  }
}
