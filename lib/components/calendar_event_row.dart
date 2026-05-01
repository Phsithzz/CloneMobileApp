import 'package:clone_mobile_app/extentions/event_type_ui_extension.dart';
import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:flutter/material.dart';

class CalendarEventRow extends StatelessWidget {
  final DayEvent event;
  final VoidCallback onTap;

  const CalendarEventRow({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, color) = event.type.iconAndColor;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 42,
              child: Text(
                event.time ?? '',
                style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 14, color: color),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                event.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF424242),
                ),
              ),
            ),
            if (event.detail != null) _DetailBadge(detail: event.detail!),
          ],
        ),
      ),
    );
  }
}

class _DetailBadge extends StatelessWidget {
  final String detail;
  const _DetailBadge({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          detail,
          style: const TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
        ),
        const SizedBox(width: 4),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}