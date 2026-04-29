part of 'calendar_bloc.dart'; // ← แก้ตรงนี้

class CalendarState extends Equatable {
  final int year;
  final int month;
  final DateTime? selectedDate;
  final List<CalendarDay> days; // all days in grid (including prev/next month)
  final Map<String, CalendarDay> dayMap; // key: 'yyyy-MM-dd'
  final bool isLoading;

  const CalendarState({
    required this.year,
    required this.month,
    this.selectedDate,
    this.days = const [],
    this.dayMap = const {},
    this.isLoading = false,
  });

  CalendarState copyWith({
    int? year,
    int? month,
    DateTime? selectedDate,
    List<CalendarDay>? days,
    Map<String, CalendarDay>? dayMap,
    bool? isLoading,
    bool clearSelected = false,
  }) {
    return CalendarState(
      year: year ?? this.year,
      month: month ?? this.month,
      selectedDate: clearSelected ? null : (selectedDate ?? this.selectedDate),
      days: days ?? this.days,
      dayMap: dayMap ?? this.dayMap,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  CalendarDay? get selectedDay {
    if (selectedDate == null) return null;
    final key = _dateKey(selectedDate!);
    return dayMap[key];
  }

  static String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  List<Object?> get props => [year, month, selectedDate, days, isLoading];
}
