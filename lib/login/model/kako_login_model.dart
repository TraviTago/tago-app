import 'package:flutter/foundation.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tago_app/login/model/social_login_model.dart';
import 'package:tago_app/user/model/user_model.dart';

class KakaoLoginModel implements SocialLogin {
  @override
  Future<UserModelBase> login() async {
    try {
      await UserApi.instance.loginWithKakaoAccount();
      final user = await UserApi.instance.me();

      return UserModel(
        oauthProvider: describeEnum(SNSPlatform.KAKAO),
        email: user.kakaoAccount!.email!,
        imgUrl: user.kakaoAccount!.profile!.profileImageUrl,
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
