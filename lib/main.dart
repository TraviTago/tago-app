import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/view/root_tab.dart';
import 'package:tago_app/common/view/splash_screen.dart';
import 'package:tago_app/form/view/first_form_screen.dart';
import 'package:tago_app/form/view/last_form_screen.dart';
import 'package:tago_app/form/view/second_from_screen.dart';
import 'package:tago_app/form/view/third_form_screen.dart';
import 'package:tago_app/party/view/form/party_fifth_form_screen.dart';
import 'package:tago_app/party/view/form/party_first_form_screen.dart';
import 'package:tago_app/party/view/form/party_fourth_from_screen.dart';
import 'package:tago_app/party/view/form/party_second_form_screen.dart';
import 'package:tago_app/party/view/form/party_third_form_screen.dart';
import 'package:tago_app/user/view/login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(
        ProviderScope(
          child: _App(),
        ),
      ));
}

class _App extends StatelessWidget {
  _App({Key? key}) : super(key: key);

  final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
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
            path: 'partyForm1',
            name: PartyFirstFormScreen.routeName,
            builder: (_, __) => const PartyFirstFormScreen(),
            routes: [
              GoRoute(
                path: 'partyForm2',
                name: PartySecondFormScreen.routeName,
                builder: (_, __) => const PartySecondFormScreen(),
                routes: [
                  GoRoute(
                    path: 'partyForm3',
                    name: PartyThirdFormScreen.routeName,
                    builder: (_, __) => const PartyThirdFormScreen(),
                    routes: [
                      GoRoute(
                          path: 'partyForm4',
                          name: PartyFourthFormScreen.routeName,
                          builder: (_, __) => const PartyFourthFormScreen(),
                          routes: [
                            GoRoute(
                              path: 'partyForm5',
                              name: PartyFifthFormScreen.routeName,
                              builder: (_, __) => const PartyFifthFormScreen(),
                            ),
                          ]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
