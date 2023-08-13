import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tago_app/user/model/social_login_model.dart';
import 'package:tago_app/user/model/user_model.dart';

class KakaoLoginModel implements SocialLogin {
  @override
  Future<UserModelBase> login() async {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      final user = await UserApi.instance.me();

      return UserModel(
        //TO FIX
        oauthProvider: describeEnum(SNSPlatform.KAKAO),
        email: "njs05053@naver.com",
        name: user.kakaoAccount!.profile!.nickname,
        signedUp: false,
      );
    } catch (e) {
      return UserModelError();
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (e) {
      return false;
    }
  }
}
