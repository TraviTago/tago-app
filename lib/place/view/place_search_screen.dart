import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/model/cursor_pagination_model.dart';
import 'package:tago_app/place/component/place_list_card.dart';
import 'package:tago_app/place/model/place_model.dart';
import 'package:tago_app/place/provider/place_provider.dart';

class PlaceSearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'places';

  const PlaceSearchScreen({super.key});

  @override
  ConsumerState<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends ConsumerState<PlaceSearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(placeProvider.notifier).resetAndFetchPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      titleComponet: const Padding(
        padding: EdgeInsets.only(right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '여행지 전체보기',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: controller,
              onChanged: (value) {
                ref.read(placeProvider.notifier).filterPlaces(value);
              },
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                filled: true,
                fillColor: LABEL_BG_COLOR,
                prefixIcon: Icon(
                  Icons.search,
                  color: LABEL_TEXT_SUB_COLOR,
                ),
                hintStyle: TextStyle(
                  color: LABEL_TEXT_SUB_COLOR,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
                hintText: '검색하기',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  final state = ref.watch(placeProvider);

                  if (state is CursorPaginationLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CursorPaginationError) {
                    return Text('Error: ${state.message}');
                  } else if (state is CursorPagination) {
                    final places = state.contents as List<PlaceModel>;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: places.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child:
                                PlaceListCard.fromModel(model: places[index]),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text('No data found.');
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
