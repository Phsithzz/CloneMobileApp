import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:clone_mobile_app/repository/calendar_mock_repository.dart';
import 'package:clone_mobile_app/utils/date_key_util.dart';

class CalendarGridBuilder {
  const CalendarGridBuilder._();

  static List<CalendarDay> build(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);

    // Thai calendar: week starts Monday (จ=0), weekday Mon=1 ... Sun=7
    final leadingDays = firstDay.weekday - 1;

    final result = <CalendarDay>[
      // Previous month trailing days
      for (int i = leadingDays; i > 0; i--)
        _buildDay(firstDay.subtract(Duration(days: i)), isCurrentMonth: false),

      // Current month days
      for (int d = 1; d <= lastDay.day; d++)
        _buildDay(DateTime(year, month, d), isCurrentMonth: true),
    ];

    // Fill remaining cells to complete the last row (multiple of 7)
    final remainder = result.length % 7;
    if (remainder != 0) {
      final trailing = 7 - remainder;
      for (int i = 1; i <= trailing; i++) {
        result.add(
          _buildDay(DateTime(year, month + 1, i), isCurrentMonth: false),
        );
      }
    }

    return result;
  }

  static Map<String, CalendarDay> buildMap(List<CalendarDay> days) => {
    for (final d in days) DateKeyUtil.fromDateTime(d.date): d,
  };

  static CalendarDay _buildDay(DateTime date, {required bool isCurrentMonth}) {
    final weekday = date.weekday;
    final isWeekend = weekday == 6 || weekday == 7;

    if (!isCurrentMonth) {
      return CalendarDay(date: date);
    }

    if (isWeekend) {
      return CalendarDay(
        date: date,
        shift: ShiftData.off,
        isHoliday: true,
      );
    }

    return CalendarDay(
      date: date,
      shift: ShiftData.go5,
      isHoliday: false,
      iconTypes: CalendarMockRepository.iconsForDay(date),
      events: CalendarMockRepository.eventsForDay(date),
    );
  }
}