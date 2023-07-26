import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLoginModel {
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      // 카카오톡이 설치 되어 있다면
      if (!isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          print(e);
          return false;
        }
      }
      // 카카오톡이 설치 안되어 있다면
      else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (e) {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (e) {
      return false;
    }
  }
}
