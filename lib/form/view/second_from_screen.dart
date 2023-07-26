import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPickerButton("E/I", ["E", "I"], selectedEI, (value) {
                    setState(() {
                      selectedEI = value;
                    });
                  }),
                  _buildPickerButton("N/S", ["N", "S"], selectedNS, (value) {
                    setState(() {
                      selectedNS = value;
                    });
                  }),
                  _buildPickerButton("T/F", ["T", "F"], selectedTF, (value) {
                    setState(() {
                      selectedTF = value;
                    });
                  }),
                  _buildPickerButton("J/P", ["J", "P"], selectedJP, (value) {
                    setState(() {
                      selectedJP = value;
                    });
                  }),
                ],
              ),
              const Spacer(),
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
        currentValue != null ? PRIMARY_COLOR : const Color(0xFFDADADA);
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
