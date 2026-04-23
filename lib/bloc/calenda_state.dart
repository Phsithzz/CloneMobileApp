import 'package:equatable/equatable.dart';
import '../model/day_model.dart';

abstract class CalendarState extends Equatable {
  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final DateTime currentMonth;
  final List<DayModel> days;

  CalendarLoaded(this.currentMonth, this.days);

  @override
  List<Object> get props => [currentMonth, days];
}