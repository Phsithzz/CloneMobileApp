import 'package:clone_mobile_app/model/shift_model.dart';

/// Temporary mock data source.
/// Replace with real API repository later without touching CalendarBloc.
class CalendarMockRepository {
  CalendarMockRepository._();

  static List<EventType> iconsForDay(DateTime date) {
    // Special day overrides
    if (date.day == 20) {
      return [
        EventType.location,
        EventType.interview,
        EventType.document,
        EventType.activity,
      ];
    }

    switch (date.day % 5) {
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

  static List<DayEvent> eventsForDay(DateTime date) {
    if (date.day == 20) return _specialDayEvents();
    if (date.day % 3 == 0) return _interviewEvents();
    return [];
  }

  static List<DayEvent> _interviewEvents() => [
    const DayEvent(
      type: EventType.interview,
      title: 'Full Stack Developer',
      time: '11:00',
    ),
    const DayEvent(
      type: EventType.interview,
      title: 'Frontend Developer',
      time: '14:30',
    ),
  ];

  static List<DayEvent> _specialDayEvents() => [
    const DayEvent(
      type: EventType.interview,
      title: 'Full Stack Developer',
      time: '11:00',
    ),
    const DayEvent(
      type: EventType.interview,
      title: 'Full Stack Developer',
      time: '14:00',
    ),
    const DayEvent(
      type: EventType.interview,
      title: 'Frontend Developer',
      time: '14:30',
    ),
    const DayEvent(
      type: EventType.interview,
      title: 'Internship Developer',
      time: '16:30',
    ),
    const DayEvent(
      type: EventType.location,
      title: 'เวิร์กอิน',
      detail: '-13.7203526, 100.5599307',
    ),
  ];
}