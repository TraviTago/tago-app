import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/party/component/form/person_counter.dart';

class PartySecondFormScreen extends StatefulWidget {
  const PartySecondFormScreen({Key? key}) : super(key: key);
  static String get routeName => 'partyForm2';

  @override
  _PartySecondFormScreenState createState() => _PartySecondFormScreenState();
}

class _PartySecondFormScreenState extends State<PartySecondFormScreen> {
  List<int> selectedButtons = [];
  int counter = 1;
  bool isPrivateParty = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return DefaultLayout(
      title: '',
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProgressBar(beginPercentage: 0.16, endPercentage: 0.32),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    '일행이 있으신가요?',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenWidth / 5 * 2,
                child: ButtonGroup(
                  buttonCount: 2,
                  buttonTexts: const ['아니요. 타고에서 구할래요!', '네 일행이 있습니다!'],
                  crossAxisCount: 1,
                  childAspectRatio: 5,
                  onButtonSelected: (selected) {
                    setState(() {
                      selectedButtons = selected;
                    });
                  },
                ),
              ),
              if (!selectedButtons.contains(1))
                const SizedBox(
                  height: 100,
                ),
              if (selectedButtons.contains(1))
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '총 인원수',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          PersonCounter(
                            count: counter,
                            onIncrement: () {
                              setState(() {
                                counter++;
                              });
                            },
                            onDecrement: () {
                              setState(() {
                                if (counter > 1) counter--;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            // Checkbox 크기 조정
                            scale: 1.2,
                            child: Checkbox(
                              activeColor: PRIMARY_COLOR,
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFDADADA),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              value: isPrivateParty,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isPrivateParty = newValue ?? false;
                                });
                              },
                            ),
                          ),
                          const Text(
                            '저희 일행끼리만 여행하고 싶어요',
                            style: TextStyle(
                              color: Color(0xFF595959),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width, 45)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: selectedButtons.isEmpty
                      ? MaterialStateProperty.all(
                          BUTTON_BG_COLOR.withOpacity(0.5))
                      : MaterialStateProperty.all(BUTTON_BG_COLOR),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: selectedButtons.isEmpty
                    ? null
                    : () {
                        print(isPrivateParty);
                        print(counter);
                        print(selectedButtons);
                        context.goNamed('partyForm3');
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
