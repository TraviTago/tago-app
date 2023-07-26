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
}
