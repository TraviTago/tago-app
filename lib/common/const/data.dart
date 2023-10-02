import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tago_app/common/utils/data_utils.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

final S3URL = dotenv.env['S3URL'];

// localhost
const emulatorIp = '10.0.2.2:8080';
const simulatorIp = '127.0.0.1:8080';

final serverIp = dotenv.env['EC2-IP'];

// final ip = Platform.isIOS ? 'http://$simulatorIp' : 'http://$emulatorIp';

final ip = 'http://$serverIp';

final tripSecondFormBtnText = ['아니요. 타고에서 구할래요!', '네 일행이 있습니다!'];
final tripThirdFormBtnText = [
  ['동성만!', '상관없어요!'],
  ['비슷하게', '상관없어요!'],
  ['좋아요!', '싫어요!'],
];

final List<String> meetPlaces = [
  '부산역 4번출구',
  '서면역 2번출구',
  '해운대역 4번출구',
  '광안역',
];

final Map<String, String> buttonData = {
  '사진촬영': 'photo',
  '맛집탐방': 'food',
  '핫플': 'hot-place',
  '산책': 'walk',
  '미술/예술': 'art',
  '독서': 'book',
  '영화': 'movie',
  '레저/액티비티': 'lesuire',
  '동물': 'animal',
  '자연': 'forest',
  '역사': 'history',
  '전통시장': 'market',
  '바다': 'sea-waves',
  '지역축제': 'fireworks',
  '카페': 'cafe',
  '쇼핑': 'shopping',
};

final Map<int, String> imgUrlData = {
  0: '$S3URL/1.jpg',
  1: '$S3URL/2.jpg',
  2: '$S3URL/3.jpeg',
  3: '$S3URL/4.jpeg',
  4: '$S3URL/5.jpg',
  5: '$S3URL/6.jpg',
  6: '$S3URL/7.jpg',
  7: '$S3URL/8.jpg',
  8: '$S3URL/9.jpg',
  9: '$S3URL/10.jpg',
  10: '$S3URL/11.jpeg',
  11: '$S3URL/12.jpeg',
  12: '$S3URL/13.jpeg',
  13: '$S3URL/14.jpeg',
  14: '$S3URL/15.jpeg',
};

final markerImages = [
  DataUtils.loadAssetAsBase64('asset/img/marker/1.png'),
  DataUtils.loadAssetAsBase64('asset/img/marker/2.png'),
  DataUtils.loadAssetAsBase64('asset/img/marker/3.png'),
  DataUtils.loadAssetAsBase64('asset/img/marker/4.png'),
  DataUtils.loadAssetAsBase64('asset/img/marker/5.png'),
  DataUtils.loadAssetAsBase64('asset/img/marker/6.png'),
  DataUtils.loadAssetAsBase64('asset/img/marker/7.png'),
  DataUtils.loadAssetAsBase64('asset/img/marker/8.png'),
  DataUtils.loadAssetAsBase64('asset/img/marker/9.png'),
];
