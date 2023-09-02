import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tago_app/common/component/space_container.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/model/page_pagination_model.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/place/model/place_detail_model.dart';
import 'package:tago_app/place/repository/place_repository.dart';
import 'package:tago_app/search/model/kakao_blog_search_model.dart';
import 'package:tago_app/search/repository/kakao_blog_search_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'placeDetail';

  const PlaceDetailScreen({
    super.key,
  });

  @override
  ConsumerState<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends ConsumerState<PlaceDetailScreen>
    with SingleTickerProviderStateMixin {
  final double _currentPage = 0;
  final currentPageNotifier = ValueNotifier<double>(0);
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    pageController.addListener(() {
      currentPageNotifier.value =
          pageController.page ?? 0; // 리스너에서는 currentPageNotifier만 업데이트합니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    int placeId =
        int.parse(GoRouterState.of(context).pathParameters['placeId']!);
    String placeName = GoRouterState.of(context).queryParameters['title']!;

    return DefaultLayout(
      titleComponet: Text(
        placeName,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      child: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<PlaceDetailModel>(
                future: ref
                    .read(placeRepositoryProvider)
                    .getDetailPlace(placeId: placeId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('오류: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('데이터가 없습니다.'));
                  }

                  final detailModel = snapshot.data!;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailImage(imageUrl: detailModel.imageUrl),
                            const SizedBox(height: 20.0),
                            Text(
                              detailModel.address,
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: LABEL_TEXT_SUB_COLOR,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              DataUtils.cleanOverview(
                                  detailModel.overview, true),
                              style: const TextStyle(
                                fontSize: 13.0,
                                height: 1.5,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                      if (detailModel.telephone != null ||
                          detailModel.restDate != null ||
                          detailModel.parking != null ||
                          detailModel.openTime != null ||
                          detailModel.homepage != null)
                        DetailInfo(detailModel: detailModel),
                    ],
                  );
                },
              ),
              const SpacerContainer(),
              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 15.0,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '장소후기',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              FutureBuilder<PagePagination<KakaoBlogSearchModel>>(
                  future: ref
                      .watch(kakaoBlogSearchRepositoryProvider)
                      .paginate(query: '$placeName 후기'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('오류: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return const Center(child: Text('데이터가 없습니다.'));
                    }

                    final data = snapshot.data!;
                    return Column(
                      children: [
                        SizedBox(
                          height: 450,
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: (data.documents.length / 2).ceil(),
                            itemBuilder: (context, pageIndex) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 2,
                                itemBuilder: (context, itemIndex) {
                                  final index = pageIndex * 2 + itemIndex;
                                  if (index >= data.documents.length) {
                                    return const SizedBox.shrink();
                                  }
                                  final blogItem = data.documents[index];
                                  return Column(
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (await canLaunchUrl(
                                                Uri.parse(blogItem.url),
                                              )) {
                                                await launchUrl(
                                                  Uri.parse(blogItem.url),
                                                );
                                              } else {
                                                print(
                                                    'Could not launch ${blogItem.url}');
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30.0,
                                                      vertical: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${DataUtils.extractDomain(blogItem.url)} > ${blogItem.blogname}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      color:
                                                          LABEL_TEXT_SUB_COLOR,
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  DataUtils.processText(
                                                      blogItem.title,
                                                      placeName,
                                                      false),
                                                  const SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: DataUtils
                                                            .processText(
                                                                blogItem
                                                                    .contents,
                                                                placeName,
                                                                true),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            blogItem.thumbnail,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              // 이미지 로딩에 실패하면 빈 컨테이너 반환
                                                              return Container();
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    DataUtils
                                                        .formatDateOnDateTime(
                                                            blogItem.datetime),
                                                    style: const TextStyle(
                                                      fontSize: 13.0,
                                                      color:
                                                          LABEL_TEXT_SUB_COLOR,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if (itemIndex == 0) const Divider(),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        ValueListenableBuilder<double>(
                            valueListenable: currentPageNotifier,
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DotsIndicator(
                                  dotsCount: (data.documents.length / 2).ceil(),
                                  position: value.round(), // .round()를 사용하여 반올림
                                  decorator: const DotsDecorator(
                                    activeColor: PRIMARY_COLOR,
                                  ),
                                ),
                              );
                            }),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailImage extends StatelessWidget {
  final String imageUrl;

  const DetailImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String assetName;
  final String text;

  const InfoRow({super.key, required this.assetName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            assetName,
            width: 20.0,
            height: 20.0,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailInfo extends StatelessWidget {
  final PlaceDetailModel detailModel;

  const DetailInfo({super.key, required this.detailModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SpacerContainer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                '상세정보',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              if (detailModel.telephone != null)
                InfoRow(
                    assetName: 'asset/img/phone.png',
                    text: detailModel.telephone!),
              if (detailModel.homepage != null)
                InfoRow(
                    assetName: 'asset/img/globe.png',
                    text: DataUtils.cleanHomepage(detailModel.homepage!)),
              if (detailModel.restDate != null)
                InfoRow(
                    assetName: 'asset/img/calendar.png',
                    text: DataUtils.preprocessRestDate(detailModel.restDate!)),
              if (detailModel.openTime != null)
                InfoRow(
                    assetName: 'asset/img/clock.png',
                    text: DataUtils.preprocessOpenTime(detailModel.openTime!)),
              if (detailModel.parking != null)
                InfoRow(
                    assetName: 'asset/img/car.png',
                    text: DataUtils.preprocessParking(detailModel.parking!)),
            ],
          ),
        ),
      ],
    );
  }
}
