import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';

class PhoneNumberField extends StatefulWidget {
  final String hintText;
  final bool valid;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool isPhoneNumber;
  final String? errorText;
  const PhoneNumberField({
    super.key,
    required this.onChanged,
    required this.isPhoneNumber,
    required this.valid,
    required this.hintText,
    this.errorText,
    this.enabled = true,
  });

  @override
  State<PhoneNumberField> createState() => PhoneNumberFieldState();
}

class PhoneNumberFieldState extends State<PhoneNumberField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var text = _controller.text;

      if (widget.isPhoneNumber) {
        String formattedText;

        text = text.replaceAll("-", "");
        if (text.length <= 3) {
          formattedText = text;
        } else if (text.length <= 7) {
          formattedText = "${text.substring(0, 3)}-${text.substring(3)}";
        } else {
          formattedText =
              "${text.substring(0, 3)}-${text.substring(3, 7)}-${text.substring(7)}";
        }

        // 여기서 formattedText와 _controller.text가 다를 때만 _controller의 값을 업데이트 합니다.
        if (formattedText != _controller.text) {
          _controller.value = TextEditingValue(
            text: formattedText,
            selection: TextSelection.collapsed(offset: formattedText.length),
          );
        }

        widget.onChanged?.call(_controller.text.replaceAll(" ", ""));
      } else {
        // isPhoneNumber가 false일 경우, 공백 처리 없이 그대로 원본 텍스트를 사용합니다.
        widget.onChanged?.call(text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const baseBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: LABEL_BG_COLOR,
        width: 1.0,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: widget.isPhoneNumber ? 13 : 6, // maxLength 조정
              enabled: widget.enabled,
              cursorColor: PRIMARY_COLOR,
              autofocus: true,

              onChanged: widget.onChanged,
              decoration: InputDecoration(
                errorText: widget.errorText,
                contentPadding: const EdgeInsets.all(10),
                counterText: '',
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: LABEL_TEXT_COLOR,
                  fontSize: 15.0,
                ),
                fillColor: Colors.white,
                filled: true,
                border: baseBorder,
                focusedBorder: baseBorder.copyWith(
                  borderSide: baseBorder.borderSide.copyWith(
                    color: PRIMARY_COLOR,
                  ),
                ),
                enabledBorder: baseBorder,
              ),
            ),
          ),
          if (widget.valid == false)
            const Expanded(
                flex: 1,
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: PRIMARY_COLOR,
                )),
        ],
      ),
    );
  }
}
