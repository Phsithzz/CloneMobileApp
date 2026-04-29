import 'package:flutter/material.dart';
import '../../model/shift_model.dart';
import '../../utils/color_util.dart';

class CalendarDayCell extends StatelessWidget {
  final CalendarDay day;
  final bool isCurrentMonth;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const CalendarDayCell({
    super.key,
    required this.day,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final shift = day.shift;
    final isOff = shift?.code == 'OFF' || shift == null;

    // Base background color
    Color bgColor;
    if (isOff) {
      bgColor = day.isHoliday
          ? const Color(0xFFF5F5F5)
          : Colors.white;
    } else {
      bgColor = isCurrentMonth
          ? shift!.color
          : shift!.color.withOpacity(0.5);
    }

    final textColor = isOff
        ? (isCurrentMonth ? Colors.black87 : Colors.black26)
        : ColorUtils.contrastColor(bgColor);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
          border: isSelected
              ? Border.all(color: Colors.black87, width: 2)
              : isToday
                  ? Border.all(color: Colors.black54, width: 1.5)
                  : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top row: day number + shift code
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 3, 4, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Day number
                  Container(
                    width: 18,
                    height: 18,
                    decoration: isToday && !isSelected
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            color: textColor.withOpacity(0.15),
                          )
                        : null,
                    alignment: Alignment.center,
                    child: Text(
                      '${day.date.day}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isToday
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isCurrentMonth
                            ? textColor
                            : textColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Shift code label
            if (shift != null)
              Text(
                shift.code,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: isCurrentMonth
                      ? textColor
                      : textColor.withOpacity(0.4),
                  letterSpacing: 0.3,
                ),
              ),

            // Icons row
            _buildIconRow(textColor),

            const SizedBox(height: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildIconRow(Color color) {
    if (day.iconTypes.isEmpty) return const SizedBox(height: 8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: day.iconTypes.take(4).map((type) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.5),
            child: _eventIcon(type, color),
          );
        }).toList(),
      ),
    );
  }

  Widget _eventIcon(EventType type, Color color) {
    IconData icon;
    Color iconColor;

    switch (type) {
      case EventType.interview:
        icon = Icons.people_outline;
        iconColor = color;
        break;
      case EventType.document:
        icon = Icons.description_outlined;
        iconColor = color;
        break;
      case EventType.activity:
        icon = Icons.event_note_outlined;
        iconColor = color;
        break;
      case EventType.announcement:
        icon = Icons.campaign_outlined;
        iconColor = color;
        break;
      case EventType.location:
        icon = Icons.location_on_outlined;
        iconColor = Colors.blue.shade300;
        break;
      case EventType.birthday:
        icon = Icons.cake_outlined;
        iconColor = Colors.pink.shade300;
        break;
      case EventType.leave:
        icon = Icons.beach_access_outlined;
        iconColor = Colors.green.shade300;
        break;
      case EventType.overtime:
        icon = Icons.more_time;
        iconColor = Colors.orange.shade300;
        break;
    }

    return Icon(icon, size: 8, color: iconColor.withOpacity(isCurrentMonth ? 1 : 0.5));
  }
}
