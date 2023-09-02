import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class CustomerServiceReportScreen extends StatefulWidget {
  const CustomerServiceReportScreen({super.key});
  static String get routeName => 'customerReport';

  @override
  State<CustomerServiceReportScreen> createState() =>
      _CustomerServiceReportScreenState();
}

class _CustomerServiceReportScreenState
    extends State<CustomerServiceReportScreen> {
  String? _selectedButtonText;
  String? _reportContents;
  final TextEditingController _reportController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      titleComponet: const Text(
        '실시간 불편 신고',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildReportButton("👫", "여행메이트와 불편한 문제가 생겼어요"),
                  _buildReportButton("😧", "택시기사님이 불친절해요"),
                  _buildReportButton("🙅‍♂️", "기존의 계획된 코스로 진행되지 않아요"),
                  _buildReportButton("💬", "기타문의"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Container(
                width: double.infinity,
                height: 200.0,
                decoration: BoxDecoration(
                  color: LABEL_BG_COLOR,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (text) {
                      setState(
                          () {}); // This will trigger a rebuild every time the text changes
                    },
                    controller: _reportController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(
                      color: LABEL_TEXT_SUB_COLOR,
                      fontSize: 12.0,
                    ),
                    decoration: const InputDecoration(
                      hintText: '상황을 상세하게 알려주세요',
                      hintStyle: TextStyle(
                        color: LABEL_TEXT_COLOR,
                        fontSize: 12.0,
                      ),
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: (_selectedButtonText != null &&
                      _reportController.text.trim().isNotEmpty)
                  ? () {
                      _reportContents = _reportController.text.trim();
                      print("Selected Button: $_selectedButtonText");
                      print("Report Contents: $_reportContents");
                      _showReportConfirmationDialog(); // Call the dialog function here
                    }
                  : null,
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: (_selectedButtonText != null &&
                        _reportController.text.trim().isNotEmpty)
                    ? PRIMARY_COLOR
                    : LABEL_BG_COLOR,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60.0, vertical: 5.0),
                child: Text(
                  "신고 보내기",
                  style: TextStyle(
                    color: (_selectedButtonText != null &&
                            _reportController.text.trim().isNotEmpty)
                        ? Colors.white
                        : PRIMARY_COLOR,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportButton(String icon, String text) {
    final bool isSelected = _selectedButtonText == text;

    return TextButton(
      onPressed: () {
        setState(() {
          _selectedButtonText = text;
        });
      },
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: isSelected ? PRIMARY_COLOR : LABEL_BG_COLOR,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              icon,
            ),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : PRIMARY_COLOR,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReportConfirmationDialog() {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: false,
      barrierColor: LABEL_TEXT_SUB_COLOR
          .withOpacity(0.4), // background color with opacity
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xFFF1F1F1),
          contentPadding: const EdgeInsets.all(0.0),
          elevation: 0,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 25.0,
                ),
                child: Text(
                  '신고가 접수 되었어요\n빠르게 파악하고 연락드릴게요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFD9D9D9),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor:
                          const MaterialStatePropertyAll(Color(0xFFF1F1F1)),
                      elevation: const MaterialStatePropertyAll(0.0),
                    ),
                    child: const Text(
                      '홈으로',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
