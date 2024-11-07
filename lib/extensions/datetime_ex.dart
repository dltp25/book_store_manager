extension DateTimeX on DateTime {
  DateTime toDateOnly() {
    return DateTime(year, month, day);
  }

  DateTime toStartOfDate() {
    return DateTime(year, month, day);
  }

  DateTime toEndOfDate() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  DateTime getMonthAndYear() {
    return DateTime(year, month);
  }

  DateTime startOfMonth() {
    return DateTime(year, month);
  }

  DateTime endOfMonth() {
    final nextMonth = month < 12 ? month + 1 : 1;
    final nextYear = nextMonth == 1 ? year + 1 : year;
    final endOfMonth = DateTime(nextYear, nextMonth, 0);
    return endOfMonth;
  }

  int getDaysOfMonth() {
    if ([1, 3, 5, 7, 8, 10, 12].contains(month)) {
      return 31;
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    } else {
      if (year % 4 == 0) {
        if (year % 100 == 0) {
          if (year % 400 == 0) {
            return 29;
          }
        } else {
          return 29;
        }
      }
      return 28;
    }
  }

  String displayTimeAgoFrom(DateTime now) {
    final int diffInHours = now.difference(this).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = now.difference(this).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'phút';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'giờ';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'ngày';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'tuần';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'tháng';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'năm';
    }

    timeAgo = '$timeValue $timeUnit';

    return '$timeAgo trước';
  }
}
