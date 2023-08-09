import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class CourseFifthFormScreen extends StatefulWidget {
  const CourseFifthFormScreen({super.key});
  static String get routeName => 'courseForm5';

  @override
  State<CourseFifthFormScreen> createState() => _CourseFifthFormScreenState();
}

class _CourseFifthFormScreenState extends State<CourseFifthFormScreen> {
  List<String> likes = [];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(
                beginPercentage: 0.64,
                endPercentage: 0.8,
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                '부산에서 뭘 하고 싶으신가요?',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Expanded(
                child: ButtonGroup(
                  isMultipleSelection: true,
                  buttonCount: 18,
                  buttonTexts: buttonData.keys.toList(),
                  buttonImgs: buttonData.values.toList(),
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  onButtonSelected: (selectedButtons) {
                    // 콜백 구현
                    setState(() {
                      likes = selectedButtons;
                    });
                    print('Selected buttons: $selectedButtons');
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width, 45)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: likes.isEmpty
                      ? MaterialStateProperty.all(
                          BUTTON_BG_COLOR.withOpacity(0.5))
                      : MaterialStateProperty.all(BUTTON_BG_COLOR),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: likes.isEmpty
                    ? null
                    : () {
                        print('Selected like Place : $likes');
                        context.goNamed('courseForm6');
                      },
                child: const Text(
                  '다음',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
