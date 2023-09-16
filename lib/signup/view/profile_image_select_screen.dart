import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class ProfileImageSelectScreen extends StatefulWidget {
  static String get routeName => 'profileImageSelect';

  const ProfileImageSelectScreen({super.key});

  @override
  State<ProfileImageSelectScreen> createState() =>
      _ProfileImageSelectScreenState();
}

class _ProfileImageSelectScreenState extends State<ProfileImageSelectScreen> {
  List<String> selectedImg = [];

  @override
  Widget build(BuildContext context) {
    String imagePath = GoRouterState.of(context).queryParameters['imagePath']!;
    int? key = getKeyFromValue(imgUrlData, imagePath);

    return DefaultLayout(
      popMethod: () {
        if (selectedImg.isNotEmpty) {
          context.pop(imgUrlData[int.parse(selectedImg[0])]);
        } else {
          context.pop(imagePath);
        }
      },
      child: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ButtonGroup(
                  prefix: true,
                  isMultipleSelection: false,
                  buttonCount: 15,
                  buttonTexts: imgUrlData.keys
                      .map((intKey) => intKey.toString())
                      .toList(),
                  buttonImgs: imgUrlData.values.toList(),
                  isProfileStyle: true,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 3,
                  initialSelectedIndexes: key != null ? [key] : [],
                  childAspectRatio: 1,
                  onButtonSelected: (selectedButtons) {
                    // 콜백 구현
                    setState(() {
                      selectedImg = selectedButtons;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int? getKeyFromValue(Map<int, String> map, String value) {
    for (var entry in map.entries) {
      if (entry.value == value) {
        return entry.key;
      }
    }
    return null;
  }
}
