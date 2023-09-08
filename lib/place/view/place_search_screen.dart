import 'package:flutter/material.dart';
import 'package:tago_app/common/layout/default_layout.dart';

class PlaceSearchScreen extends StatefulWidget {
  static String get routeName => 'places';

  const PlaceSearchScreen({super.key});

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final TextEditingController controller = TextEditingController();
  String searchedIndex = "";

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      titleComponet: Padding(
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
      child: Column(
        children: [],
      ),
    );
  }
}
