import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tago_app/common/component/button_group.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class PartyFourthFormScreen extends StatefulWidget {
  const PartyFourthFormScreen({super.key});

  static String get routeName => 'partyForm4';

  @override
  State<PartyFourthFormScreen> createState() => _PartyFourthFormScreenState();
}

class _PartyFourthFormScreenState extends State<PartyFourthFormScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _buttonkey = GlobalKey();
  final GlobalKey _timekey = GlobalKey();

  bool isRecommended = false;
  List<int> selectedPlaceIndexes = [];
  DateTime? selectedDateTime;

  List<String> startPlaces = [
    '부산역 4번출구',
    '서면역 2번출구',
    '해운대역 4번출구',
    '광안역',
  ];
  Map<String, bool> allPlaces = {
    '해운대해수욕장': false,
    '해운대나무': false,
    '해운대광안리': false,
    '헤원사': false,
    '히히히': false,
    '하하하': false,
    '호호호': false,
    '라라라': false,
  }; // 초기값은 모두 선택되지 않은 상태입니다.
  void _updatePlaces(Map<String, bool> newPlaces) {
    setState(() {
      allPlaces = newPlaces;
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
                        color: Color(0xFF595959),
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
                      child: allPlaces.values.any((value) => value)
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              children: allPlaces.entries
                                  .where((entry) => entry.value == true)
                                  .expand((entry) => [
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            color: LABEL_BG_COLOR,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                              10.0,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  entry.key,
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
                                                      allPlaces[entry.key] =
                                                          false;
                                                    });
                                                  },
                                                  child: const Icon(Icons.close,
                                                      size: 14,
                                                      color: Color(
                                                          0xFF747474)), // Add 'close' icon
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                10.0), // Add space between the containers
                                      ])
                                  .toList(),
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
                            return SearchModal(
                                controller: _controller,
                                allPlaces: allPlaces,
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
                        backgroundColor: const Color(0xFFF5F5F5),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Color(0xFF595959),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '장소 추가하기',
                            style: TextStyle(
                              color: Color(0xFF595959),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.scale(
                          // Checkbox 크기 조정
                          scale: 1.2,
                          child: Checkbox(
                            activeColor: PRIMARY_COLOR,
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFFDADADA),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: isRecommended,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isRecommended = newValue ?? false;
                              });
                            },
                          ),
                        ),
                        const Text(
                          '전부 추천해주세요!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
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
                            backgroundColor: const Color(0xFFF5F5F5),
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
                                  startPlaces: startPlaces,
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
                            backgroundColor: const Color(0xFFF5F5F5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              selectedPlaceIndexes.isEmpty
                                  ? '장소 선택하기'
                                  : startPlaces[selectedPlaceIndexes[0]],
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
                        print('Selected Start Place : $selectedPlaceIndexes');
                        print('Selected Start Date: $selectedDateTime');
                        print(
                            'Selected Mus places: ${allPlaces.entries.where((entry) => entry.value == true).map((entry) => entry.key).join(', ')}');
                        context.goNamed('partyForm5');
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
      selectedTime = DateTime.now();
    } else {
      selectedTime = widget.selectedTime!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - widget.offset.dy,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
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
                color: const Color(0xFF595959).withOpacity(0.3),
              ),
              highlightedTextStyle: const TextStyle(
                fontSize: 20,
                color: Color(0xFF595959),
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
        maxHeight: MediaQuery.of(context).size.height - widget.offset.dy,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ButtonGroup(
                buttonCount: 4,
                buttonTexts: widget.startPlaces,
                crossAxisCount: 2,
                childAspectRatio: 4,
                isModal: true,
                initialSelectedIndexes: selectedPlaceIndexes,
                onButtonSelected: (selectedButtonIndexes) {
                  setState(() {
                    selectedPlaceIndexes = selectedButtonIndexes;
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

class SearchModal extends StatefulWidget {
  final TextEditingController controller;
  final Map<String, bool> allPlaces;
  final Offset offset;
  final Function(Map<String, bool>) updatePlaces;

  const SearchModal(
      {super.key,
      required this.controller,
      required this.allPlaces,
      required this.offset,
      required this.updatePlaces});
  @override
  _SearchModalState createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  Map<String, bool> searchResults = {};
  Map<String, bool> selectedPlaces = {};

  void _onSearchChanged() {
    setState(() {
      searchResults = Map.fromEntries(widget.allPlaces.entries
          .where((entry) => entry.key.contains(widget.controller.text)));
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onSearchChanged);
    selectedPlaces = Map<String, bool>.from(widget.allPlaces);
    _onSearchChanged();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - widget.offset.dy,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 50.0,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5), // Container의 배경색을 흰색으로 설정
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ), // Container의 상단 왼쪽 및 오른쪽 모서리를 둥글게 설정
        ),
        child: Column(
          children: [
            TextField(
              controller: widget.controller,
              onChanged: (value) {
                _onSearchChanged();
              },
              style: const TextStyle(
                fontWeight: FontWeight.w700, // 입력되는 텍스트의 굵기를 설정
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                filled: true,
                fillColor: Colors.white, // TextField의 배경색을 흰색으로 설정
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF595959),
                ),
                hintStyle: TextStyle(
                  color: Color(0xFF595959),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
                hintText: '장소 추가하기',
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
                    color: PRIMARY_COLOR,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    String key = searchResults.keys.elementAt(index); // key 접근
                    // String value = searchResults.values.elementAt(index); // 만약 value에 접근하려면 이렇게 사용

                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            key, // key를 사용하여 출력
                          ),
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: OutlinedButton(
                              onPressed: () {
                                // 버튼을 클릭할 때마다 해당 관광지의 선택 상태를 toggle
                                setState(() {
                                  selectedPlaces[key] = // key를 사용하여 접근
                                      !selectedPlaces[key]!;
                                });
                              },
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return selectedPlaces[key]! // key를 사용하여 접근
                                        ? const Color(0xFF65C466)
                                        : Colors.white;
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return selectedPlaces[key]! // key를 사용하여 접근
                                        ? Colors.white
                                        : const Color(0xFFDADADA);
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
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
              onPressed: () =>
                  {widget.updatePlaces(selectedPlaces), Navigator.pop(context)},
              child: const Text(
                '추가하기',
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
