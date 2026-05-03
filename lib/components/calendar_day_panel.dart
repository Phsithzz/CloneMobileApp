import 'package:clone_mobile_app/bloc/calendar_bloc.dart';
import 'package:clone_mobile_app/components/calendar_event_row.dart';
import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:clone_mobile_app/utils/thai_date_util.dart';
import 'package:flutter/material.dart';

class CalendarDayPanel extends StatelessWidget {
  final CalendarState state;
  final void Function(CalendarDay day) onShiftTap;
  final void Function(DayEvent event) onEventTap;

  const CalendarDayPanel({
    super.key,
    required this.state,
    required this.onShiftTap,
    required this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    final day = state.selectedDay;

    if (day == null) {
      return const Center(
        child: Text(
          'เลือกวันเพื่อดูรายละเอียด',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    final shift = day.shift;
    final dateLabel = ThaiDateUtils.fullDateThai(day.date);
    final hasEvents = day.events.isNotEmpty;

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DayPanelHeader(
            dateLabel: dateLabel,
            shift: shift,
            onShiftTap: () => onShiftTap(day),
          ),
          const Divider(height: 1),
          Expanded(
            child: hasEvents
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: day.events.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 56),
                    itemBuilder: (_, index) => CalendarEventRow(
                      event: day.events[index],
                      onTap: () => onEventTap(day.events[index]),
                    ),
                  )
                : _EmptyEventsPlaceholder(),
          ),
        ],
      ),
    );
  }
}

class _DayPanelHeader extends StatelessWidget {
  final String dateLabel;
  final Shift? shift;
  final VoidCallback onShiftTap;

  const _DayPanelHeader({
    required this.dateLabel,
    required this.shift,
    required this.onShiftTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Text(
            dateLabel,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF9E9E9E)),
          const Spacer(),
          if (shift != null && shift!.startTime.isNotEmpty)
            GestureDetector(
              onTap: onShiftTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: shift!.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: shift!.color.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  'เข้างาน ${shift!.startTime}',
                  style: TextStyle(
                    fontSize: 12,
                    color: shift!.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyEventsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 36,
            color: Colors.grey[200],
          ),
          const SizedBox(height: 8),
          Text(
            'ไม่มีรายการ',
            style: TextStyle(color: Colors.grey[300], fontSize: 13),
          ),
        ],
      ),
    );
  }
}