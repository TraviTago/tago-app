import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tago_app/common/component/progress_bar.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class PartyFirstFormScreen extends StatefulWidget {
  const PartyFirstFormScreen({super.key});

  static String get routeName => 'partyForm1';

  @override
  State<PartyFirstFormScreen> createState() => _PartyFirstFormScreenState();
}

class _PartyFirstFormScreenState extends State<PartyFirstFormScreen> {
  DateTime _selectedDay = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
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
                    ProgressBar(beginPercentage: 0, endPercentage: 0.16),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      '언제가세요?',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: TableCalendar(
                  daysOfWeekHeight: 20.0,
                  rowHeight: 50.0,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  weekendDays: const [DateTime.sunday],
                  rangeStartDay: DateTime.now(),
                  rangeEndDay: DateTime.utc(2030, 3, 14),
                  locale: 'ko_KR',
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (selectedDay.isBefore(DateTime.now())) {
                      // 오늘 날짜 이전의 날짜를 선택하지 못하게 함
                      return;
                    }
                    setState(() {
                      _selectedDay = selectedDay;
                      print(_selectedDay);
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    rangeStartDecoration: const BoxDecoration(),
                    rangeStartTextStyle: const TextStyle(),
                    rangeHighlightColor: Colors.white.withOpacity(0),
                    withinRangeTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    weekendTextStyle: const TextStyle(
                      color: Color(0xFFBFBFBF),
                    ),
                    defaultTextStyle: const TextStyle(
                      color: Color(0xFFBFBFBF),
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: PRIMARY_COLOR,
                      shape: BoxShape.circle,
                    ),
                    isTodayHighlighted: false,
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ), // 평일 텍스트 크기 조절
                    weekendStyle: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ), // 주말 텍스트 크기 조절
                  ),
                  headerStyle: const HeaderStyle(
                    titleTextStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    leftChevronIcon: Icon(
                      size: 25.0,
                      Icons.chevron_left,
                      color: Colors.black,
                    ),
                    rightChevronIcon: Icon(
                      size: 25.0,
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),
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
                onPressed: () => context.go('/form2'),
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
