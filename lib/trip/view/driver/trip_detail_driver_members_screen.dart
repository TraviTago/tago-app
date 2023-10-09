import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/shimmer_box.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/model/trip_member_model.dart';
import 'package:tago_app/trip/repository/trip_repository.dart';

class TripDetailDriverMembersScreen extends ConsumerWidget {
  static String get routeName => 'TripDetailDriverMembersScreen';

  const TripDetailDriverMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int tripId = int.parse(GoRouterState.of(context).pathParameters['tripId']!);
    return FutureBuilder<TripMembersList>(
        future: ref
            .watch(tripRepositoryProvider)
            .getMembersTripDriver(tripId: tripId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DefaultLayout(
              child: Center(
                child: CircularProgressIndicator(color: PRIMARY_COLOR),
              ),
            );
          }

          final memberList = snapshot.data as TripMembersList;
          return DefaultLayout(
            titleCompnentWithPrimaryColor: const Padding(
              padding: EdgeInsets.only(left: 0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  '손님 상세정보',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            child: ListView.builder(
              itemCount: memberList.members.length,
              itemBuilder: (context, index) {
                final member = memberList.members[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 15.0,
                  ),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(
                                member.imgUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const ShimmerBox(
                                      width: 90.0, height: 90.0);
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: LABEL_BG_COLOR,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      member.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        member.mbti,
                                        style: const TextStyle(
                                          color: PRIMARY_COLOR,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      "${member.ageRange}대",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: LABEL_TEXT_SUB_COLOR,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      member.gender,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: LABEL_TEXT_SUB_COLOR,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  member.tripTypes,
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    color: LABEL_TEXT_SUB_COLOR,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Text(
                                      '휴대폰번호',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: LABEL_BG_COLOR,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: Text(
                                          member.phone_number!,
                                          style: const TextStyle(
                                            fontSize: 12.0,
                                            color: PRIMARY_COLOR,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
