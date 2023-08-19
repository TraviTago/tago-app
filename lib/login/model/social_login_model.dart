import 'package:tago_app/login/model/kako_login_model.dart';
import 'package:tago_app/user/model/user_model.dart';

abstract class SocialLogin {
  Future<UserModelBase> login();
  Future<bool> logout();
}

extension SNSPlatformExtension on SNSPlatform {
  SocialLogin get loginHandler {
    switch (this) {
      // case SNSPlatform.APPLE:
      //   return AppleSocialLogin();
      case SNSPlatform.KAKAO:
        return KakaoLoginModel();
      default:
        throw Exception('Unsupported SNS Platform');
    }
  }
}
