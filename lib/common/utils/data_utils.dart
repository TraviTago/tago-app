class DataUtils {
  static String formatDuration(int durationInSeconds) {
    int hours = durationInSeconds ~/ 60;
    int minutes = (durationInSeconds % 60);

    if (minutes == 0) {
      return '$hours시간';
    }
    return '$hours시간 $minutes분';
  }

  static String formatDate(int timestampInSeconds) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
    return '${date.month}월 ${date.day}일';
  }

  static String formatTime(int timestampInSeconds) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
    String formattedHour = date.hour.toString().padLeft(2, '0');
    String formattedMinute = date.minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute';
  }

  static String cleanOverview(String overview) {
    // HTML 태그 제거
    String cleanText = overview.replaceAll(RegExp('<[^>]+>'), ' ').trim();

    // 제목 표기를 위해 `* `로 시작하는 부분 제거
    cleanText = cleanText.replaceAll(RegExp(r'^\* .+?[\.,\?!]'), '').trim();

    // 연속된 공백 및 줄바꿈 제거
    cleanText = cleanText.replaceAll(RegExp(r'\s\s+'), ' ');

    // 텍스트 길이 제한 (옵션)

    return cleanText;
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
