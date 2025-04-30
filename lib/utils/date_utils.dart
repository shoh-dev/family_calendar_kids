class DateUtilsX {
  static DateTime todayMidnight() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}
