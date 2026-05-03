part of 'calendar_bloc.dart';

class CalendarState extends Equatable {
  final int year;
  final int month;
  final DateTime? selectedDate;
  final List<CalendarDay> days;
  final Map<String, CalendarDay> dayMap;
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
      selectedDate:
          clearSelected ? null : (selectedDate ?? this.selectedDate),
      days: days ?? this.days,
      dayMap: dayMap ?? this.dayMap,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  CalendarDay? get selectedDay {
    if (selectedDate == null) return null;
    return dayMap[DateKeyUtil.fromDateTime(selectedDate!)];
  }

  @override
  // Fix: เพิ่ม dayMap เข้า props ให้ครบ
  List<Object?> get props => [year, month, selectedDate, days, dayMap, isLoading];
}