import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/shimmer_box.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/model/trip_driver_info_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

class TripDetailDriversScreen extends ConsumerWidget {
  static String get routeName => 'tripDetailDriver';

  const TripDetailDriversScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int tripId = int.parse(GoRouterState.of(context).pathParameters['tripId']!);
    return FutureBuilder<TripDriverInfoModel>(
        future: ref.watch(tripRepositoryProvider).getDriverTrip(tripId: tripId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DefaultLayout(
              child: Center(
                child: CircularProgressIndicator(color: PRIMARY_COLOR),
              ),
            );
          }

          final driver = snapshot.data as TripDriverInfoModel;
          return DefaultLayout(
            titleCompnentWithPrimaryColor: const Padding(
              padding: EdgeInsets.only(left: 0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  '기사님 정보',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 15.0,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AspectRatio(
                              aspectRatio: 0.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      const ShimmerBox(
                                          width: 90.0, height: 90.0),
                                  imageUrl: driver.img_url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30.0, bottom: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${driver.name} 기사님',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const Text(
                                    '안녕하세요\n부산시가 선정한 부산 관광택시\n운전자 100인 중 한 명으로\n인증된 기사 손재익 입니다.',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      height: 1.4,
                                      color: LABEL_TEXT_SUB_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    InfoRow(
                      label: '휴대폰번호',
                      value: driver.phone_number,
                      border: true,
                    ),
                    InfoRow(
                      label: '경력',
                      value: driver.licence,
                      border: true,
                    ),
                    InfoRow(
                      label: '보유 차량',
                      value: '${driver.seater.toString()}인승 택시',
                      border: true,
                    ),
                    InfoRow(
                      label: '차량번호',
                      value: driver.car_number,
                      border: false,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: LABEL_BG_COLOR,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.0,
                          horizontal: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '손님이 ',
                                  style: TextStyle(
                                    height: 1.7,
                                  ),
                                ),
                                Text(
                                  '가고싶은 곳을 맘대로 골라',
                                  style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    height: 1.7,
                                  ),
                                ),
                                Text(
                                  '가는 재미!',
                                  style: TextStyle(
                                    height: 1.7,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '버스나 개인 차량으로 가기 어려운 곳들도',
                              style: TextStyle(
                                height: 1.7,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '구석구석',
                                  style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    height: 1.7,
                                  ),
                                ),
                                Text(
                                  '함께합니다.',
                                  style: TextStyle(
                                    height: 1.7,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              '믿음직한 기사님과 함께 부산을 다녀보세요.',
                              style: TextStyle(
                                height: 1.7,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool border;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: border ? LABEL_BG_COLOR : Colors.white,
            width: 2.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                label,
                style: const TextStyle(
                  color: LABEL_TEXT_SUB_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                ),
              ),
            ),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
