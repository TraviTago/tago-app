import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
const emulatorIp = '10.0.2.2:3000';
const simulatorIp = '127.0.0.1:3000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;

final Map<String, String> buttonData = {
  '인스타그램': 'instagram',
  '유튜브': 'youtube',
  '사진촬영': 'photo',
  '맛집탐방': 'food',
  '핫플': 'hot-place',
  '산책': 'walk',
  '미술 / 예술': 'art',
  '독서': 'book',
  '영화': 'movie',
  '레저 / 엑티비티': 'lesuire',
  '동물': 'animal',
  '자연': 'forest',
  '역사': 'history',
  '전통시장': 'market',
  '바다': 'sea-waves',
  '지역축제': 'fireworks',
  '커피': 'cafe',
  '쇼핑': 'shopping',
};
