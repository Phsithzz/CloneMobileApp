import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:clone_mobile_app/utils/thai_date_util.dart';
import 'package:flutter/material.dart';

class DayDetailBottomSheet extends StatelessWidget {
  final CalendarDay day;
  final bool isCurrentMonth;

  const DayDetailBottomSheet({
    super.key,
    required this.day,
    required this.isCurrentMonth,
  });

  @override
  Widget build(BuildContext context) {
    final shift = day.shift;
    final dateText = ThaiDateUtils.fullDateThai(day.date);
    final hasEvents = day.events.isNotEmpty;

    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.2,
      maxChildSize: 0.85,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 12,
                offset: Offset(0, -4),
              )
            ],
          ),
          child: Column(
            children: [
              // Handle
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 6),
                child: Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),

              // Date header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        dateText,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                    if (shift != null && shift.startTime.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: shift.color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'เข้างาน ${shift.startTime}',
                          style: TextStyle(
                            fontSize: 12,
                            color: shift.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Event list
              Expanded(
                child: hasEvents
                    ? ListView.separated(
                        controller: controller,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: day.events.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, indent: 56),
                        itemBuilder: (_, index) {
                          final event = day.events[index];
                          return _buildEventTile(context, event);
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.event_available,
                                size: 40, color: Colors.grey[300]),
                            const SizedBox(height: 8),
                            Text(
                              'ไม่มีรายการในวันนี้',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEventTile(BuildContext context, DayEvent event) {
    final icon = _eventIcon(event.type);
    final color = _eventColor(event.type);

    return InkWell(
      onTap: () => _showEventDetail(context, event),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Time or icon
            SizedBox(
              width: 44,
              child: event.time != null
                  ? Text(
                      event.time!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : const SizedBox(),
            ),

            // Event icon circle
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: color),
            ),

            const SizedBox(width: 12),

            // Title + detail
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF212121),
                    ),
                  ),
                  if (event.detail != null)
                    Text(
                      event.detail!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, size: 18, color: Color(0xFFBDBDBD)),
          ],
        ),
      ),
    );
  }

  void _showEventDetail(BuildContext context, DayEvent event) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _ActionBottomSheet(event: event),
    );
  }

  IconData _eventIcon(EventType type) {
    switch (type) {
      case EventType.interview:
        return Icons.people_outline;
      case EventType.document:
        return Icons.description_outlined;
      case EventType.activity:
        return Icons.event_note_outlined;
      case EventType.announcement:
        return Icons.campaign_outlined;
      case EventType.location:
        return Icons.location_on_outlined;
      case EventType.birthday:
        return Icons.cake_outlined;
      case EventType.leave:
        return Icons.beach_access_outlined;
      case EventType.overtime:
        return Icons.more_time;
    }
  }

  Color _eventColor(EventType type) {
    switch (type) {
      case EventType.interview:
        return const Color(0xFF5C6BC0);
      case EventType.location:
        return const Color(0xFF42A5F5);
      case EventType.leave:
        return const Color(0xFF66BB6A);
      case EventType.overtime:
        return const Color(0xFFFFA726);
      default:
        return const Color(0xFF78909C);
    }
  }
}

// ── Action bottom sheet (ลาออก / ปฏิทินนอกสถานที่ / etc.) ─────────────────
class _ActionBottomSheet extends StatelessWidget {
  final DayEvent event;
  const _ActionBottomSheet({required this.event});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action(Icons.beach_access_outlined, const Color(0xFFD84315), 'ลางาน'),
      _Action(Icons.map_outlined, const Color(0xFFD84315), 'ปฏิบัติงานนอกสถานที่'),
      _Action(Icons.access_time, const Color(0xFFD84315), 'ล่วงเวลา'),
      _Action(Icons.person_add_outlined, const Color(0xFF78909C), 'รับรองเวลา'),
      _Action(Icons.person_remove_outlined, const Color(0xFF78909C), 'ขอสะสมเวลา'),
      _Action(Icons.swap_horiz, const Color(0xFF78909C), 'แลกเวลา'),
      _Action(Icons.attach_money, const Color(0xFF78909C), 'ค่าใช้จ่าย'),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...actions.map((a) => ListTile(
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: a.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(a.icon, color: a.color, size: 18),
                ),
                title: Text(a.label, style: const TextStyle(fontSize: 14)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                onTap: () => Navigator.pop(context),
              )),
        ],
      ),
    );
  }
}

class _Action {
  final IconData icon;
  final Color color;
  final String label;
  const _Action(this.icon, this.color, this.label);
}
