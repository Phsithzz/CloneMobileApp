import 'package:flutter/material.dart';

enum ShiftType {
  go5,
  off,
  leave,
  overtime,
  document,
  activity,
  announcement,
  swap,
}

class Shift {
  final String code;
  final Color color;
  final String startTime;
  final String endTime;

  const Shift({
    required this.code,
    required this.color,
    required this.startTime,
    required this.endTime,
  });
}

class DayEvent {
  final EventType type;
  final String title;
  final String? time;
  final String? detail;

  const DayEvent({
    required this.type,
    required this.title,
    this.time,
    this.detail,
  });
}

enum EventType {
  interview,
  document,
  activity,
  announcement,
  location,
  birthday,
  leave,
  overtime,
}

class CalendarDay {
  final DateTime date;
  final Shift? shift;
  final bool isHoliday;
  final List<DayEvent> events;
  final List<EventType> iconTypes;

  const CalendarDay({
    required this.date,
    this.shift,
    this.isHoliday = false,
    this.events = const [],
    this.iconTypes = const [],
  });
}

// Predefined shifts (mock data)
class ShiftData {
  static const Shift go5 = Shift(
    code: 'GO5',
    color: Color(0xFFD84315),
    startTime: '11:00',
    endTime: '17:00',
  );

  static const Shift off = Shift(
    code: 'OFF',
    color: Color(0xFFBDBDBD),
    startTime: '',
    endTime: '',
  );

  static const Shift go6 = Shift(
    code: 'GO6',
    color: Color(0xFF1565C0),
    startTime: '09:00',
    endTime: '18:00',
  );

  static const Shift night = Shift(
    code: 'NT',
    color: Color(0xFF4A148C),
    startTime: '22:00',
    endTime: '06:00',
  );

  static const Shift leave = Shift(
    code: 'L',
    color: Color(0xFF2E7D32),
    startTime: '',
    endTime: '',
  );
}
