import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tago_app/course/component/course_search_modal.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/place/component/place_edit_card.dart';
import 'package:tago_app/place/model/place_trip_model.dart';
import 'package:tago_app/trip/model/trip_edit_model.dart';
import 'package:tago_app/trip/provider/trip_edit_provider.dart';
import 'package:tago_app/trip/view/detail/trip_edit_detail_map_screen.dart';
import 'package:tago_app/trip/view/detail/trip_edit_detail_overview_screen.dart';

class TripEditScreen extends ConsumerStatefulWidget {
  static String get routeName => 'tripEdit';

  const TripEditScreen({
    super.key,
    required this.editModel,
  });

  final TripEditModel editModel;

  @override
  ConsumerState<TripEditScreen> createState() => _TripEditScreenState();
}

class _TripEditScreenState extends ConsumerState<TripEditScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController();

  final GlobalKey _buttonkey = GlobalKey();

  bool isEditMode = false;
  late TripEditProvider tripEditModel;

  void _onReorder(int oldIndex, int newIndex) {
    List<PlaceTripModel> updatedPlaces = List.from(tripEditModel.model.places);

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = updatedPlaces.removeAt(oldIndex);
    updatedPlaces.insert(newIndex, item);

    tripEditModel
        .updateTempModel(tripEditModel.model.copyWith(places: updatedPlaces));
  }

  @override
  void initState() {
    super.initState();
    tripEditModel = ref.read(tripEditProvider(widget.editModel));
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tripEditModel = ref.watch(tripEditProvider(widget.editModel));
    return DefaultLayout(
      titleComponet: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.editModel.name,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                if (isEditMode) {
                  tripEditModel.commitChanges();
                }

                isEditMode = !isEditMode;
              });
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                !isEditMode ? '편집하기' : "완료",
                style: const TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      child: !isEditMode
          ? Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Material(
                    color: Colors.white,
                    elevation: 0,
                    child: Container(
                      height: 35,
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        isScrollable: true,
                        padding: const EdgeInsets.only(left: 10.0),
                        controller: _tabController,
                        labelColor: PRIMARY_COLOR,
                        unselectedLabelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0,
                        ),
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                        ),
                        indicator: const UnderlineTabIndicator(
                          insets: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(
                            width: 3.0,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                        tabs: const <Widget>[
                          Tab(
                            child: Text('코스보기'),
                          ),
                          Tab(
                            child: Text('지도로보기'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TripEditDetailOverviewScreen(
                          places: tripEditModel.model.places,
                        ),
                        TripEditDetailMapScreen(
                          places: tripEditModel.model.places,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: LABEL_BG_COLOR,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                          SizedBox(
                            key: _buttonkey,
                            width: 20,
                            height: 20,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {});
                                final RenderBox renderBox = _buttonkey
                                    .currentContext!
                                    .findRenderObject() as RenderBox;
                                Offset offset =
                                    renderBox.localToGlobal(Offset.zero);
                                showModalBottomSheet(
                                  elevation: 0,
                                  barrierColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return CourseSearchModal(
                                      controller: _controller,
                                      offset: offset,
                                      editModel: widget.editModel,
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return SELECTED_PLACE_BG_COLOR;
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Colors.white;
                                  },
                                ),
                                side: MaterialStateProperty.all(
                                  BorderSide.none, // border 제거
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 20.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            '장소 추가하기',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ReorderableListView.builder(
                    itemBuilder: (context, index) {
                      final place = tripEditModel.model.places[index];
                      return ListTile(
                        key: ValueKey(place.id),
                        title: PlaceEditCard(
                          place: place,
                          index: index,
                          onRemove: () {
                            if (tripEditModel.model.places.length <= 1) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  showCloseIcon: true,
                                  closeIconColor: Colors.white,
                                  content: Text('최소 하나의 여행지가 필요합니다'),
                                ),
                              );
                            } else {
                              tripEditModel.removePlaceAt(index);
                            }
                          },
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                      );
                    },
                    itemCount: tripEditModel.model.places.length,
                    onReorder: _onReorder,
                  ),
                ),
              ],
            ),
    );
  }
}
