import 'dart:io';

import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/place/model/place_recommend_model.dart';
import 'package:tago_app/place/model/place_summary_model.dart';
import 'package:tago_app/trip/model/trip_model.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
const emulatorIp = '10.0.2.2:8080';
const simulatorIp = '127.0.0.1:8080';

final ip = Platform.isIOS ? 'http://$simulatorIp' : 'http://$emulatorIp';

final tripSecondFormBtnText = ['아니요. 타고에서 구할래요!', '네 일행이 있습니다!'];
final tripThirdFormBtnText = [
  ['동성만!', '상관없어요!'],
  ['비슷하게', '상관없어요!'],
  ['좋아요!', '싫어요!'],
];

final Map<String, String> buttonData = {
  '사진 촬영': 'photo',
  '맛집 탐방': 'food',
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

final Map<int, String> imgUrlData = {
  0: 'profile/1.jpg',
  1: 'profile/2.jpg',
  2: 'profile/3.jpeg',
  3: 'profile/4.jpeg',
  4: 'profile/5.jpg',
  5: 'profile/6.jpg',
  6: 'profile/7.jpg',
  7: 'profile/8.jpg',
  8: 'profile/9.jpg',
  9: 'profile/10.jpg',
  10: 'profile/11.jpeg',
  11: 'profile/12.jpeg',
  12: 'profile/13.jpeg',
  13: 'profile/14.jpeg',
  14: 'profile/15.jpeg',
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

TripModel tripData = TripModel(
  tripId: 1,
  name: '낭만적인 밤바다 코스',
  imageUrl: 'https://picsum.photos/id/421/200/200',
  places: ['해운대', '광안리', '국제시장', '요기저기', '저리저리', '저쪽 저쪽', '룰루랄라'],
  maxMember: 4,
  currentMember: 2,
  totalTime: 8,
  dateTime: DateTime.parse('2023-06-09 01:30:00'),
);

TripModel tripCardData = TripModel(
  tripId: 2,
  name: '아름다운 숲 코스',
  imageUrl: 'https://picsum.photos/id/28/200/200',
  places: ['광안리', '해안사', '요기저기', '저쪽 저쪽', '룰루랄라'],
  maxMember: 4,
  currentMember: 2,
  totalTime: 8,
  dateTime: DateTime.parse('2023-06-10 01:30:00'),
);

List<TripModel> tripDataList = [
  TripModel(
    tripId: 1,
    name: '낭만적인 밤바다 코스',
    imageUrl: 'https://picsum.photos/id/421/200/200',
    places: ['해운대', '광안리', '국제시장', '요기저기', '저리저리', '저쪽 저쪽', '룰루랄라'],
    maxMember: 4,
    currentMember: 2,
    totalTime: 8,
    dateTime: DateTime.parse('2023-06-09 01:30:00'),
  ),
  TripModel(
    tripId: 2,
    name: '아름다운 숲 코스',
    imageUrl: 'https://picsum.photos/id/28/200/200',
    places: ['광안리', '해안사', '요기저기', '저쪽 저쪽', '룰루랄라'],
    maxMember: 4,
    currentMember: 2,
    totalTime: 8,
    dateTime: DateTime.parse('2023-06-10 01:30:00'),
  )
];

List<PlaceRecommendModel> placeList = [
  PlaceRecommendModel(
    id: 3,
    address: '부산광역시 해운대구 구남로 28',
    title: '밀양순대돼지국밥',
    overview:
        '24시간 연중무휴로 운영되는 밀양순대돼지국밥은 14년여를 오로지 돼지국밥만 연구해 온 맛집이다. 순수 국내산 돼지뼈 사골을 48시간 이상 고아 낸 진하고 뽀얀 국물에 고기와 파를 넣어 뚝배기에 나오는데, 국물 맛이 깔끔하고 담백하다. 미리 나온 부추와 소면을 넣고 새우젓과 양념장을 풀어 넣어 밥과 함께 먹으면 배 속이 든든해진다. 국밥 안에 들어 있는 쫀득하게 씹히는 고기는 잡내 없이 깨끗한 맛이라 처음 돼지국밥을 접하는 사람도 거부감 없이 즐길 수 있다. 돼지국밥 외에도 순대국밥, 섞어국밥, 내장국밥, 모둠국밥 등 입맛에 따라 선택하여 주문할 수 있으며, 감자탕, 뼈해장국도 진한 맛이 일품이다.',
    imageUrl:
        'http://tong.visitkorea.or.kr/cms/resource/91/2798191_image2_1.JPG',
  ),
  PlaceRecommendModel(
    id: 2,
    title: "몰운대 (부산 국가지질공원)",
    address: "부산광역시 사하구 다대동",
    overview:
        '* 부산 대표 해수욕장, 해운대해수욕장<br /><br />부산의 대표 해수욕장인 해운대해수욕장. 백사장의 길이 1.5km, 너비 30~50m, 평균수심 1m, 면적 58,400㎥의 규모로 넓은 백사장과 아름다운 해안선을 자랑하고 있으며 얕은 수심과 잔잔한 물결로 해수욕장의 최적 조건을 갖추고 있다."부산" 하면 제일 먼저 떠올리는 곳이 해운대 해수욕장이라고 할 만큼 부산을 대표하는 명소이며, 해마다 여름철 피서객을 가늠하는 척도로 이용될 만큼 국내 최대 인파가 몰리는 곳이기도 하다. 특히, 해안선 주변에 크고 작은 빌딩들과 고급 호텔들이 우뚝 솟아있어 현대적이고 세련된 분위기의 해수욕장으로 유명하기 때문에 여름 휴가철뿐만 아니라 사시사철 젊은 열기로 붐비고 해외 관광객들에게도 잘 알려져 있어 외국인들이 많이 찾는 곳이다.<br /><br />* 해운대해수욕장의 다양한 축제와 즐길거리<br /><br />해운대해수욕장에서는 매년 정월 대보름날의 달맞이 축제를 진행하고 있다. 또한, 매년 겨울 주최하고 있는 북극곰수영대회는 이미 겨울철 대표 축제로 자리잡았다. 이외에도 모래 작품전, 부산 바다 축제 등 각종 크고 작은 행사들이 열리고 있다. 또한, 해수욕장 주변에 동백섬, 오륙도, 아쿠아리움 , 요트경기장, 벡스코 달맞이고개, 드라이브코스 등 볼거리가 많으며, 국내 1급 해수욕장답게 주변에는 일급 호텔을 비롯한 숙박, 오락시설 및 유흥 시설들이 잘 정비되어 있어 편안한 휴식을 즐길 수 있다.',
    imageUrl:
        "http://tong.visitkorea.or.kr/cms/resource/95/2675495_image2_1.jpg",
  ),
  PlaceRecommendModel(
    id: 1,
    title: "맥도상태공원",
    address: "부산광역시 강서구 공항로 500",
    overview:
        '* 부산 대표 해수욕장, 해운대해수욕장<br /><br />부산의 대표 해수욕장인 해운대해수욕장. 백사장의 길이 1.5km, 너비 30~50m, 평균수심 1m, 면적 58,400㎥의 규모로 넓은 백사장과 아름다운 해안선을 자랑하고 있으며 얕은 수심과 잔잔한 물결로 해수욕장의 최적 조건을 갖추고 있다."부산" 하면 제일 먼저 떠올리는 곳이 해운대 해수욕장이라고 할 만큼 부산을 대표하는 명소이며, 해마다 여름철 피서객을 가늠하는 척도로 이용될 만큼 국내 최대 인파가 몰리는 곳이기도 하다. 특히, 해안선 주변에 크고 작은 빌딩들과 고급 호텔들이 우뚝 솟아있어 현대적이고 세련된 분위기의 해수욕장으로 유명하기 때문에 여름 휴가철뿐만 아니라 사시사철 젊은 열기로 붐비고 해외 관광객들에게도 잘 알려져 있어 외국인들이 많이 찾는 곳이다.<br /><br />* 해운대해수욕장의 다양한 축제와 즐길거리<br /><br />해운대해수욕장에서는 매년 정월 대보름날의 달맞이 축제를 진행하고 있다. 또한, 매년 겨울 주최하고 있는 북극곰수영대회는 이미 겨울철 대표 축제로 자리잡았다. 이외에도 모래 작품전, 부산 바다 축제 등 각종 크고 작은 행사들이 열리고 있다. 또한, 해수욕장 주변에 동백섬, 오륙도, 아쿠아리움 , 요트경기장, 벡스코 달맞이고개, 드라이브코스 등 볼거리가 많으며, 국내 1급 해수욕장답게 주변에는 일급 호텔을 비롯한 숙박, 오락시설 및 유흥 시설들이 잘 정비되어 있어 편안한 휴식을 즐길 수 있다.',
    imageUrl:
        "http://tong.visitkorea.or.kr/cms/resource/23/2488023_image2_1.JPG",
  ),
];

List<PlaceSummaryModel> placeListSummary = [
  PlaceSummaryModel(
    id: 3,
    address: '부산광역시 해운대구 구남로 28',
    title: '밀양순대돼지국밥',
    imageUrl:
        'http://tong.visitkorea.or.kr/cms/resource/91/2798191_image2_1.JPG',
  ),
  PlaceSummaryModel(
    id: 2,
    title: "몰운대 (부산 국가지질공원)",
    address: "부산광역시 사하구 다대동",
    imageUrl:
        "http://tong.visitkorea.or.kr/cms/resource/95/2675495_image2_1.jpg",
  ),
  PlaceSummaryModel(
    id: 1,
    title: "맥도상태공원",
    address: "부산광역시 강서구 공항로 500",
    imageUrl:
        "http://tong.visitkorea.or.kr/cms/resource/23/2488023_image2_1.JPG",
  ),
];
