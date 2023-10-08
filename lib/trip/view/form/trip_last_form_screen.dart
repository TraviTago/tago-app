import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/course/provider/course_provider.dart';

class TripLastFormScreen extends ConsumerStatefulWidget {
  const TripLastFormScreen({super.key});
  static String get routeName => 'tripForm6';

  @override
  ConsumerState<TripLastFormScreen> createState() => _TripLastFormScreenState();
}

class _TripLastFormScreenState extends ConsumerState<TripLastFormScreen> {
  int tripNameCount = 0;
  final textController = TextEditingController();

  @override
  void initState() {
    textController.addListener(() {
      setState(() {
        tripNameCount = textController.text.length;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: DefaultLayout(
        title: '',
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressBar(
                  beginPercentage: 0.8,
                  endPercentage: 1.0,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '마지막으로',
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '코스의 이름을 정해주세요!',
                      style: TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100.0,
                ),
                Expanded(
                  child: TextField(
                    cursorOpacityAnimates: true,
                    cursorColor: PRIMARY_COLOR,
                    controller: textController,
                    maxLength: 12,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '코스명을 입력해주세요',
                      hintStyle: const TextStyle(
                          color: LABEL_TEXT_COLOR, fontSize: 16),
                      // Hide default counter
                      suffix: Text(
                        '($tripNameCount/12)',
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: LABEL_TEXT_COLOR,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: LABEL_BG_COLOR, width: 2.0),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: LABEL_BG_COLOR, width: 2.0),
                      ),
                    ),
                    style: const TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: tripNameCount == 0
                        ? MaterialStateProperty.all(
                            BUTTON_BG_COLOR.withOpacity(0.5))
                        : MaterialStateProperty.all(BUTTON_BG_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: tripNameCount == 0
                      ? null
                      : () async {
                          final int parsedPlaceId = DataUtils.listToint(
                              GoRouterState.of(context)
                                  .queryParameters['mustPlaces']!);

                          final List<String> parsedTripTags =
                              DataUtils.stringToList(GoRouterState.of(context)
                                  .queryParameters['types']);
                          await ref
                              .read(courseProvider.notifier)
                              .recommendCourse(
                                  placeId: parsedPlaceId, tags: parsedTripTags);

                          context.go(Uri(
                            path: '/tripComplete',
                            queryParameters: {
                              'dateTime': GoRouterState.of(context)
                                  .queryParameters['dateTime'],
                              'currentCnt': GoRouterState.of(context)
                                  .queryParameters['currentCnt'],
                              'maxCnt': GoRouterState.of(context)
                                  .queryParameters['maxCnt'],
                              'sameGender': GoRouterState.of(context)
                                  .queryParameters['sameGender'],
                              'sameAge': GoRouterState.of(context)
                                  .queryParameters['sameAge'],
                              'isPet': GoRouterState.of(context)
                                  .queryParameters['isPet'],
                              'meetPlace': GoRouterState.of(context)
                                  .queryParameters['meetPlace'],
                              'types': GoRouterState.of(context)
                                  .queryParameters['types'],
                              'places': GoRouterState.of(context)
                                  .queryParameters['mustPlaces'],
                              'name': textController.text
                            },
                          ).toString());
                        },
                  child: const Text(
                    '완료',
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
      ),
    );
  }
}
