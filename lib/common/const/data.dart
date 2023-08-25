import 'dart:io';

import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/place/model/place_detail_model.dart';
import 'package:tago_app/trip/model/trip_detail_model.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/place/model/place_model.dart';

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

TripDetailModel tripDetailData = TripDetailModel(
  tripName: '낭만적인 밤바다 코스',
  maxCnt: 4,
  currentCnt: 2,
  places: [
    PlaceModel(
      id: 126081,
      title: '해운대해수욕장',
      overview:
          '* 부산 대표 해수욕장, 해운대해수욕장<br /><br />부산의 대표 해수욕장인 해운대해수욕장. 백사장의 길이 1.5km, 너비 30~50m, 평균수심 1m, 면적 58,400㎥의 규모로 넓은 백사장과 아름다운 해안선을 자랑하고 있으며 얕은 수심과 잔잔한 물결로 해수욕장의 최적 조건을 갖추고 있다."부산" 하면 제일 먼저 떠올리는 곳이 해운대 해수욕장이라고 할 만큼 부산을 대표하는 명소이며, 해마다 여름철 피서객을 가늠하는 척도로 이용될 만큼 국내 최대 인파가 몰리는 곳이기도 하다. 특히, 해안선 주변에 크고 작은 빌딩들과 고급 호텔들이 우뚝 솟아있어 현대적이고 세련된 분위기의 해수욕장으로 유명하기 때문에 여름 휴가철뿐만 아니라 사시사철 젊은 열기로 붐비고 해외 관광객들에게도 잘 알려져 있어 외국인들이 많이 찾는 곳이다.<br /><br />* 해운대해수욕장의 다양한 축제와 즐길거리<br /><br />해운대해수욕장에서는 매년 정월 대보름날의 달맞이 축제를 진행하고 있다. 또한, 매년 겨울 주최하고 있는 북극곰수영대회는 이미 겨울철 대표 축제로 자리잡았다. 이외에도 모래 작품전, 부산 바다 축제 등 각종 크고 작은 행사들이 열리고 있다. 또한, 해수욕장 주변에 동백섬, 오륙도, 아쿠아리움 , 요트경기장, 벡스코 달맞이고개, 드라이브코스 등 볼거리가 많으며, 국내 1급 해수욕장답게 주변에는 일급 호텔을 비롯한 숙박, 오락시설 및 유흥 시설들이 잘 정비되어 있어 편안한 휴식을 즐길 수 있다.',
      imageUrl:
          'http://tong.visitkorea.or.kr/cms/resource/67/2612467_image2_1.jpg',
      mapX: 129.1603078991,
      mapY: 35.1591243474,
    ),
    PlaceModel(
      id: 126078,
      title: '광안리해수욕장',
      overview:
          '광안리해수욕장은 부산광역시 수영구 광안2동에 있으며 해운대 해수욕장의 서쪽에 위치하고 있다. 총면적 82,000㎡, 길이 1.4km, 사장폭은 25~110m의 질 좋은 모래사장이 있고, 지속적인 수질 정화를 실시하여 인근의 수영강에 다시 고기가 살 수 있을 정도로 깨끗한 수질을 자랑하며, 특히 젊은이들이 즐겨 찾는 명소이다. 광안리에서는 해수욕뿐 아니라 독특한 분위기를 자아내는 레스토랑, 카페 등과 시내 중심가 못지않은 유명 패션상가들이 즐비하며, 다양한 먹을거리, 볼거리가 있어서 피서의 즐거움을 더해준다. 특히 밤이 되면 광안대교의 아름다운 야경이 장관이다.<br>해수욕장 주변에는 낭만이 깃든 카페거리와 300여 곳의 횟집이 있고 야외무대가 설치되어 있어서 부산 바다축제를 비롯한 다양한 축제가 개최되고 있으며, 해변을 찾는 피서객을 위한 공연도 있다. 인근의 수영강에서는 낚시를 할 수도 있고, 싱싱한 회를 즉석에서 맛볼 수도 있으며 올림픽 요트 경기장이 있어서 요트를 탈 수도 있다. 숙박시설도 잘 갖추어져 있다. 해변과 인접해 있는 호텔을 이용해도 되고 알뜰한 피서를 원한다면 인근 금련산에 소재한 청소년수련원를 이용하면 된다. 이곳에는 텐트 설치가 가능하며 숙박동도 대여해 주고 취사시설도 완비되어 있다. 해수욕장 인근에는 다양한 문화시설들이 있는데 남천해변의 자유바다를 비롯하여 KBS, MBC 방송국이 있으며, MBC 내에는 개봉관인 시네마홀 극장도 있다. 피서철에는 다양한 축제가 열리므로 피서객들에게 즐길 수 있는 문화공간도 제공한다.<br /><br />광안리해변에는 100여 개의 카페가 있다. 음악과 칵테일과 낭만이 깃든 카페에서 바라보는 해수욕장과 광안대교는 아름답기 그지없다. 광안대교에서 이곳을 바라보면 마치 동화 속 유럽의 한 도시를 여행하고 있는 듯한 착각을 할 만큼 예쁘게 꾸며져 있다. 광안리 해수욕장과 인접해 있어 가족단위나 친구·연인과의 만남을 위한 장소이기도 하다. 또한 이곳에서는 음식과 술뿐만 아니라 야외음악도 감상할 수 있다.<br>',
      imageUrl:
          'http://tong.visitkorea.or.kr/cms/resource/75/2648975_image2_1.jpg',
      mapX: 129.1184922375,
      mapY: 35.1537908369,
    ),
  ],
);

PlaceDetailModel placeDetailModel = PlaceDetailModel(
  id: 126081,
  title: '해운대해수욕장',
  imageUrl: 'http://tong.visitkorea.or.kr/cms/resource/67/2612467_image2_1.jpg',
  mapX: 129.1603078991,
  mapY: 35.1591243474,
  overview:
      '* 부산 대표 해수욕장, 해운대해수욕장<br /><br />부산의 대표 해수욕장인 해운대해수욕장. 백사장의 길이 1.5km, 너비 30~50m, 평균수심 1m, 면적 58,400㎥의 규모로 넓은 백사장과 아름다운 해안선을 자랑하고 있으며 얕은 수심과 잔잔한 물결로 해수욕장의 최적 조건을 갖추고 있다."부산" 하면 제일 먼저 떠올리는 곳이 해운대 해수욕장이라고 할 만큼 부산을 대표하는 명소이며, 해마다 여름철 피서객을 가늠하는 척도로 이용될 만큼 국내 최대 인파가 몰리는 곳이기도 하다. 특히, 해안선 주변에 크고 작은 빌딩들과 고급 호텔들이 우뚝 솟아있어 현대적이고 세련된 분위기의 해수욕장으로 유명하기 때문에 여름 휴가철뿐만 아니라 사시사철 젊은 열기로 붐비고 해외 관광객들에게도 잘 알려져 있어 외국인들이 많이 찾는 곳이다.<br /><br />* 해운대해수욕장의 다양한 축제와 즐길거리<br /><br />해운대해수욕장에서는 매년 정월 대보름날의 달맞이 축제를 진행하고 있다. 또한, 매년 겨울 주최하고 있는 북극곰수영대회는 이미 겨울철 대표 축제로 자리잡았다. 이외에도 모래 작품전, 부산 바다 축제 등 각종 크고 작은 행사들이 열리고 있다. 또한, 해수욕장 주변에 동백섬, 오륙도, 아쿠아리움 , 요트경기장, 벡스코 달맞이고개, 드라이브코스 등 볼거리가 많으며, 국내 1급 해수욕장답게 주변에는 일급 호텔을 비롯한 숙박, 오락시설 및 유흥 시설들이 잘 정비되어 있어 편안한 휴식을 즐길 수 있다.',
  address: '부산시 해운대구 해운대로 123',
  homepage:
      "<a title=새창 : 목장원 홈페이지로 이동\" href=\"http://www.mokjangwon.co.kr\" target=\"_blank\">http://www.mokjangwon.co.kr</a>",
  telephone: "051-404-5000",
  restDate: "명절 전날 및 당일",
  openTime: "11:30 ~ 21:30",
  parking: "주차가능(공용주차장)",
);

PlaceDetailModel gwanganriDetail = PlaceDetailModel(
  id: 126078,
  title: '광안리해수욕장',
  imageUrl: 'http://tong.visitkorea.or.kr/cms/resource/75/2648975_image2_1.jpg',
  mapX: 129.1184922375,
  mapY: 35.1537908369,
  overview:
      '광안리해수욕장은 부산광역시 수영구 광안2동에 있으며 해운대 해수욕장의 서쪽에 위치하고 있다. 총면적 82,000㎡, 길이 1.4km, 사장폭은 25~110m의 질 좋은 모래사장이 있고, 지속적인 수질 정화를 실시하여 인근의 수영강에 다시 고기가 살 수 있을 정도로 깨끗한 수질을 자랑하며, 특히 젊은이들이 즐겨 찾는 명소이다. 광안리에서는 해수욕뿐 아니라 독특한 분위기를 자아내는 레스토랑, 카페 등과 시내 중심가 못지않은 유명 패션상가들이 즐비하며, 다양한 먹을거리, 볼거리가 있어서 피서의 즐거움을 더해준다. 특히 밤이 되면 광안대교의 아름다운 야경이 장관이다.<br>해수욕장 주변에는 낭만이 깃든 카페거리와 300여 곳의 횟집이 있고 야외무대가 설치되어 있어서 부산 바다축제를 비롯한 다양한 축제가 개최되고 있으며, 해변을 찾는 피서객을 위한 공연도 있다. 인근의 수영강에서는 낚시를 할 수도 있고, 싱싱한 회를 즉석에서 맛볼 수도 있으며 올림픽 요트 경기장이 있어서 요트를 탈 수도 있다. 숙박시설도 잘 갖추어져 있다. 해변과 인접해 있는 호텔을 이용해도 되고 알뜰한 피서를 원한다면 인근 금련산에 소재한 청소년수련원를 이용하면 된다. 이곳에는 텐트 설치가 가능하며 숙박동도 대여해 주고 취사시설도 완비되어 있다. 해수욕장 인근에는 다양한 문화시설들이 있는데 남천해변의 자유바다를 비롯하여 KBS, MBC 방송국이 있으며, MBC 내에는 개봉관인 시네마홀 극장도 있다. 피서철에는 다양한 축제가 열리므로 피서객들에게 즐길 수 있는 문화공간도 제공한다.<br /><br />광안리해변에는 100여 개의 카페가 있다. 음악과 칵테일과 낭만이 깃든 카페에서 바라보는 해수욕장과 광안대교는 아름답기 그지없다. 광안대교에서 이곳을 바라보면 마치 동화 속 유럽의 한 도시를 여행하고 있는 듯한 착각을 할 만큼 예쁘게 꾸며져 있다. 광안리 해수욕장과 인접해 있어 가족단위나 친구·연인과의 만남을 위한 장소이기도 하다. 또한 이곳에서는 음식과 술뿐만 아니라 야외음악도 감상할 수 있다.<br>',
  address: '부산시 수영구 광안로 456',
);
