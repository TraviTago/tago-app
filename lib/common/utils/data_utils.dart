import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataUtils {
  static String formatDuration(int durationInSeconds) {
    int hours = durationInSeconds ~/ 60;
    int minutes = (durationInSeconds % 60);

    if (minutes == 0) {
      return '$hours시간';
    }
    return '$hours시간 $minutes분';
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
      r'href="([^"]+)"',
      multiLine: true,
    );
    final Match? match = regExp.firstMatch(input);

    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? "";
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

  static Widget processText(
    String text,
    String touristAttraction,
    bool isTitle,
  ) {
    var noHtmlText = text.replaceAll(RegExp(r'<[^>]*>'), '');

    // 관광지 이름의 띄어쓰기를 유연하게 대응하기 위한 정규표현식 생성
    final pattern = touristAttraction.splitMapJoin(RegExp(r'\s*'),
        onMatch: (m) => r'\s*', onNonMatch: (n) => RegExp.escape(n));

    final regex = RegExp(pattern);

    // 관광지 이름으로 분할
    final parts = noHtmlText.split(regex);

    // 관광지 이름이 포함되지 않았을 때
    if (parts.length == 1) {
      return Text(
        noHtmlText,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      );
    }

    // 관광지 이름이 포함되었을 때, 해당 부분을 bold 처리
    List<TextSpan> spans = [];
    for (int i = 0; i < parts.length; i++) {
      spans.add(
        TextSpan(
          text: parts[i],
          style: isTitle
              ? const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xFF1148C8),
                )
              : const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
        ),
      );
      if (i < parts.length - 1) {
        final match = regex.firstMatch(noHtmlText.substring(parts[i].length));
        spans.add(
          TextSpan(
            text: match?.group(0) ?? '',
            style: isTitle
                ? const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0,
                    color: Color(0xFF1148C8),
                  )
                : const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
          ),
        );
        if (match != null) {
          final endIndex = parts[i].length + match.end;
          noHtmlText = noHtmlText.substring(endIndex);
        }
      }
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: isTitle ? 2 : 5,
      overflow: TextOverflow.ellipsis,
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
