import 'package:tago_app/user/model/user_model.dart';

abstract class SocialLogin {
  Future<UserModelBase> login();
  Future<bool> logout();
}
