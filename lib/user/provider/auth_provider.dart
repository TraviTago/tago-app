import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/view/root_tab.dart';
import 'package:tago_app/common/view/splash_screen.dart';
import 'package:tago_app/place/view/place_detail_screen.dart';
import 'package:tago_app/trip/view/detail/trip_detail_screen.dart';
import 'package:tago_app/trip/view/form/trip_complete_screen.dart';
import 'package:tago_app/trip/view/form/trip_fifth_form_screen.dart';
import 'package:tago_app/trip/view/form/trip_first_form_screen.dart';
import 'package:tago_app/trip/view/form/trip_fourth_from_screen.dart';
import 'package:tago_app/trip/view/form/trip_last_form_screen.dart';
import 'package:tago_app/trip/view/form/trip_second_form_screen.dart';
import 'package:tago_app/trip/view/form/trip_third_form_screen.dart';
import 'package:tago_app/signup/view/first_form_screen.dart';
import 'package:tago_app/signup/view/last_form_screen.dart';
import 'package:tago_app/signup/view/second_from_screen.dart';
import 'package:tago_app/signup/view/third_form_screen.dart';
import 'package:tago_app/user/model/user_model.dart';
import 'package:tago_app/user/provider/user_provider.dart';
import 'package:tago_app/login/view/login_screen.dart';
import 'package:tago_app/user/view/my_profile_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userProvider, (previous, next) {
      if (previous != next) {
        //UserMeProvider에 변경사항이 생겼을 때만 AuthProvider에 알린다.
        notifyListeners();
      }
    });
    ref.listen<bool>(splashScreenTimerProvider, (previous, next) {
      if (previous != next) {
        //UserMeProvider에 변경사항이 생겼을 때만 AuthProvider에 알린다.
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: '/form1',
          name: FirstFormScreen.routeName,
          builder: (_, __) => const FirstFormScreen(),
        ),
        GoRoute(
          path: '/form2',
          name: SecondFormScreen.routeName,
          builder: (_, __) => const SecondFormScreen(),
        ),
        GoRoute(
          path: '/form3',
          name: ThirdFormScreen.routeName,
          builder: (_, __) => const ThirdFormScreen(),
        ),
        GoRoute(
          path: '/form4',
          name: LastFormScreen.routeName,
          builder: (_, __) => const LastFormScreen(),
        ),
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => const RootTab(),
          routes: [
            GoRoute(
              path: 'tripDetail/:tripId',
              name: TripDetailScreen.routeName,
              builder: (_, __) => const TripDetailScreen(),
            ),
            GoRoute(
              path: 'profile',
              name: MyProfileScreen.routeName,
              builder: (_, __) => const MyProfileScreen(),
            ),
            GoRoute(
              path: 'placeDetail/:placeId',
              name: PlaceDetailScreen.routeName,
              builder: (_, __) => const PlaceDetailScreen(),
            ),
            GoRoute(
              path: 'tripComplete',
              name: TripCompleteScreen.routeName,
              builder: (_, __) => const TripCompleteScreen(),
            ),
            GoRoute(
              path: 'tripForm1',
              name: TripFirstFormScreen.routeName,
              builder: (_, __) => const TripFirstFormScreen(),
              routes: [
                GoRoute(
                  path: 'tripForm2',
                  name: TripSecondFormScreen.routeName,
                  builder: (_, __) => const TripSecondFormScreen(),
                  routes: [
                    GoRoute(
                      path: 'tripForm3',
                      name: TripThirdFormScreen.routeName,
                      builder: (_, __) => const TripThirdFormScreen(),
                      routes: [
                        GoRoute(
                          path: 'tripForm4',
                          name: TripFourthFormScreen.routeName,
                          builder: (_, __) => const TripFourthFormScreen(),
                          routes: [
                            GoRoute(
                              path: 'tripForm5',
                              name: TripFifthFormScreen.routeName,
                              builder: (_, __) => const TripFifthFormScreen(),
                              routes: [
                                GoRoute(
                                  path: 'tripForm6',
                                  name: TripLastFormScreen.routeName,
                                  builder: (_, __) =>
                                      const TripLastFormScreen(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];

  logout() {
    ref.read(userProvider.notifier).logout();
  }

  // 앱을 처음 시작했을 때 토큰 존재 확인
  // 로그인 스크린 or 홈스크린으로 보내줄지 확인하는 과정

  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userProvider);
    final bool timerCompleted = ref.read(splashScreenTimerProvider);
    final logginIn = state.location == '/login';

    if (!timerCompleted) {
      return null;
    }
    //유저 정보가 없을 때 로그인 중이면 로그인 페이지로, 만약 로그인 중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }
    //유저 정보가 있을 때
    if (user is UserModel) {
      //로그인 중이거나, 앱 시작인 경우 회원가입 되어있다면 홈으로, 아니면 회원가입 폼으로
      if (logginIn || state.location == '/splash') {
        return (user.profile != null) ? '/' : '/form1';
      }
      //회원가입 중이라면, 회원가입 완료 되어있다면 홈으로, 아니면 다시 로그인 폼으로
      else if (state.location == '/form1') {
        return (user.profile != null) ? '/' : '/form1';
      } else {
        return null;
      }
    }
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }
    //나머지는 원래 가던곳으로 이동
    return null;
  }
}
