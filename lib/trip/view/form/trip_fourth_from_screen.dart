import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/place/component/place_search_modal.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/place/model/place_model.dart';

class TripFourthFormScreen extends StatefulWidget {
  const TripFourthFormScreen({super.key});

  static String get routeName => 'tripForm4';

  @override
  State<TripFourthFormScreen> createState() => _TripFourthFormScreenState();
}

class _TripFourthFormScreenState extends State<TripFourthFormScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _buttonkey = GlobalKey();
  final GlobalKey _timekey = GlobalKey();

  bool isRecommended = false;
  List<int> selectedPlaceIndexes = [];
  DateTime? selectedDateTime;
  List<PlaceModel> selectedMustPlaces = [];

  void _updatePlaces(PlaceModel newPlace) {
    setState(() {
      //TOFIX: 현재는 무조건 place는 하나
      selectedMustPlaces.clear();
      selectedMustPlaces.add(newPlace);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 30.0,
          ),
          child: Column(
            children: [
              const Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressBar(beginPercentage: 0.48, endPercentage: 0.64),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      '어디로 떠날까요?',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '어렵다면 저희가 추천해드릴게요!',
                      style: TextStyle(
                        color: LABEL_TEXT_SUB_COLOR,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                      child: Text(
                        '꼭 가고 싶은 곳',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    SizedBox(
                      key: _buttonkey,
                      height: 35,
                      child: selectedMustPlaces.isNotEmpty
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              children: selectedMustPlaces
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: LABEL_BG_COLOR,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      10.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          entry.value.title,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: PRIMARY_COLOR,
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                5.0), // Add a little space between the text and the icon
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedMustPlaces.clear();
                                            });
                                          },
                                          child: const Icon(Icons.close,
                                              size: 14,
                                              color:
                                                  BUTTON_BG_COLOR), // Add 'close' icon
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                          : const Text(
                              '가고싶은 장소를 추가해 보세요 :-)',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: PRIMARY_COLOR,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                        final RenderBox renderBox = _buttonkey.currentContext!
                            .findRenderObject() as RenderBox;
                        Offset offset = renderBox.localToGlobal(Offset.zero);
                        showModalBottomSheet(
                          elevation: 0,
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return PlaceSearchModal(
                                controller: _controller,
                                selectedPlaces: selectedMustPlaces,
                                offset: offset,
                                updatePlaces: _updatePlaces);
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: LABEL_BG_COLOR,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: LABEL_TEXT_SUB_COLOR,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '장소 추가하기',
                            style: TextStyle(
                              color: LABEL_TEXT_SUB_COLOR,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    const Text(
                      '집결 장소와 시간',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          key: _timekey,
                          onPressed: () {
                            final RenderBox renderBox = _timekey.currentContext!
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
                                return _TimePickerModal(
                                  offset: offset,
                                  selectedTime: selectedDateTime,
                                  onTimeSelected: (timeSelected) => {
                                    setState(() {
                                      selectedDateTime = timeSelected;
                                    }),
                                  },
                                );
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: LABEL_BG_COLOR,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              selectedDateTime == null
                                  ? '시간 선택하기'
                                  : DateFormat('a h:mm', 'ko_KR').format(
                                      selectedDateTime!), // 'ko_KR'은 한국어를 의미합니다.
                              style: TextStyle(
                                color: selectedDateTime == null
                                    ? Colors.black
                                    : PRIMARY_COLOR,
                                fontSize: 14,
                                fontWeight: selectedDateTime == null
                                    ? FontWeight.w500
                                    : FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          '에',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            final RenderBox renderBox = _timekey.currentContext!
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
                                return _PlaceModal(
                                  startPlaces: meetPlaces,
                                  offset: offset,
                                  selectedPlaceIndexes: selectedPlaceIndexes,
                                  onPlaceSelected: (indexes) {
                                    setState(() {
                                      selectedPlaceIndexes = indexes;
                                    });
                                  },
                                );
                              },
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: LABEL_BG_COLOR,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              selectedPlaceIndexes.isEmpty
                                  ? '장소 선택하기'
                                  : meetPlaces[selectedPlaceIndexes[0]],
                              style: TextStyle(
                                color: selectedPlaceIndexes.isEmpty
                                    ? Colors.black
                                    : PRIMARY_COLOR,
                                fontSize: 14,
                                fontWeight: selectedPlaceIndexes.isEmpty
                                    ? FontWeight.w500
                                    : FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          '에서 만나요!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                      Size(MediaQuery.of(context).size.width, 45)),
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor:
                      selectedPlaceIndexes.isEmpty || selectedDateTime == null
                          ? MaterialStateProperty.all(
                              BUTTON_BG_COLOR.withOpacity(0.5))
                          : MaterialStateProperty.all(BUTTON_BG_COLOR),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: selectedPlaceIndexes.isEmpty ||
                        selectedDateTime == null
                    ? null
                    : () {
                        int selectedHour = selectedDateTime!.hour;
                        int selectedMinute = selectedDateTime!.minute;

                        String currentDateTimeString = GoRouterState.of(context)
                            .queryParameters['dateTime']!;
                        DateTime currentDateTime =
                            DateTime.parse(currentDateTimeString);
                        DateTime updatedDateTime = DateTime(
                            currentDateTime.year,
                            currentDateTime.month,
                            currentDateTime.day,
                            selectedHour,
                            selectedMinute);

                        String updatedDateTimeString =
                            updatedDateTime.toIso8601String();

                        context.push(
                          Uri(
                            path: '/tripForm5',
                            queryParameters: {
                              'dateTime': updatedDateTimeString,
                              'currentCnt': GoRouterState.of(context)
                                  .queryParameters['currentCnt'],
                              'maxCnt': GoRouterState.of(context)
                                  .queryParameters['maxCnt'],
                              'sameGender': GoRouterState.of(context)
                                  .queryParameters['sameGender'],
                              'sameAge': GoRouterState.of(context)
                                  .queryParameters['sameAge'],
                              'isPet': GoRouterState.of(context)
                                  .queryParameters['isPet'],
                              'meetPlace': meetPlaces[selectedPlaceIndexes[0]],
                              'mustPlaces': selectedMustPlaces.isNotEmpty
                                  ? [selectedMustPlaces.first.id].toString()
                                  : [].toString()
                            },
                          ).toString(),
                        );
                      },
                child: const Text(
                  '다음',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimePickerModal extends StatefulWidget {
  final Offset offset;
  final Function(DateTime) onTimeSelected;
  final DateTime? selectedTime;

  const _TimePickerModal({
    required this.offset,
    required this.onTimeSelected,
    required this.selectedTime,
  });

  @override
  State<_TimePickerModal> createState() => _TimePickerModalState();
}

class _TimePickerModalState extends State<_TimePickerModal> {
  late DateTime selectedTime;

  @override
  void initState() {
    super.initState();
    if (widget.selectedTime == null) {
      selectedTime = DateTime.now().add(const Duration(hours: 1));
    } else {
      selectedTime = widget.selectedTime!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: (MediaQuery.of(context).size.height - widget.offset.dy < 300)
            ? 300
            : MediaQuery.of(context).size.height - widget.offset.dy,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        decoration: const BoxDecoration(
          color: LABEL_BG_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimePickerSpinner(
              time: selectedTime,
              is24HourMode: false,
              minutesInterval: 30,
              normalTextStyle: TextStyle(
                fontSize: 18,
                color: LABEL_TEXT_SUB_COLOR.withOpacity(0.3),
              ),
              highlightedTextStyle: const TextStyle(
                fontSize: 20,
                color: LABEL_TEXT_SUB_COLOR,
                decorationColor: Colors.white,
              ),
              spacing: 60,
              itemHeight: 40,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  selectedTime = time;
                });
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width, 45)),
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                widget.onTimeSelected(selectedTime);
                Navigator.pop(context);
              },
              child: const Text(
                '완료',
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceModal extends StatefulWidget {
  final List<String> startPlaces;
  final Offset offset;
  final Function(List<int>) onPlaceSelected;
  final List<int> selectedPlaceIndexes;

  const _PlaceModal({
    required this.startPlaces,
    required this.offset,
    required this.onPlaceSelected,
    required this.selectedPlaceIndexes,
  });

  @override
  State<_PlaceModal> createState() => _PlaceModalState();
}

class _PlaceModalState extends State<_PlaceModal> {
  late List<int> selectedPlaceIndexes;

  @override
  void initState() {
    super.initState();
    selectedPlaceIndexes = widget.selectedPlaceIndexes;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: (MediaQuery.of(context).size.height - widget.offset.dy < 300)
            ? 300
            : MediaQuery.of(context).size.height - widget.offset.dy,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        decoration: const BoxDecoration(
          color: LABEL_BG_COLOR,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ButtonGroup(
                fontSize: 14.0,
                buttonCount: 4,
                buttonTexts: widget.startPlaces,
                crossAxisCount: 2,
                childAspectRatio: 4,
                isModal: true,
                initialSelectedIndexes: selectedPlaceIndexes,
                onButtonSelected: (selectedButtonNames) {
                  setState(() {
                    selectedPlaceIndexes = selectedButtonNames
                        .map((name) => widget.startPlaces.indexOf(name))
                        .toList();
                  });
                },
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(MediaQuery.of(context).size.width, 45)),
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                widget.onPlaceSelected(selectedPlaceIndexes);
                Navigator.pop(context);
              },
              child: const Text(
                '완료',
                style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
