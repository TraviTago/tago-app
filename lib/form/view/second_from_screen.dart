import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/form/component/progress_bar.dart';

class SecondFormScreen extends StatefulWidget {
  static String get routeName => 'form2';

  const SecondFormScreen({Key? key}) : super(key: key);

  @override
  _SecondFormScreenState createState() => _SecondFormScreenState();
}

class _SecondFormScreenState extends State<SecondFormScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _showOptions(int index, List<String> options) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => ListView(
        children: options.map((option) {
          return ListTile(
            title: Text(option),
            onTap: () {
              Navigator.pop(context, option);
            },
          );
        }).toList(),
      ),
    );

    if (selected != null) {
      _controllers[index].text = selected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = [
      ['E', 'I'],
      ['N', 'S'],
      ['T', 'F'],
      ['P', 'J'],
    ];

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
                begin_percentage: 0.25,
                end_percentage: 0.5,
              ),
              const SizedBox(
                height: 60.0,
              ),
              const Text(
                'MBTI가 무엇인가요?',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Row(
                  children: List.generate(
                    _controllers.length,
                    (index) => Flexible(
                      child: TextField(
                        controller: _controllers[index],
                        readOnly: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: _controllers[index].text.isNotEmpty
                                  ? PRIMARY_COLOR
                                  : LABEL_BG_COLOR,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: _controllers[index].text.isNotEmpty
                                  ? PRIMARY_COLOR
                                  : LABEL_BG_COLOR,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: _controllers[index].text.isNotEmpty
                              ? PRIMARY_COLOR
                              : LABEL_TEXT_COLOR,
                        ),
                        onTap: () {
                          _showOptions(index, options[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100.0,
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
