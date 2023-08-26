import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';

class ThirdFormScreen extends StatefulWidget {
  static String get routeName => 'form3';

  const ThirdFormScreen({super.key});

  @override
  State<ThirdFormScreen> createState() => _ThirdFormScreenState();
}

class _ThirdFormScreenState extends State<ThirdFormScreen> {
  List<String> _selectedFavorites = [];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(
                beginPercentage: 0.5,
                endPercentage: 0.75,
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                '좋아하는 것들을 골라주세요!',
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
                      _selectedFavorites = selectedButtons;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: _selectedFavorites.isEmpty
                        ? MaterialStateProperty.all(
                            BUTTON_BG_COLOR.withOpacity(0.5))
                        : MaterialStateProperty.all(BUTTON_BG_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: _selectedFavorites.isEmpty
                      ? null
                      : () => context.push(
                            Uri(
                              path: '/form4',
                              queryParameters: {
                                'ageRange': GoRouterState.of(context)
                                    .queryParameters['ageRange'],
                                'gender': GoRouterState.of(context)
                                    .queryParameters['gender'],
                                'mbti': GoRouterState.of(context)
                                    .queryParameters['mbti'],
                                'favorites': _selectedFavorites.join(','),
                              },
                            ).toString(),
                          ),
                  child: const Text(
                    '다음',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
