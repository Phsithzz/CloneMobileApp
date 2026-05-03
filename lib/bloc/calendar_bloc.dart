import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:clone_mobile_app/utils/calendar_grid_builder.dart';
import 'package:clone_mobile_app/utils/date_key_util.dart';
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

    add(LoadMonthEvent(year: state.year, month: state.month));
  }

  void _onLoadMonth(LoadMonthEvent event, Emitter<CalendarState> emit) {
    emit(state.copyWith(isLoading: true));

    final days = CalendarGridBuilder.build(event.year, event.month);
    final dayMap = CalendarGridBuilder.buildMap(days);

    // Auto-select today if navigating to current month,
    // otherwise clear selection so panel doesn't show stale data
    final now = DateTime.now();
    final isCurrentMonth =
        event.year == now.year && event.month == now.month;

    emit(
      state.copyWith(
        year: event.year,
        month: event.month,
        days: days,
        dayMap: dayMap,
        selectedDate: isCurrentMonth ? now : null,
        clearSelected: !isCurrentMonth,
        isLoading: false,
      ),
    );
  }

  void _onSelectDay(SelectDayEvent event, Emitter<CalendarState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onNavigateMonth(
    NavigateMonthEvent event,
    Emitter<CalendarState> emit,
  ) {
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
}