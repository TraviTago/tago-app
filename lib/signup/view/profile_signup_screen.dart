import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class ProfileSignupScreen extends StatefulWidget {
  static String get routeName => 'profileSignup';

  const ProfileSignupScreen({super.key});

  @override
  State<ProfileSignupScreen> createState() => _ProfileSignupScreenState();
}

class _ProfileSignupScreenState extends State<ProfileSignupScreen> {
  String name = "";

  String? selectedImagePath;

  @override
  Widget build(BuildContext context) {
    String number = GoRouterState.of(context).queryParameters['number']!;

    const baseBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: LABEL_BG_COLOR,
        width: 1.0,
      ),
    );
    return DefaultLayout(
      titleComponet: const Text(
        '',
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '본인과 가장 잘 어울리는\n프로필 사진을 선택해주세요',
                style: TextStyle(
                  height: 1.3,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                '그리고 이름은 되도록 본명으로 입력해주세요',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50.0,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      selectedImagePath = await context.push(
                        Uri(
                          path: '/imageSelect',
                          queryParameters: {
                            'imagePath': selectedImagePath,
                          },
                        ).toString(),
                      );
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: selectedImagePath == null ||
                                  selectedImagePath == ""
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  color: LABEL_BG_COLOR,
                                )
                              : Image.network(
                                  selectedImagePath!,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5), // 예시 색상

                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )),
                            height: 150 / 4,
                            child: const Center(
                              child: Text(
                                '사진 선택하기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ), // 필요한 콘텐츠 추가
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                cursorColor: PRIMARY_COLOR,
                autofocus: true,
                onChanged: (input) {
                  setState(() {
                    name = input;
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  counterText: '',
                  hintText: "이름을 입력하세요",
                  hintStyle: const TextStyle(
                    color: LABEL_TEXT_COLOR,
                    fontSize: 15.0,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  border: baseBorder,
                  focusedBorder: baseBorder.copyWith(
                    borderSide: baseBorder.borderSide.copyWith(
                      color: PRIMARY_COLOR,
                    ),
                  ),
                  enabledBorder: baseBorder,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width, 45)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: name.isEmpty ||
                          selectedImagePath == null ||
                          selectedImagePath == ""
                      ? MaterialStateProperty.all(LABEL_BG_COLOR)
                      : MaterialStateProperty.all(PRIMARY_COLOR),
                ),
                onPressed: name.isEmpty ||
                        selectedImagePath == null ||
                        selectedImagePath == ""
                    ? null
                    : () {
                        context.push(
                          Uri(
                            path: '/form1',
                            queryParameters: {
                              'imagePath': selectedImagePath,
                              'name': name,
                              'number': number,
                            },
                          ).toString(),
                        );
                      },
                child: Text(
                  '다음',
                  style: TextStyle(
                      color: name.isEmpty ||
                              selectedImagePath == null ||
                              selectedImagePath == ""
                          ? LABEL_TEXT_COLOR
                          : Colors.white,
                      fontWeight: FontWeight.w500,
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
