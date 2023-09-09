import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: LABEL_BG_COLOR,
        width: 1.0,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할 때
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: LABEL_TEXT_COLOR,
          fontSize: 15.0,
        ),
        fillColor: Colors.white,
        filled: true,
        // 모든 Input 상태의 기본 스타일 세팅
        border: baseBorder,
        // 선택 시의 Input 기본 스타일은 기존 기본 스타일에서 색상만 변경
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
        enabledBorder: baseBorder,
      ),
    );
  }
}
