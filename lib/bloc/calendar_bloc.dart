import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc()
    : super(
        CalendarState(
          year: DateTime.now().year,
          month: DateTime.now().month,
          selectedDate: DateTime.now(),
        ),
      ) {
    on<LoadMonthEvent>(_onLoadMonth);
    on<SelectDayEvent>(_onSelectDay);
    on<NavigateMonthEvent>(_onNavigateMonth);

    // Load initial month
    add(LoadMonthEvent(year: state.year, month: state.month));
  }

  void _onLoadMonth(LoadMonthEvent event, Emitter<CalendarState> emit) {
    emit(state.copyWith(isLoading: true));

    final days = _buildCalendarDays(event.year, event.month);
    final dayMap = {for (var d in days) _dateKey(d): d};

    // Auto-select today if in current month
    final now = DateTime.now();
    DateTime? selected = state.selectedDate;
    if (event.year == now.year && event.month == now.month) {
      selected = now;
    }

    emit(
      state.copyWith(
        year: event.year,
        month: event.month,
        days: days,
        dayMap: dayMap,
        selectedDate: selected,
        isLoading: false,
      ),
    );
  }

  void _onSelectDay(SelectDayEvent event, Emitter<CalendarState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onNavigateMonth(NavigateMonthEvent event, Emitter<CalendarState> emit) {
    var newMonth = state.month + event.direction;
    var newYear = state.year;
    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    } else if (newMonth < 1) {
      newMonth = 12;
      newYear--;
    }
    add(LoadMonthEvent(year: newYear, month: newMonth));
  }

  // ─── Calendar Grid Builder ─────────────────────────────────────────────────
  List<CalendarDay> _buildCalendarDays(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);

    // Thai calendar: week starts on Monday (จ=0)
    // weekday: Mon=1, Tue=2, ... Sun=7
    int startWeekday = firstDay.weekday; // 1=Mon
    int leadingDays = startWeekday - 1; // days from prev month to show

    final List<CalendarDay> result = [];

    // Previous month trailing days
    for (int i = leadingDays; i > 0; i--) {
      final date = firstDay.subtract(Duration(days: i));
      result.add(_buildDay(date, isCurrentMonth: false));
    }

    // Current month days
    for (int d = 1; d <= lastDay.day; d++) {
      final date = DateTime(year, month, d);
      result.add(_buildDay(date, isCurrentMonth: true));
    }

    // Next month leading days to fill grid (multiple of 7)
    int remainder = result.length % 7;
    if (remainder != 0) {
      int trailing = 7 - remainder;
      for (int i = 1; i <= trailing; i++) {
        final date = DateTime(year, month + 1, i);
        result.add(_buildDay(date, isCurrentMonth: false));
      }
    }

    return result;
  }

  CalendarDay _buildDay(DateTime date, {required bool isCurrentMonth}) {
    // Mock logic for shifts and events
    final weekday = date.weekday; // 1=Mon, 7=Sun
    final isWeekend = weekday == 6 || weekday == 7;
    final isSunday = weekday == 7;
    final isSaturday = weekday == 6;

    Shift? shift;
    List<EventType> icons = [];
    List<DayEvent> events = [];
    bool isHoliday = isWeekend;

    if (!isWeekend && isCurrentMonth) {
      shift = ShiftData.go5;
      icons = _mockIconsForDay(date);
      events = _mockEventsForDay(date);
    } else if (isSaturday && isCurrentMonth) {
      shift = ShiftData.off;
    } else if (isSunday && isCurrentMonth) {
      shift = ShiftData.off;
    }

    // Special day: 20th gets GO5 highlight (like in mockup)
    if (date.day == 20 && isCurrentMonth) {
      icons = [
        EventType.location,
        EventType.interview,
        EventType.document,
        EventType.activity,
      ];
      events = _specialDayEvents();
    }

    return CalendarDay(
      date: date,
      shift: shift,
      isHoliday: isHoliday,
      events: events,
      iconTypes: icons,
    );
  }

  List<EventType> _mockIconsForDay(DateTime date) {
    final seed = date.day % 5;
    switch (seed) {
      case 0:
        return [EventType.interview, EventType.document];
      case 1:
        return [EventType.location];
      case 2:
        return [EventType.activity, EventType.announcement];
      case 3:
        return [EventType.document];
      default:
        return [];
    }
  }

  List<DayEvent> _mockEventsForDay(DateTime date) {
    if (date.day % 3 == 0) {
      return [
        DayEvent(
          type: EventType.interview,
          title: 'Full Stack Developer',
          time: '11:00',
        ),
        DayEvent(
          type: EventType.interview,
          title: 'Frontend Developer',
          time: '14:30',
        ),
      ];
    }
    return [];
  }

  List<DayEvent> _specialDayEvents() => [
    DayEvent(
      type: EventType.interview,
      title: 'Full Stack Developer',
      time: '11:00',
    ),
    DayEvent(
      type: EventType.interview,
      title: 'Full Stack Developer',
      time: '14:00',
    ),
    DayEvent(
      type: EventType.interview,
      title: 'Frontend Developer',
      time: '14:30',
    ),
    DayEvent(
      type: EventType.interview,
      title: 'Internship Developer',
      time: '16:30',
    ),
    DayEvent(
      type: EventType.location,
      title: 'เวิร์กอิน',
      detail: '-13.7203526, 100.5599307',
    ),
  ];

  static String _dateKey(CalendarDay d) {
    final dt = d.date;
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
