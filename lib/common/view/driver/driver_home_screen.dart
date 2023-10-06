import 'package:flutter/material.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/trip/view/list/driver/driver_trip_list_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  State<DriverHomeScreen> createState() => _HomeState();
}

class _HomeState extends State<DriverHomeScreen> with TickerProviderStateMixin {
  String? backgroundImageUrl;
  @override
  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      titleComponetWithoutPop: Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: SizedBox(
          width: double.infinity,
          child: Text(
            '전체 코스보기',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: PRIMARY_COLOR,
              fontSize: 22,
            ),
          ),
        ),
      ),
      child: DriverTripListScreen(),
    );
  }
}
