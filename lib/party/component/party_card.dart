import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/party/model/party_model.dart';

class PartyCard extends StatelessWidget {
  final String id;
  final String name;
  final String imgUrl;
  final List<String> tags;
  final int maxNum; //최대 인원
  final int curNum; //현재 인원
  final int duration;
  final int startDate;

  const PartyCard({
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

  factory PartyCard.fromModel({
    required PartyModel model,
  }) {
    return PartyCard(
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DataUtils.formatDate(startDate),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                    child: Image.network(
                      imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF5F5F5),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5.0,
                          ),
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
                            style: const TextStyle(
                              color: Color(0xFF595959),
                              fontSize: 10.0,
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
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
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.all(
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
          fontWeight: FontWeight.w500,
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
          name,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          '소요시간 ${DataUtils.formatDuration(duration)}',
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF595959),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
