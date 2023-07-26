import 'dart:io';

import 'package:tago_app/party/model/party_model.dart';

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

PartyModel partyData = PartyModel(
  id: '1',
  name: '낭만적인 밤바다 코스',
  imgUrl: 'https://picsum.photos/id/421/200/200',
  tags: ['해운대', '광안리', '국제시장', '요기저기', '저리저리', '저쪽 저쪽', '룰루랄라'],
  maxNum: 4,
  curNum: 2,
  duration: 270,
  startDate: 1656140400,
);

PartyModel partyCardData = PartyModel(
  id: '1',
  name: '아름다운 숲 코스',
  imgUrl: 'https://picsum.photos/id/28/200/200',
  tags: ['광안리', '해안사', '요기저기', '저쪽 저쪽', '룰루랄라'],
  maxNum: 4,
  curNum: 2,
  duration: 200,
  startDate: 1656140400,
);
