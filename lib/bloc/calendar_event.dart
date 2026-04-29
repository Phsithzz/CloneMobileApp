part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
  @override
  List<Object?> get props => [];
}

class LoadMonthEvent extends CalendarEvent {
  final int year;
  final int month;
  const LoadMonthEvent({required this.year, required this.month});
  @override
  List<Object?> get props => [year, month];
}

class SelectDayEvent extends CalendarEvent {
  final DateTime date;
  const SelectDayEvent(this.date);
  @override
  List<Object?> get props => [date];
}

class NavigateMonthEvent extends CalendarEvent {
  final int direction; // -1 or +1
  const NavigateMonthEvent(this.direction);
  @override
  List<Object?> get props => [direction];
}
