import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/rotuer/go_router.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tago_app/firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY'],
  );
  final token = await FirebaseMessaging.instance.getToken();

  print("token : ${token ?? 'token NULL!'}");
  initializeDateFormatting().then(
    (_) => runApp(
      const ProviderScope(
        child: _App(),
      ),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        splashColor: LABEL_BG_COLOR,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
