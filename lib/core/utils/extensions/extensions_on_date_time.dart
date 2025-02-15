extension DateFormatting on DateTime {
  String get formattedDate => '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  String get formattedTime => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  String get fullFormatted => '$formattedDate $formattedTime';
}

extension DateComparisons on DateTime {
  bool isSameDate(DateTime other) => year == other.year && month == other.month && day == other.day;

  bool isToday() => isSameDate(DateTime.now());

  bool isBeforeToday() => isBefore(DateTime.now());

  bool isAfterToday() => isAfter(DateTime.now());
}

extension DateTimeExtensions on DateTime {
  /// Returns today's date without time.
  DateTime get today => DateTime.now();

  /// Returns yesterday's date.
  DateTime get yesterday => today.subtract(const Duration(days: 1));

  /// Returns the date [n] days ago from today.
  DateTime daysAgo(int n) => today.subtract(Duration(days: n));

  /// Returns the date [n] days from today.
  DateTime daysFromNow(int n) => today.add(Duration(days: n));

  /// Returns the start of the current week (Monday as the first day).
  DateTime get startOfWeek {
    final int daysToSubtract = weekday - DateTime.monday;
    return subtract(Duration(days: daysToSubtract)).startOfDay;
  }

  /// Returns the start of the last week (Monday as the first day).
  DateTime get lastWeek => startOfWeek.subtract(const Duration(days: 7));

  /// Returns the start of the week [n] weeks ago.
  DateTime weeksAgo(int n) => startOfWeek.subtract(Duration(days: 7 * n));

  /// Returns the start of the week [n] weeks from now.
  DateTime weeksFromNow(int n) => startOfWeek.add(Duration(days: 7 * n));

  /// Returns the first day of the current month.
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Returns the first day of the last month.
  DateTime get lastMonth => DateTime(year, month - 1, 1);

  /// Returns the first day of the month [n] months ago.
  DateTime monthsAgo(int n) {
    final int newMonth = month - n;
    final int yearAdjustment = (newMonth <= 0) ? (newMonth - 1) ~/ 12 : 0;
    final int adjustedYear = year + yearAdjustment;
    final int adjustedMonth = newMonth > 0 ? newMonth : (12 + newMonth % 12);
    return DateTime(adjustedYear, adjustedMonth, 1);
  }

  /// Returns the first day of the month [n] months from now.
  DateTime monthsFromNow(int n) {
    final int newMonth = month + n;
    final int yearAdjustment = (newMonth - 1) ~/ 12;
    final int adjustedYear = year + yearAdjustment;
    final int adjustedMonth = (newMonth - 1) % 12 + 1;
    return DateTime(adjustedYear, adjustedMonth, 1);
  }

  /// Returns the start of the current year.
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// Returns the first day of the previous year.
  DateTime get lastYear => DateTime(year - 1, 1, 1);

  /// Returns the start of the year [n] years ago.
  DateTime yearsAgo(int n) => DateTime(year - n, 1, 1);

  /// Returns the start of the year [n] years from now.
  DateTime yearsFromNow(int n) => DateTime(year + n, 1, 1);

  /// Returns the start of the day (00:00:00).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns the end of the day (23:59:59).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  DateTime addDays(int days) => add(Duration(days: days));

  DateTime subtractDays(int days) => subtract(Duration(days: days));
}

extension HumanReadableDateTime on DateTime {
  /// Returns a human-readable representation of the time difference
  /// between this date and the current date, such as "4 days ago",
  /// "2 weeks ago", or "last month".
  String timeAgo() {
    final Duration difference = DateTime.now().difference(this);

    if (difference.inDays == 0) {
      if (difference.inHours > 0) {
        return "${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago";
      } else if (difference.inMinutes > 0) {
        return "${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago";
      } else {
        return "just now";
      }
    }

    if (difference.inDays == 1) {
      return "yesterday";
    }

    if (difference.inDays < 7) {
      return "${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago";
    }

    if (difference.inDays < 30) {
      final int weeks = (difference.inDays / 7).floor();
      return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
    }

    if (difference.inDays < 365) {
      final int months = (difference.inDays / 30).floor();
      return "$months ${months == 1 ? 'month' : 'months'} ago";
    }

    final int years = (difference.inDays / 365).floor();
    return "$years ${years == 1 ? 'year' : 'years'} ago";
  }
}
