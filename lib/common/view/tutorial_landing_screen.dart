import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';

class TutorialLandingScreen extends StatefulWidget {
  static String get routeName => 'tutorialLanding';

  const TutorialLandingScreen({Key? key}) : super(key: key);

  @override
  _TutorialLandingScreenState createState() => _TutorialLandingScreenState();
}

class _TutorialLandingScreenState extends State<TutorialLandingScreen>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<Offset>> _offsetAnimations;
  int _currentIndex = 0;
  late AnimationController _backgroundAnimationController;
  late bool _showInitialTextAnimation;

  late AnimationController _textFadeController;
  late Animation<double> _textFadeAnimation;

  late List<AnimationController> _fadeControllers;
  late List<Animation<double>> _fadeAnimations;

  late List<AnimationController> _textColorControllers;
  late List<Animation<Color?>> _textColorAnimations;
  @override
  void initState() {
    super.initState();

    _fadeControllers = List.generate(4, (index) {
      return AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      );
    });

    _fadeAnimations = _fadeControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    }).toList();
    _textColorControllers = List.generate(4, (index) {
      return AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      );
    });

    _textColorAnimations = List.generate(4, (index) {
      return ColorTween(
        begin: (_currentIndex == 0 || _currentIndex == 1)
            ? const Color.fromARGB(175, 0, 0, 0) // 검은색
            : Colors.white, // 흰색
        end: (_currentIndex == 0 || _currentIndex == 1)
            ? Colors.white // 흰색
            : const Color.fromARGB(175, 0, 0, 0), // 검은색
      ).animate(CurvedAnimation(
        parent: _textColorControllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _textFadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _textFadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_textFadeController);
    _showInitialTextAnimation = true;

    _animationControllers = List.generate(4, (index) {
      return AnimationController(
        duration: const Duration(seconds: 4),
        vsync: this,
      )..repeat(reverse: true);
    });

    _offsetAnimations = List.generate(4, (index) {
      double startX = (index == 0 || index == 3) ? -5.0 : 0.0;
      double endX = -startX;
      return Tween<Offset>(
        begin: Offset(startX, -4.0),
        end: Offset(endX, 4.0),
      ).animate(CurvedAnimation(
        parent: _animationControllers[index],
        curve: Curves.easeInOut,
      ));
    });

    _backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % 4;
          });
          _backgroundAnimationController.forward(from: 0.0);

          // 색상 애니메이션을 재설정하고 시작합니다.
          _textColorAnimations = List.generate(4, (index) {
            return ColorTween(
              begin: (_currentIndex == 0 || _currentIndex == 1)
                  ? const Color.fromARGB(175, 0, 0, 0) // 검은색
                  : const Color.fromARGB(201, 255, 255, 255),

              end: (_currentIndex == 0 || _currentIndex == 1)
                  ? const Color.fromARGB(201, 255, 255, 255) // 흰색
                  : const Color.fromARGB(175, 0, 0, 0), // 검은색
            ).animate(CurvedAnimation(
              parent: _textColorControllers[index],
              curve: Curves.easeInOut,
            ));
          });

          for (var controller in _textColorControllers) {
            controller.forward(from: 0.0);
          }
        }
      });
  }

  @override
  void dispose() {
    // FadeControllers dispose
    for (var controller in _fadeControllers) {
      controller.dispose();
    }

    // AnimationControllers dispose
    for (var controller in _animationControllers) {
      controller.dispose();
    }

    // TextColorControllers dispose
    for (var controller in _textColorControllers) {
      controller.dispose();
    }

    // BackgroundAnimationController dispose
    _backgroundAnimationController.dispose();

    // TextFadeController dispose
    _textFadeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            child: Container(
              key: ValueKey<int>(_currentIndex),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'asset/img/tutorial/landing$_currentIndex.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (_showInitialTextAnimation)
            Positioned.fill(
              child: Container(
                color: PRIMARY_COLOR.withAlpha(170),
              ),
            ),
          Positioned.fill(
              child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              context.go("/tutorial");
            },
          )),
          if (!_showInitialTextAnimation)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.05,
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  '탭해서 시작하기',
                  style: TextStyle(
                    fontSize: 18,
                    color: LABEL_TEXT_SUB_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          if (_showInitialTextAnimation)
            Positioned(
              top: MediaQuery.of(context).size.height / 6,
              left: MediaQuery.of(context).size.width / 9,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '부산 택시 투어 플랫폼',
                    textStyle: const TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(166, 255, 255, 255),
                        fontWeight: FontWeight.w500),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                onFinished: () {},
              ),
            ),
          if (_showInitialTextAnimation)
            FutureBuilder(
                future: Future.delayed(const Duration(seconds: 2)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Positioned(
                      top: MediaQuery.of(context).size.height / 4,
                      left: MediaQuery.of(context).size.width / 9,
                      child: AnimatedTextKit(
                        onNextBeforePause: (p0, p1) => {},
                        animatedTexts: [
                          TypewriterAnimatedText(
                            '같이타고',
                            textStyle: const TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            speed: const Duration(milliseconds: 300),
                          ),
                        ],
                        totalRepeatCount: 1,
                        onFinished: () {
                          setState(() {
                            _showInitialTextAnimation = false;
                          });
                          _backgroundAnimationController.forward();
                          for (var controller in _fadeControllers) {
                            controller.forward();
                          }
                        },
                      ),
                    );
                  }
                  return Container();
                }),
          if (!_showInitialTextAnimation)
            ...List.generate(4, (index) {
              double top = (index == 0)
                  ? MediaQuery.of(context).size.height / 5
                  : (index == 1)
                      ? MediaQuery.of(context).size.height * 2 / 5
                      : (index == 2)
                          ? MediaQuery.of(context).size.height * 3 / 5
                          : MediaQuery.of(context).size.height * 4 / 5;
              double left = (index == 0 || index == 2)
                  ? MediaQuery.of(context).size.width / 6
                  : MediaQuery.of(context).size.width / 2;

              return Positioned(
                top: top,
                left: left,
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _offsetAnimations[index],
                    _textColorAnimations[index], // 색상 애니메이션을 병합합니다.
                  ]),
                  builder: (context, child) {
                    return Transform.translate(
                      offset: _offsetAnimations[index].value,
                      child: FadeTransition(
                        opacity: _fadeAnimations[index],
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    ['부산에서', '택시타고', '구석구석', '여행하자!'][index],
                    style: TextStyle(
                        fontSize: (index == 0)
                            ? 50
                            : (index == 1)
                                ? 40
                                : (index == 2)
                                    ? 60
                                    : (index == 3)
                                        ? 38
                                        : 29,
                        color: _textColorAnimations[index].value,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
