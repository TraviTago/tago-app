import 'package:flutter/material.dart';
import 'package:tago_app/common/component/space_container.dart';
import 'package:tago_app/common/const/colors.dart';
import 'package:tago_app/common/const/data.dart';
import 'package:tago_app/common/layout/default_layout.dart';
import 'package:tago_app/common/utils/data_utils.dart';
import 'package:tago_app/place/model/place_detail_model.dart';

class PlaceDetailScreen extends StatefulWidget {
  static String get routeName => 'placeDetail';

  const PlaceDetailScreen({
    super.key,
  });

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final detailModel = placeDetailModel;

    return DefaultLayout(
      titleComponet: Text(
        detailModel.title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      child: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailImage(imageUrl: detailModel.imgUrl),
                    const SizedBox(height: 20.0),
                    Text(
                      detailModel.address,
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: LABEL_TEXT_SUB_COLOR,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      DataUtils.cleanOverview(detailModel.overview, true),
                      style: const TextStyle(
                        fontSize: 13.0,
                        height: 1.5,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if (detailModel.telephone != null ||
                        detailModel.restDate != null ||
                        detailModel.parking != null ||
                        detailModel.openTime != null ||
                        detailModel.homepage != null)
                      DetailInfo(detailModel: detailModel),
                  ],
                ),
              ),
              const SpacerContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailImage extends StatelessWidget {
  final String imageUrl;

  const DetailImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        imageUrl,
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String assetName;
  final String text;

  const InfoRow({super.key, required this.assetName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Image.asset(
            assetName,
            width: 20.0,
            height: 20.0,
          ),
          const SizedBox(width: 20),
          Text(text),
        ],
      ),
    );
  }
}

class DetailInfo extends StatelessWidget {
  final PlaceDetailModel detailModel;

  const DetailInfo({super.key, required this.detailModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (detailModel.telephone != null)
          InfoRow(
              assetName: 'asset/img/phone.png', text: detailModel.telephone!),
        if (detailModel.homepage != null)
          InfoRow(
              assetName: 'asset/img/globe.png',
              text: DataUtils.cleanHomepage(detailModel.homepage!)),
        if (detailModel.restDate != null)
          InfoRow(
              assetName: 'asset/img/calendar.png',
              text: DataUtils.preprocessRestDate(detailModel.restDate!)),
        if (detailModel.openTime != null)
          InfoRow(
              assetName: 'asset/img/clock.png', text: detailModel.openTime!),
        if (detailModel.parking != null)
          InfoRow(
              assetName: 'asset/img/car.png',
              text: DataUtils.preprocessParking(detailModel.parking!)),
      ],
    );
  }
}
