import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/form/component/button_group.dart';
import 'package:tago_app/form/component/progress_bar.dart';

class ThirdFormScreen extends StatefulWidget {
  static String get routeName => 'form3';

  const ThirdFormScreen({super.key});

  @override
  State<ThirdFormScreen> createState() => _ThirdFormScreenState();
}

class _ThirdFormScreenState extends State<ThirdFormScreen> {
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
              const Expanded(
                child: ButtonGroup(
                  isMultipleSelection: true,
                  buttonCount: 18,
                  buttonTexts: [
                    '인스타그램',
                    '유튜브',
                    '사진촬영',
                    '맛집탐방',
                    '핫플',
                    '산책',
                    '미술 / 예술',
                    '독서',
                    '영화',
                    '레저 / 엑티비티',
                    '동물',
                    '자연',
                    '역사',
                    '전통시장',
                    '바다',
                    '지역축제',
                    '커피',
                    '쇼핑',
                  ],
                  buttonImgs: [
                    'instagram',
                    'youtube',
                    'photo',
                    'food',
                    'hot-place',
                    'walk',
                    'art',
                    'book',
                    'movie',
                    'lesuire',
                    'animal',
                    'forest',
                    'history',
                    'market',
                    'sea-waves',
                    'fireworks',
                    'cafe',
                    'shopping',
                  ],
                  crossAxisCount: 3,
                  childAspectRatio: 1,
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
                    backgroundColor: MaterialStateProperty.all(BUTTON_BG_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () => context.go('/form3'),
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
