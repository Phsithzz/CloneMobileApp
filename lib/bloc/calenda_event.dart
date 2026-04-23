import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMonthEvent extends CalendarEvent {
  final DateTime month;
  LoadMonthEvent(this.month);

  @override
  List<Object> get props => [month];
}