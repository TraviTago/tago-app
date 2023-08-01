import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/course/model/course_model.dart';

class CourseRecommendCard extends StatelessWidget {
  final String id;
  final String name;
  final String imgUrl;
  final List<String> tags;
  final int maxNum; //최대 인원
  final int curNum; //현재 인원
  final int duration;
  final int startDate;

  const CourseRecommendCard({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.tags,
    required this.maxNum,
    required this.curNum,
    required this.duration,
    required this.startDate,
    Key? key,
  }) : super(key: key);

  factory CourseRecommendCard.fromModel({
    required CourseModel model,
  }) {
    return CourseRecommendCard(
      id: model.id,
      name: model.name,
      imgUrl: model.imgUrl,
      tags: model.tags,
      maxNum: model.maxNum,
      curNum: model.curNum,
      startDate: model.startDate,
      duration: model.duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width - 60; // List Screen 좌우 패딩 값을 뺸다.
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Stack(
        children: <Widget>[
          Image.network(
            imgUrl,
            width: screenWidth,
            height: screenWidth,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: screenWidth,
              height: (screenWidth) / 3,
              decoration: BoxDecoration(
                color: const Color(0xFF161616).withOpacity(0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DateAndName(
                          date: startDate,
                          name: name,
                          duration: duration,
                        ),
                        _PersonLabel(curNum: curNum, maxNum: maxNum)
                      ],
                    ),
                    Text(
                      tags.join(' · '),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonLabel extends StatelessWidget {
  final int curNum;
  final int maxNum;

  const _PersonLabel({
    required this.curNum,
    required this.maxNum,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 20,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5).withOpacity(0.9),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Text(
        '$curNum/$maxNum',
        style: const TextStyle(
          fontSize: 13.0,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _DateAndName extends StatelessWidget {
  final String name;
  final int date;
  final int duration;

  const _DateAndName({
    required this.name,
    required this.date,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${DataUtils.formatDate(date)} - $name',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '소요시간 ${DataUtils.formatDuration(duration)}',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
