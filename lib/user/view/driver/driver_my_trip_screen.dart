import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/component/trip_recommend_card.dart';
import 'package:tago_app/trip/model/trip_response_model.dart';
import 'package:tago_app/trip/model/trip_model.dart';
import 'package:tago_app/trip/provider/trip_me_provider.dart';

class DriverMyTripScreen extends ConsumerWidget {
  const DriverMyTripScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime now = DateTime.now();

    return DefaultLayout(
      titleComponetWithoutPop: const Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            '내여행',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
      ),
      child: FutureBuilder<MyTripResponseModel?>(
        future: ref.watch(tripMeProvider.notifier).getMyTrip(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: PRIMARY_COLOR),
            ); // show loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.trips.isEmpty) {
            return const EmptyTripsComponent();
          } else {
            List<TripModel> myTripList = snapshot.data!.trips;
            List upcomingTrips = [];
            List pastTrips = [];

            for (var trip in myTripList) {
              if (trip.dateTime.isBefore(now)) {
                pastTrips.add(trip);
              } else {
                upcomingTrips.add(trip);
              }
            }
            pastTrips.sort((a, b) => b.dateTime.compareTo(a.dateTime));

            return (upcomingTrips.isEmpty && pastTrips.isEmpty)
                ? const EmptyTripsComponent()
                : TripsListComponent(
                    upcomingTrips: upcomingTrips, pastTrips: pastTrips);
          }
        },
      ),
    );
  }
}

class EmptyTripsComponent extends StatelessWidget {
  const EmptyTripsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/frown.png',
                width: 35,
                height: 35,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                '아직 타고랑 같이\n여행한 적이 없으시네요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: (MediaQuery.of(context).size.width / 3 * 2) - 50,
          child: Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    '여행 보러 가기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: CustomPaint(
                    size: const Size(15, 10),
                    painter: TrianglePainter(),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class TripsListComponent extends StatelessWidget {
  final List upcomingTrips;
  final List pastTrips;

  const TripsListComponent(
      {super.key, required this.upcomingTrips, required this.pastTrips});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (upcomingTrips.isNotEmpty) ...[
                const Text(
                  '예정된 여행',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  '곧 여행을 떠나실 예정이군요!',
                  style: TextStyle(
                    color: LABEL_TEXT_SUB_COLOR,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ...upcomingTrips.asMap().entries.map((entry) {
                  int index = entry.key;
                  var trip = entry.value;

                  return Column(
                    children: [
                      TripRecommendCard.fromModel(
                        type: "DRIVER",
                        model: trip,
                      ),
                      if (index == upcomingTrips.length - 1) ...[
                        if (pastTrips.isNotEmpty) ...[
                          const SizedBox(height: 30.0),
                          const Divider(
                            color: LABEL_BG_COLOR,
                            thickness: 2.0,
                          ),
                        ]
                      ] else
                        const SizedBox(height: 30.0), // 나머지 요소들
                    ],
                  );
                }).toList(),
                const SizedBox(
                  height: 20.0,
                ),
              ],
              if (pastTrips.isNotEmpty) ...[
                const Text(
                  '다녀온 여행',
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  '즐거운 기억을 되짚어보세요!',
                  style: TextStyle(
                    color: LABEL_TEXT_SUB_COLOR,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ...pastTrips.asMap().entries.map((entry) {
                  int index = entry.key;
                  var trip = entry.value;

                  return Column(
                    children: [
                      TripRecommendCard.fromModel(
                        type: "DRIVER",
                        model: trip,
                      ),
                      if (index == pastTrips.length - 1)
                        const SizedBox(height: 10.0) // 마지막 요소의 경우

                      else
                        const SizedBox(height: 30.0), // 나머지 요소들
                    ],
                  );
                }).toList(),
              ],
            ],
          )),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = PRIMARY_COLOR
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
