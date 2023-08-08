import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tago_app/common/rotuer/go_router.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() {
  KakaoSdk.init(
    nativeAppKey: 'b92e829b2b66cfaa229d26508ab56230',
  );
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
        fontFamily: 'Inter',
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
