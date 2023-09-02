import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:tago_app/trip/model/trip_model.dart';

class DataUtils {
  static String formatDuration(int durationInSeconds) {
    int hours = durationInSeconds ~/ 60;
    int minutes = (durationInSeconds % 60);

    if (minutes == 0) {
      return '$hours시간';
    }
    return '$hours시간 $minutes분';
  }

  static TripStatus getTripStatus(DateTime tripDate, int tripTime) {
    DateTime now = DateTime.now();
    DateTime endOfTrip = tripDate.add(Duration(minutes: tripTime));
    TripStatus status;

    if (now.isBefore(tripDate)) {
      status = TripStatus.upcoming;
    } else if (now.isAfter(endOfTrip)) {
      status = TripStatus.completed;
    } else {
      status = TripStatus.ongoing;
    }
    return status;
  }

  static String genderPrinter(String gender) {
    return gender == "MALE" ? "남성" : "여성";
  }

  static String formatDate(DateTime date) {
    return '${date.month}월 ${date.day}일';
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String formatDateTimeToParams(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}T${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00";
  }

  static String formatDateOnDateTime(String dateTimeString) {
    DateTime parsedDate = DateTime.parse(dateTimeString);
    String formattedYear = parsedDate.year.toString();
    String formattedMonth = parsedDate.month.toString().padLeft(2, '0');
    String formattedDay = parsedDate.day.toString().padLeft(2, '0');
    return '$formattedYear-$formattedMonth-$formattedDay';
  }

  static String formatTime(DateTime date) {
    String formattedHour = date.hour.toString().padLeft(2, '0');
    String formattedMinute = date.minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute';
  }

  static Future<String> loadAssetAsBase64(String path) async {
    final ByteData data = await rootBundle.load(path);
    final List<int> bytes = data.buffer.asUint8List();
    return 'data:image/png;base64,${base64Encode(bytes)}';
  }

  static String cleanOverview(String overview, bool isDetail) {
    // HTML 태그 제거
    String cleanText = overview.replaceAll(RegExp('<[^>]+>'), ' ').trim();

    // 제목 표기를 위해 `* `로 시작하는 부분 제거
    cleanText = cleanText.replaceAll(RegExp(r'^\* .+?[\.,\?!]'), '').trim();

    // 연속된 공백 및 줄바꿈 제거
    cleanText = cleanText.replaceAll(RegExp(r'\s\s+'), ' ');

    if (isDetail) {
      // 5문단만 반환
      List<String> paragraphs = cleanText.split('.');
      if (paragraphs.length > 5) {
        cleanText = '${paragraphs.sublist(0, 5).join('.')}.';
        return cleanText;
      }
    }
    // 텍스트 길이 제한 (옵션)

    return cleanText;
  }

  static String cleanHomepage(String input) {
    final RegExp regExp = RegExp(
      r'href=(?:"([^"]+)"|([^\s">]+))',
      multiLine: true,
    );

    final Match? match = regExp.firstMatch(input);

    if (match != null) {
      if (match.group(1) != null) return match.group(1)!;
      if (match.group(2) != null) return match.group(2)!;
    }

    return "";
  }

  static String preprocessRestDate(String input) {
    final List<String> keywords = ["무휴", "휴무", "휴관", "연휴", "휴일"];

    // keywords 중 어느 하나라도 input에 포함되어 있는지 확인
    bool containsAnyKeyword =
        keywords.any((keyword) => input.contains(keyword));

    if (containsAnyKeyword) {
      return input;
    } else {
      return "$input 휴무";
    }
  }

  static String preprocessOpenTime(String text) {
    // <br></br> 패턴을 줄 바꿈 문자로 대체
    text = text.replaceAll(
        RegExp(r'<br\s*/?>\s*<br\s*/?>', caseSensitive: false), '\n');

    // 단독의 <br> 태그를 줄 바꿈 문자로 대체
    text = text.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');

    String cleanText = text.replaceAll(RegExp('<[^>]+>'), '').trim();

    // 제목 표기를 위해 `* `로 시작하는 부분 제거
    cleanText = cleanText.replaceAll(RegExp(r'^\* .+?[\.,\?!]'), '').trim();

    return cleanText;
  }

  static Widget processText(
    String text,
    String keyword,
    bool isTitle,
  ) {
    // HTML 태그를 제거합니다.
    final document = parse(text);
    final cleanedText = parse(document.body!.text).documentElement!.text;

    final defaultTextStyle = isTitle
        ? const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          )
        : const TextStyle(
            fontSize: 17.0,
            color: Color(0xFF1148C8),
          );

    final keywordTextStyle = isTitle
        ? const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14.0,
            color: Colors.black,
          )
        : const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17.0,
            color: Color(0xFF1148C8),
          );

    // 띄어쓰기가 제거된 키워드
    final keywordWithoutSpaces = keyword.replaceAll(RegExp(r'\s+'), '');

    final RegExp keywordPattern = RegExp(
      '($keyword|$keywordWithoutSpaces)',
      caseSensitive: false,
    );

    final spans = <InlineSpan>[];

    // 키워드와 일치하는 모든 위치를 찾습니다.
    cleanedText.splitMapJoin(
      keywordPattern,
      onMatch: (m) {
        spans.add(TextSpan(text: m[0], style: keywordTextStyle));
        return m[0]!;
      },
      onNonMatch: (nonMatch) {
        spans.add(TextSpan(text: nonMatch, style: defaultTextStyle));
        return nonMatch;
      },
    );

    return Text.rich(
      TextSpan(children: spans),
      maxLines: 5,
      overflow: TextOverflow
          .ellipsis, // If you want to show ellipsis when text exceeds maxLines
    );
  }

  static String extractDomain(String url) {
    RegExp regex = RegExp(r'https?://([^/]+)/');
    Match? match = regex.firstMatch(url);

    if (match != null && match.groupCount > 0) {
      return match.group(1)!; // 첫 번째 캡쳐 그룹에서 도메인을 반환
    }

    return url; // 일치하는 항목을 찾을 수 없는 경우 전체 URL 반환
  }

  static String preprocessParking(String input) {
    // 불가능한 경우
    final List<String> notAvailableKeywords = ["불가", "불가능", "없음"];
    for (var keyword in notAvailableKeywords) {
      if (input.contains(keyword)) {
        return "주차 불가능";
      }
    }

    // 유료인 경우
    final RegExp feeRegExp = RegExp(r"\d+원");
    if (input.contains("유료") || feeRegExp.hasMatch(input)) {
      return "유료 주차장 가능";
    }

    // 그 외의 경우
    return "주차 가능";
  }

  static String numberToKoreanOrdinal(int number) {
    switch (number) {
      case 1:
        return '첫';
      case 2:
        return '두';
      case 3:
        return '세';
      case 4:
        return '네';
      case 5:
        return '다섯';
      case 6:
        return '여섯';
      case 7:
        return '일곱';
      case 8:
        return '여덟';
      case 9:
        return '아홉';
      case 10:
        return '열';
      // Add more cases if needed
      default:
        return '$number';
    }
  }
}
