import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/component/progress_bar.dart';

class SecondFormScreen extends StatefulWidget {
  static String get routeName => 'form2';

  const SecondFormScreen({Key? key}) : super(key: key);

  @override
  _SecondFormScreenState createState() => _SecondFormScreenState();
}

class _SecondFormScreenState extends State<SecondFormScreen> {
  String? selectedEI;
  String? selectedNS;
  String? selectedTF;
  String? selectedJP;

  void _showPicker(String title, List<String> options, String? currentValue,
      Function(String) onChanged) {
    int selectedIndex =
        currentValue != null ? options.indexOf(currentValue) : 0;
    onChanged(options[selectedIndex]);
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: const Text('확인'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 50.0,
                  scrollController:
                      FixedExtentScrollController(initialItem: selectedIndex),
                  onSelectedItemChanged: (index) {
                    onChanged(options[index]);
                  },
                  children: options
                      .map((option) => Center(child: Text(option)))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressBar(
                beginPercentage: 0.25,
                endPercentage: 0.5,
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                'MBTI가 무엇인가요?',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 150,
              ),
              Expanded(
                child: SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonGroup(
                          fontSize: 25.0,
                          buttonCount: 2,
                          mainAxisSpacing: 25.0,
                          crossAxisSpacing: 15.0,
                          radius: 10.0,
                          buttonTexts: const [
                            'E',
                            'I',
                          ],
                          crossAxisCount: 1,
                          childAspectRatio: 1,
                          onButtonSelected: (selectedButtons) {
                            selectedEI = selectedButtons[0];
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: ButtonGroup(
                          fontSize: 25.0,
                          buttonCount: 2,
                          mainAxisSpacing: 25.0,
                          crossAxisSpacing: 15.0,
                          radius: 10.0,
                          buttonTexts: const [
                            'N',
                            'S',
                          ],
                          crossAxisCount: 1,
                          childAspectRatio: 1,
                          onButtonSelected: (selectedButtons) {
                            // 콜백 구현
                            selectedNS = selectedButtons[0];
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: ButtonGroup(
                          fontSize: 25.0,
                          buttonCount: 2,
                          mainAxisSpacing: 25.0,
                          crossAxisSpacing: 15.0,
                          radius: 10.0,
                          buttonTexts: const [
                            'F',
                            'T',
                          ],
                          crossAxisCount: 1,
                          childAspectRatio: 1,
                          onButtonSelected: (selectedButtons) {
                            // 콜백 구현
                            selectedTF = selectedButtons[0];
                            setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: ButtonGroup(
                          fontSize: 25.0,
                          buttonCount: 2,
                          mainAxisSpacing: 25.0,
                          crossAxisSpacing: 15.0,
                          radius: 10.0,
                          buttonTexts: const [
                            'P',
                            'J',
                          ],
                          crossAxisCount: 1,
                          childAspectRatio: 1,
                          onButtonSelected: (selectedButtons) {
                            // 콜백 구현
                            selectedJP = selectedButtons[0];
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 45)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: selectedEI == null ||
                            selectedNS == null ||
                            selectedTF == null ||
                            selectedJP == null
                        ? MaterialStateProperty.all(
                            BUTTON_BG_COLOR.withOpacity(0.5))
                        : MaterialStateProperty.all(BUTTON_BG_COLOR),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: selectedEI == null ||
                          selectedNS == null ||
                          selectedTF == null ||
                          selectedJP == null
                      ? null
                      : () {
                          final mbti =
                              '${selectedEI ?? ''}${selectedNS ?? ''}${selectedTF ?? ''}${selectedJP ?? ''}';

                          context.push(
                            Uri(
                              path: '/form3',
                              queryParameters: {
                                'ageRange': GoRouterState.of(context)
                                    .queryParameters['ageRange'],
                                'gender': GoRouterState.of(context)
                                    .queryParameters['gender'],
                                'name': GoRouterState.of(context)
                                    .queryParameters['name'],
                                'imagePath': GoRouterState.of(context)
                                    .queryParameters['imagePath'],
                                'number': GoRouterState.of(context)
                                    .queryParameters['number'],
                                'mbti': mbti,
                                'isPatching': GoRouterState.of(context)
                                    .queryParameters['isPatching'],
                              },
                            ).toString(),
                          );
                        },
                  child: const Text(
                    '다음',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPickerButton(String title, List<String> options,
      String? currentValue, Function(String) onChanged) {
    Color underlineColor =
        currentValue != null ? PRIMARY_COLOR : SELECTED_BOX_BG_COLOR;
    return InkWell(
      onTap: () => _showPicker(title, options, currentValue, onChanged),
      child: Column(
        children: [
          Text(currentValue ?? "",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                  color: underlineColor)),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 53,
            height: 4,
            decoration: BoxDecoration(
              color: underlineColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
