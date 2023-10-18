import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/customer_service/model/report_model.dart';
import 'package:tago_app/customer_service/repository/customer_service_repository.dart';

class CustomerServiceReportScreen extends ConsumerStatefulWidget {
  const CustomerServiceReportScreen({super.key});
  static String get routeName => 'customerReport';

  @override
  ConsumerState<CustomerServiceReportScreen> createState() =>
      _CustomerServiceReportScreenState();
}

class _CustomerServiceReportScreenState
    extends ConsumerState<CustomerServiceReportScreen> {
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
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildReportButton("👫", ReportType.TRAVEL_MATE_ISSUE),
                    _buildReportButton("😧", ReportType.TAXI_DRIVER_ISSUE),
                    _buildReportButton("🙅‍♂️", ReportType.PLAN_ISSUE),
                    _buildReportButton("💬", ReportType.OTHERS),
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
                        setState(() {});
                      },
                      controller: _reportController,
                      maxLines: null,
                      expands: true,
                      style: const TextStyle(
                        color: LABEL_TEXT_SUB_COLOR,
                        fontSize: 13.0,
                      ),
                      decoration: const InputDecoration(
                        hintText: '상황을 상세하게 알려주세요',
                        hintStyle: TextStyle(
                          color: LABEL_TEXT_COLOR,
                          fontSize: 13.0,
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
                    ? () async {
                        _reportContents = _reportController.text.trim();

                        await ref
                            .read(customerServiceRepositoryProvider)
                            .report(
                              type: _selectedButtonText!,
                              detail: _reportContents!,
                            );

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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 5.0),
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
      ),
    );
  }

  Widget _buildReportButton(String icon, ReportType reportType) {
    final buttonText = ReportModel.reportTypeMap[reportType]!;
    final bool isSelected = _selectedButtonText == reportType.name;

    return TextButton(
      onPressed: () {
        setState(() {
          _selectedButtonText = reportType.name;
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
              buttonText,
              style: TextStyle(
                color: isSelected ? Colors.white : PRIMARY_COLOR,
                fontSize: 13.0,
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
