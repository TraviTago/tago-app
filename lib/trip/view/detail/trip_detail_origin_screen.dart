import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/trip/model/trip_detail_origin_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

class TripDetailOriginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'tripDetailOrigin';

  const TripDetailOriginScreen({super.key});

  @override
  ConsumerState<TripDetailOriginScreen> createState() =>
      _TripDetailOriginScreenState();
}

class _TripDetailOriginScreenState
    extends ConsumerState<TripDetailOriginScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String originName =
        GoRouterState.of(context).queryParameters['originName']!;
    String originImgUrl =
        GoRouterState.of(context).queryParameters['originImgUrl']!;
    return DefaultLayout(
      floatingActionButton: MaterialButton(
        onPressed: () {},
        color: PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Text(
            '참여하기',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
      titleComponet: const Text(
        '',
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: ClipRRect(
                child: Image.network(
                  originImgUrl,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: 10.0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  originName,
                  style: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: FutureBuilder<TripDetailOriginModel>(
                future: ref
                    .read(tripRepositoryProvider)
                    .getTagoOriginDeteailTrips(name: originName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(
                        top: 100,
                      ),
                      child: Center(
                          child:
                              CircularProgressIndicator(color: PRIMARY_COLOR)),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('오류: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('데이터가 없습니다.'));
                  } else {
                    final originModel = snapshot.data!;

                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 30,
                          child: Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: originModel.tagotrips.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: (index == 0) ? 0 : 10.0),
                                    child: SizedBox(
                                      width: 80,
                                      height: 30,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            // 선택 상태를 토글
                                            selectedIndex = index;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: selectedIndex == index
                                                ? PRIMARY_COLOR
                                                : LABEL_BG_COLOR,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          child: Text(
                                            DataUtils.formatDate(originModel
                                                .tagotrips[0].dateTime!),
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: selectedIndex == index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: selectedIndex == index
                                                  ? FontWeight.w700
                                                  : FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: LABEL_BG_COLOR,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Center(
                                child: Text(
                                    '현재인원 (${originModel.tagotrips[selectedIndex].currentMember}/${originModel.tagotrips[selectedIndex].maxMember})')),
                          ),
                        ),
                        const Text(
                          "부산에는 많은 바다가 있지만 그 중에서도 다대포만은 특별한 매력을 지니고 있습니다. 낙동강과 남해안이 만나는 이곳은 희고 고운 모래사장으로 유명합니다. 수심이 얕고 수온이 쾌적하여 맨발로 산책하며 바닷가를 즐길 수 있습니다. 특히 해가 지는 시간에는 부산에서 가장 아름다운 낙조를 만날 수 있어요. 바다 앞의 사람들의 검은 실루엣이 마치 하나의 그림 같아요.\n",
                          style: TextStyle(
                            fontSize: 13.0,
                            height: 1.7,
                          ),
                        ),
                        const Text(
                          "이 특별한 순간을 함께 즐기기 좋은 방법 중 하나는 시원한 바닷바람을 맞으며 마시는 따뜻한 커피입니다. 기사님이 준비한 보온병에 담긴 커피를 모래사장에 앉아 나누면서 노을을 감상해보세요.\n",
                          style: TextStyle(
                            fontSize: 13.0,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
