import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/storage/secure_storage.dart';
import 'package:tago_app/signup/model/sign_up_response.dart';
import 'package:tago_app/user/model/user_model.dart';
import 'package:tago_app/user/repository/auth_repository.dart';
import 'package:tago_app/user/repository/user_repository.dart';

final userProvider = StateNotifierProvider<UserStateNotifer, UserModelBase?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final repository = ref.watch(userRepositoryProvier);
    final storage = ref.watch(secureStorageProvider);

    return UserStateNotifer(
      authRepository: authRepository,
      repository: repository,
      storage: storage,
    );
  },
);

class UserStateNotifer extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserStateNotifer({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    //내 정보 가져오기
    // TO FIX
    getMe();
  }

  Future<void> getMe() async {
    // 요청을 보내는 최소 조건은 AccessToken과 RefreshToken이 존재하는 것
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }
    final resp = await repository.getMe();

    state = resp;
  }

  Future<SignUpResponse> signUp({
    required String number,
    required String name,
    required String imgUrl,
    required int ageRange,
    required String gender,
    required String mbti,
    required List<String> favorites,
    required List<String> tripTypes,
  }) async {
    state = UserModelLoading();

    SignUpResponse response = await authRepository.signUp(
      number: number,
      name: name,
      imgUrl: imgUrl,
      ageRange: ageRange,
      gender: gender,
      mbti: mbti,
      favorites: favorites,
      tripTypes: tripTypes,
    );

    await storage.write(
        key: REFRESH_TOKEN_KEY, value: response.tokens.refreshToken);
    await storage.write(
        key: ACCESS_TOKEN_KEY, value: response.tokens.accessToken);

    final userResp = await repository.getMe();
    state = userResp;
    print('회원가입 성공');

    return response;
  }

  // 로그인을 시도했을 때 어떤 상태인지 모르기 때문에 UserModelBase로 상태를 특정한다.
  Future<UserModelBase> login({
    required String number,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
        number: number,
      );

      await storage.write(
          key: REFRESH_TOKEN_KEY, value: resp.tokens.refreshToken);
      await storage.write(
          key: ACCESS_TOKEN_KEY, value: resp.tokens.accessToken);

      // 로그인 후 토큰에 대한 사용자 저장 + 토큰 유효성 검증
      final userResp = await repository.getMe();

      state = userResp;
      print('로그인 성공');
      return userResp;
    } catch (e) {
      print(e);
      print('로그인 실패');

      state = UserModelError();

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    // 가장 먼저 state을 null로 만들어서
    // 로그인 페이지로 보낸다.
    state = null;
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }
}
