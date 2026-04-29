class ThaiDateUtils {
  static const List<String> thaiMonths = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
  ];

  static const List<String> thaiShortDays = [
    'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส', 'อา'
  ];

  static const List<String> thaiLongDays = [
    'จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์', 'อาทิตย์'
  ];

  /// Convert year to Thai Buddhist Era (พ.ศ.)
  static int toBuddhistYear(int year) => year + 543;

  static String monthYearThai(int year, int month) {
    return '${thaiMonths[month - 1]} ${toBuddhistYear(year)}';
  }

  static String fullDateThai(DateTime date) {
    final weekday = thaiLongDays[date.weekday - 1];
    final dayName = weekdayShortPrefix(date.weekday);
    return '$dayName. ${date.day} ${thaiMonths[date.month - 1]}';
  }

  static String weekdayShortPrefix(int weekday) {
    const map = ['จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส', 'อา'];
    return map[weekday - 1];
  }

  static String formatTime(String? time) => time ?? '';
}
