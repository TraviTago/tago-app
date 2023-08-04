import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:tago_app/user/model/social_login_model.dart';

class KakaoLoginModel implements SocialLogin {
  @override
  Future<bool> login() async {
    try {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        return true;
      } catch (e) {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
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
