import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class DayModel extends Equatable {
  final DateTime date;
  final bool isCurrentMonth;
  final bool isHoliday;
  final Color? shiftColor;
  final List<IconData> icons; 
  final String details;

  const DayModel({
    required this.date,
    required this.isCurrentMonth,
    this.isHoliday = false,
    this.shiftColor,
    this.icons = const [],
    this.details = 'No specific details for this day.',
  });

  @override
  List<Object?> get props => [date, isCurrentMonth, isHoliday, shiftColor, icons, details];
}