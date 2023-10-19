import 'package:cached_network_image/cached_network_image.dart';
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
  int? selectedTripId;
  DateTime? selectedTripDate;
  String? source;

  @override
  void initState() {
    super.initState();
  }

  void _updateSelectedTripId(int index, TripDetailOriginModel model) {
    setState(() {
      selectedIndex = index;
      selectedTripId = model.tagotrips[selectedIndex].id!;
      selectedTripDate = model.tagotrips[selectedIndex].dateTime!;
    });
  }

  @override
  Widget build(BuildContext context) {
    String originName =
        GoRouterState.of(context).queryParameters['originName']!;
    String originImgUrl =
        GoRouterState.of(context).queryParameters['originImgUrl']!;
    String originSource =
        GoRouterState.of(context).queryParameters['originSource']!;
    int heroKey =
        int.parse(GoRouterState.of(context).queryParameters['heroKey']!);

    return DefaultLayout(
      titleComponet: const Text(
        '',
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Hero(
                tag: ObjectKey(heroKey),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: originImgUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  textAlign: TextAlign.end,
                  '출처 $originSource',
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: LABEL_TEXT_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 5.0,
                bottom: 20.0,
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
                    selectedTripId = originModel.tagotrips[selectedIndex].id!;
                    selectedTripDate =
                        originModel.tagotrips[selectedIndex].dateTime!;
                    return Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 30,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: originModel.tagotrips.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: SizedBox(
                                    width: 80,
                                    height: 30,
                                    child: GestureDetector(
                                      onTap: () {
                                        _updateSelectedTripId(
                                            index, originModel);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: selectedIndex == index
                                              ? PRIMARY_COLOR
                                              : LABEL_BG_COLOR,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          DataUtils.formatDate(originModel
                                              .tagotrips[index].dateTime!),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  '현재인원 ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Text(
                                  '(',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${originModel.tagotrips[selectedIndex].currentMember}',
                                  style: const TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '/${originModel.tagotrips[selectedIndex].maxMember})',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          originModel.overview,
                          style: const TextStyle(
                            fontSize: 13.0,
                            height: 1.8,
                            color: LABEL_TEXT_SUB_COLOR,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          onPressed: () {
                            context.push(
                                "/tripDetail/$selectedTripId?tripDate=$selectedTripDate&tripTime=480");
                          },
                          color: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '코스 세부 내용 보러가기',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right_sharp,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
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
