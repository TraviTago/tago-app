import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/storage/secure_storage.dart';
import 'package:tago_app/common/view/chatting_screen.dart';
import 'package:tago_app/common/view/driver/driver_root_tab.dart';
import 'package:tago_app/common/view/landing_screen.dart';
import 'package:tago_app/common/view/root_tab.dart';
import 'package:tago_app/common/view/splash_screen.dart';
import 'package:tago_app/common/view/tutorial_landing_screen.dart';
import 'package:tago_app/common/view/tutorial_screen.dart';
import 'package:tago_app/customer_service/view/customer_service_center_screen.dart';
import 'package:tago_app/customer_service/view/customer_service_report_screen.dart';
import 'package:tago_app/login/view/driver_login_screen.dart';
import 'package:tago_app/login/view/signup_screen.dart';
import 'package:tago_app/place/view/place_detail_screen.dart';
import 'package:tago_app/place/view/place_search_screen.dart';
import 'package:tago_app/signup/view/profile_image_select_screen.dart';
import 'package:tago_app/signup/view/profile_signup_screen.dart';
import 'package:tago_app/trip/model/trip_edit_model.dart';
import 'package:tago_app/trip/view/detail/trip_detail_driver_screen.dart';
import 'package:tago_app/trip/view/detail/trip_detail_members_screen.dart';
import 'package:tago_app/trip/view/detail/trip_detail_origin_screen.dart';
import 'package:tago_app/trip/view/detail/trip_detail_screen.dart';
import 'package:tago_app/trip/view/driver/trip_detail_driver_members_screen.dart';
import 'package:tago_app/trip/view/driver/trip_detail_driver_tab_screen.dart';
import 'package:tago_app/trip/view/form/trip_complete_screen.dart';
import 'package:tago_app/trip/view/detail/trip_edit_screen.dart';
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
import 'package:tago_app/user/model/driver_user_model.dart';
import 'package:tago_app/user/model/user_model.dart';
import 'package:tago_app/user/provider/user_provider.dart';
import 'package:tago_app/login/view/login_screen.dart';
import 'package:tago_app/user/view/my_profile_screen.dart';
import 'package:tago_app/user/view/withdraw_screen.dart';

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
          path: '/landing',
          name: LandingScreen.routeName,
          builder: (_, __) => const LandingScreen(),
        ),
        GoRoute(
          path: '/withdraw',
          name: WithdrawScreen.routeName,
          builder: (_, __) => const WithdrawScreen(),
        ),
        GoRoute(
          path: '/chatting',
          name: ChattingScreen.routeName,
          builder: (_, __) => const ChattingScreen(),
        ),
        GoRoute(
          path: '/tutorialLanding',
          name: TutorialLandingScreen.routeName,
          builder: (_, __) => const TutorialLandingScreen(),
        ),
        GoRoute(
          path: '/tutorial',
          name: TutorialScreen.routeName,
          builder: (_, __) => const TutorialScreen(),
        ),
        GoRoute(
          path: '/driverLogin',
          name: DriverLoginScreen.routeName,
          builder: (_, __) => const DriverLoginScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          name: SignupScreen.routeName,
          builder: (_, __) => const SignupScreen(),
        ),
        GoRoute(
          path: '/signup2',
          name: ProfileSignupScreen.routeName,
          builder: (_, __) => const ProfileSignupScreen(),
        ),
        GoRoute(
          path: '/imageSelect',
          name: ProfileImageSelectScreen.routeName,
          builder: (_, __) => const ProfileImageSelectScreen(),
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
          path: '/driver',
          name: DriverRootTab.routeName,
          builder: (_, __) => const DriverRootTab(),
          routes: [
            GoRoute(
              path: 'tripDetailTabDriver/:tripId',
              name: TripDetailDriverTabScreen.routeName,
              builder: (_, __) => const TripDetailDriverTabScreen(),
              routes: [
                GoRoute(
                  path: 'driverMembers',
                  name: TripDetailDriverMembersScreen.routeName,
                  builder: (_, __) => const TripDetailDriverMembersScreen(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => const RootTab(),
          routes: [
            GoRoute(
              path: 'tripDetailOrigin',
              name: TripDetailOriginScreen.routeName,
              builder: (_, __) => const TripDetailOriginScreen(),
            ),
            GoRoute(
                path: 'tripDetail/:tripId',
                name: TripDetailScreen.routeName,
                builder: (_, __) => const TripDetailScreen(),
                routes: [
                  GoRoute(
                    path: 'members',
                    name: TripDetailMembersScreen.routeName,
                    builder: (_, __) => const TripDetailMembersScreen(),
                  ),
                  GoRoute(
                    path: 'driver',
                    name: TripDetailDriversScreen.routeName,
                    builder: (_, __) => const TripDetailDriversScreen(),
                  ),
                ]),
            GoRoute(
              path: 'profile',
              name: MyProfileScreen.routeName,
              builder: (_, __) => const MyProfileScreen(),
            ),
            GoRoute(
              path: 'customerCenter',
              name: CustomerServiceCenterScreen.routeName,
              builder: (_, __) => const CustomerServiceCenterScreen(),
            ),
            GoRoute(
              path: 'customerReport',
              name: CustomerServiceReportScreen.routeName,
              builder: (_, __) => const CustomerServiceReportScreen(),
            ),
            GoRoute(
              path: 'placeDetail/:placeId',
              name: PlaceDetailScreen.routeName,
              builder: (_, __) => const PlaceDetailScreen(),
            ),
            GoRoute(
              path: 'places',
              name: PlaceSearchScreen.routeName,
              builder: (_, __) => const PlaceSearchScreen(),
            ),
            GoRoute(
              path: 'tripComplete',
              name: TripCompleteScreen.routeName,
              builder: (_, __) => const TripCompleteScreen(),
            ),
            GoRoute(
              path: 'tripEdit',
              name: TripEditScreen.routeName,
              builder: (_, state) {
                final editModel = state.extra as TripEditModel;
                return TripEditScreen(editModel: editModel);
              },
            ),
            GoRoute(
              path: 'tripForm1',
              name: TripFirstFormScreen.routeName,
              builder: (_, __) => const TripFirstFormScreen(),
            ),
            GoRoute(
              path: 'tripForm2',
              name: TripSecondFormScreen.routeName,
              builder: (_, __) => const TripSecondFormScreen(),
            ),
            GoRoute(
              path: 'tripForm3',
              name: TripThirdFormScreen.routeName,
              builder: (_, __) => const TripThirdFormScreen(),
            ),
            GoRoute(
              path: 'tripForm4',
              name: TripFourthFormScreen.routeName,
              builder: (_, __) => const TripFourthFormScreen(),
            ),
            GoRoute(
              path: 'tripForm5',
              name: TripFifthFormScreen.routeName,
              builder: (_, __) => const TripFifthFormScreen(),
            ),
            GoRoute(
              path: 'tripForm6',
              name: TripLastFormScreen.routeName,
              builder: (_, __) => const TripLastFormScreen(),
            ),
          ],
        ),
      ];

  logout() {
    ref.read(userProvider.notifier).logout();
  }

  withdraw() {
    ref.read(userProvider.notifier).withdraw();
  }
  // 앱을 처음 시작했을 때 토큰 존재 확인
  // 로그인 스크린 or 홈스크린으로 보내줄지 확인하는 과정

  String? redirectLogic(GoRouterState state) {
    final UserModelBase? user = ref.read(userProvider);
    final bool timerCompleted = ref.read(splashScreenTimerProvider);

    final landing = state.location == '/landing';
    final logginIn = state.location == '/login';
    final driverLogginIn = state.location == '/driverLogin';
    final signingUp = state.location == '/signup' ||
        Uri.parse(state.location).path == '/signup2';

    final profileForm = Uri.parse(state.location).path == '/form1' ||
        Uri.parse(state.location).path == '/form2' ||
        Uri.parse(state.location).path == '/form3' ||
        Uri.parse(state.location).path == '/imageSelect' ||
        Uri.parse(state.location).path == '/form4';
    final splash = state.location == '/splash';

    if (!timerCompleted) {
      return null;
    }
    //유저 정보가 없을 때 로그인 중이면 로그인 페이지로, 만약 로그인 중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn || landing || signingUp || profileForm || driverLogginIn
          ? null
          : '/landing';
    }

    if (user is DriverUserModel) {
      if (landing || logginIn || signingUp || splash || state.location == '/') {
        return '/driver';
      }
    }
    //유저 정보가 있을 때
    if (user is UserModel) {
      if (landing && user.number == "010-1111-1111") {
        if (user.isTutorial == false) {
          return '/tutorialLanding';
        } else {
          return '/';
        }
      }
      if (landing ||
          logginIn ||
          signingUp ||
          splash ||
          state.location == 'form4') {
        return '/';
      }
    }

    //나머지는 원래 가던곳으로 이동
    return null;
  }
}
