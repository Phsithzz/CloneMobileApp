import 'package:flutter/material.dart';
import '../../model/day_model.dart';
import 'shift_bottom_sheet.dart';

class DayCell extends StatelessWidget {
  final DayModel day;

  const DayCell({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Logic คำนวณความเข้มสี (Contrast) เพื่อปรับสีตัวอักษร
    Color textColor = theme.textTheme.bodyMedium!.color!;
    if (day.shiftColor != null) {
      textColor = day.shiftColor!.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    }

    // วันหยุดให้มีพื้นหลังแบบทแยง (Pattern) หรือสีพื้นหลังพิเศษ
    BoxDecoration decoration = BoxDecoration(
      color: day.shiftColor ?? (day.isHoliday ? (isDark ? Colors.grey[800] : Colors.grey[300]) : Colors.transparent),
      border: Border.all(color: theme.dividerColor, width: 0.5),
    );

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: theme.scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (context) => ShiftBottomSheet(day: day),
        );
      },
      child: Opacity(
        opacity: day.isCurrentMonth ? 1.0 : 0.5, // เดือนอื่นสีจาง 50%
        child: Container(
          decoration: decoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Text(
                '${day.date.day}',
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (day.shiftColor != null)
                Text('GO5', style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.w600)),
              if (day.icons.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: day.icons.map((icon) => Icon(icon, size: 12, color: textColor)).toList(),
                ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}