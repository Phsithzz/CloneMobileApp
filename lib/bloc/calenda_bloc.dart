import 'package:clone_mobile_app/bloc/calenda_event.dart';
import 'package:clone_mobile_app/bloc/calenda_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/day_model.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<LoadMonthEvent>((event, emit) {
      final days = _generateCalendarDays(event.month);
      emit(CalendarLoaded(event.month, days));
    });
  }

  List<DayModel> _generateCalendarDays(DateTime targetMonth) {
    List<DayModel> days = [];
    
    // หาวันแรกและวันสุดท้ายของเดือน
    DateTime firstDayOfMonth = DateTime(targetMonth.year, targetMonth.month, 1);
    int lastDay = DateTime(targetMonth.year, targetMonth.month + 1, 0).day;
    
    // สมมติให้ปฏิทินเริ่มวันจันทร์ (1) ถึง วันอาทิตย์ (7)
    int firstWeekday = firstDayOfMonth.weekday; 
    int daysFromPrevMonth = firstWeekday - 1; 

    // 1. เติมวันของเดือนก่อนหน้า (ให้สีจางใน UI)
    for (int i = daysFromPrevMonth - 1; i >= 0; i--) {
      days.add(DayModel(date: firstDayOfMonth.subtract(Duration(days: i + 1)), isCurrentMonth: false));
    }

    // 2. เติมวันของเดือนปัจจุบัน พร้อม Mock ข้อมูล
    for (int i = 1; i <= lastDay; i++) {
      DateTime date = DateTime(targetMonth.year, targetMonth.month, i);
      bool isWeekend = date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
      
      // Mock วันหยุด (สมมติวันที่ 1 เป็นวันหยุด)
      bool isHoliday = i == 1; 
      
      // Mock สีกะงาน (สลับสีเพื่อให้เห็นการคำนวณ Contrast ดำ/ขาว)
      Color? shiftColor;
      List<IconData> icons = [];
      String details = "Working Together\n09:00 - 18:00";

      if (isHoliday) {
        details = "New Year Day (Holiday)";
        icons.add(Icons.celebration);
      } else if (!isWeekend) {
        if (i % 3 == 0) {
          shiftColor = Colors.teal; // สีเข้ม ตัวหนังสือควรเป็นสีขาว
          icons.add(Icons.groups);
        } else if (i % 4 == 0) {
          shiftColor = Colors.cyanAccent; // สีอ่อน ตัวหนังสือควรเป็นสีดำ
          icons.add(Icons.description);
        } else {
          shiftColor = Colors.deepOrange;
          icons.add(Icons.access_time);
        }
      } else {
        details = "Day Off";
      }

      days.add(DayModel(
        date: date, 
        isCurrentMonth: true,
        isHoliday: isHoliday,
        shiftColor: shiftColor,
        icons: icons,
        details: details,
      ));
    }

    // 3. เติมวันของเดือนถัดไปให้ครบ Grid (35 หรือ 42 ช่อง)
    int remainingCells = (days.length > 35) ? 42 - days.length : 35 - days.length;
    DateTime lastDayOfMonth = DateTime(targetMonth.year, targetMonth.month, lastDay);
    for (int i = 1; i <= remainingCells; i++) {
      days.add(DayModel(date: lastDayOfMonth.add(Duration(days: i)), isCurrentMonth: false));
    }
    
    return days;
  }
}