import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  bool isRecommended = false;

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
                      height: 20.0,
                    ),
                    SizedBox(
                      key: _buttonkey,
                      height: 20,
                      child: allPlaces.values.any((value) => value)
                          ? Text(
                              allPlaces.entries
                                  .where((entry) => entry.value == true)
                                  .map((entry) => entry.key)
                                  .join(', '),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: PRIMARY_COLOR,
                              ),
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
                      height: 20.0,
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
                          onPressed: () => {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFFF5F5F5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              '시간 선택하기',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
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
                          onPressed: () => {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFFF5F5F5),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              '장소 선택하기',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
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
                  backgroundColor: MaterialStateProperty.all(BUTTON_BG_COLOR),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  context.goNamed('partyForm4');
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
                contentPadding: EdgeInsets.all(5.0),
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
