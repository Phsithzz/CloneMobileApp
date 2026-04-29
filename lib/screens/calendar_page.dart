import 'package:clone_mobile_app/bloc/calendar_bloc.dart';
import 'package:clone_mobile_app/components/calendar_day_cell.dart';
import 'package:clone_mobile_app/model/shift_model.dart';

import 'package:clone_mobile_app/theme/theme_cubit.dart';
import 'package:clone_mobile_app/utils/thai_date_util.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            final dt = DateTime(state.year, state.month);
            return Text(
              '${ThaiDateUtils.monthYearThai(state.year, state.month)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        actions: [
          BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) => Row(
              children: [
                IconButton(
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () => context.read<CalendarBloc>().add(
                    const NavigateMonthEvent(-1),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => context.read<CalendarBloc>().add(
                    const NavigateMonthEvent(1),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.help_outline),
                  onPressed: () => _showLegend(context),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _buildDaysOfWeek(context),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 0.65,
                ),
                itemCount: state.days.length,
                itemBuilder: (context, index) {
                  return CalendarDayCell(
                    day: state.days[index],
                    isCurrentMonth: state.days[index].date.month == state.month,
                    isSelected:
                        state.selectedDate != null &&
                        state.days[index].date.day == state.selectedDate!.day &&
                        state.days[index].date.month ==
                            state.selectedDate!.month,
                    isToday:
                        state.days[index].date.day == DateTime.now().day &&
                        state.days[index].date.month == DateTime.now().month &&
                        state.days[index].date.year == DateTime.now().year,
                    onTap: () => context.read<CalendarBloc>().add(
                      SelectDayEvent(state.days[index].date),
                    ),
                  );
                },
              ),

              const Divider(height: 1),
              Expanded(child: _buildDayPanel(context, state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDaysOfWeek(BuildContext context) {
    final days = ['จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส', 'อา'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days
            .map(
              (day) => Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDayPanel(BuildContext context, CalendarState state) {
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

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Text(
                  dateLabel,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.edit_outlined,
                  size: 14,
                  color: Color(0xFF9E9E9E),
                ),
                const Spacer(),
                if (shift != null && shift.startTime.isNotEmpty)
                  GestureDetector(
                    onTap: () => _showActions(context, day),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: shift.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: shift.color.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'เข้างาน ${shift.startTime}',
                        style: TextStyle(
                          fontSize: 12,
                          color: shift.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: hasEvents
                ? ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: day.events.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, indent: 56),
                    itemBuilder: (_, index) =>
                        _buildEventRow(context, day.events[index]),
                  )
                : Center(
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
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventRow(BuildContext context, DayEvent event) {
    final (icon, color) = _iconAndColor(event.type);
    return InkWell(
      onTap: () => _showEventActions(context, event),
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
                color: color.withOpacity(0.1),
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
            if (event.detail != null)
              Row(
                children: [
                  Text(
                    event.detail!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9E9E9E),
                    ),
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
              ),
          ],
        ),
      ),
    );
  }

  void _showLegend(BuildContext context) {
    final items = [
      (Icons.circle, Colors.red, 'สถานะการทำงานผิดปกติ'),
      (Icons.access_time, Colors.black54, 'ทำงานล่วงเวลา'),
      (Icons.description_outlined, Colors.black54, 'เอกสาร'),
      (Icons.event_note_outlined, Colors.black54, 'กิจกรรม'),
      (Icons.campaign_outlined, Colors.black54, 'ประกาศ'),
      (Icons.swap_horiz, Colors.black54, 'สลับกะ'),
      (Icons.people_outline, Colors.black54, 'นัดสัมภาษณ์'),
      (Icons.cake_outlined, Colors.black54, 'วันเกิด'),
      (Icons.play_circle_outline, Colors.black54, 'เริ่มงานวันแรก'),
      (Icons.stop_circle_outlined, Colors.black54, 'สิ้นสุดการทำงาน'),
    ];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const Text(
              'คำอธิบายสัญลักษณ์',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(item.$1, color: item.$2, size: 20),
                    const SizedBox(width: 12),
                    Text(item.$3, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showActions(BuildContext context, CalendarDay day) {
    final actions = [
      ('ลางาน', Icons.beach_access_outlined, const Color(0xFFD84315)),
      ('ปฏิบัติงานนอกสถานที่', Icons.map_outlined, const Color(0xFFD84315)),
      ('ล่วงเวลา', Icons.access_time, const Color(0xFFD84315)),
      ('รับรองเวลา', Icons.person_add_outlined, const Color(0xFF78909C)),
      ('ขอสะสมเวลา', Icons.person_remove_outlined, const Color(0xFF78909C)),
      ('แลกเวลา', Icons.swap_horiz, const Color(0xFF78909C)),
      ('ค่าใช้จ่าย', Icons.attach_money, const Color(0xFF78909C)),
    ];
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Container(
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
            ...actions.map(
              (a) => ListTile(
                dense: true,
                leading: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: a.$3.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(a.$2, color: a.$3, size: 17),
                ),
                title: Text(a.$1, style: const TextStyle(fontSize: 14)),
                contentPadding: EdgeInsets.zero,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventActions(BuildContext context, DayEvent event) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _EventActionSheet(event: event),
    );
  }

  (IconData, Color) _iconAndColor(EventType type) {
    switch (type) {
      case EventType.interview:
        return (Icons.people_outline, const Color(0xFF5C6BC0));
      case EventType.location:
        return (Icons.location_on_outlined, const Color(0xFF42A5F5));
      case EventType.document:
        return (Icons.description_outlined, const Color(0xFF78909C));
      case EventType.activity:
        return (Icons.event_note_outlined, const Color(0xFF78909C));
      case EventType.announcement:
        return (Icons.campaign_outlined, const Color(0xFF78909C));
      case EventType.leave:
        return (Icons.beach_access_outlined, const Color(0xFF66BB6A));
      case EventType.overtime:
        return (Icons.more_time, const Color(0xFFFFA726));
      case EventType.birthday:
        return (Icons.cake_outlined, const Color(0xFFEC407A));
    }
  }
}

class _EventActionSheet extends StatelessWidget {
  final DayEvent event;
  const _EventActionSheet({required this.event});

  @override
  Widget build(BuildContext context) {
    final actions = [
      ('ลางาน', Icons.beach_access_outlined, const Color(0xFFD84315)),
      ('ปฏิบัติงานนอกสถานที่', Icons.map_outlined, const Color(0xFFD84315)),
      ('ล่วงเวลา', Icons.access_time, const Color(0xFFD84315)),
      ('รับรองเวลา', Icons.person_add_outlined, const Color(0xFF78909C)),
      ('ขอสะสมเวลา', Icons.person_remove_outlined, const Color(0xFF78909C)),
      ('แลกเวลา', Icons.swap_horiz, const Color(0xFF78909C)),
      ('ค่าใช้จ่าย', Icons.attach_money, const Color(0xFF78909C)),
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
          ...actions.map(
            (a) => ListTile(
              dense: true,
              leading: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: a.$3.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(a.$2, color: a.$3, size: 17),
              ),
              title: Text(a.$1, style: const TextStyle(fontSize: 14)),
              contentPadding: EdgeInsets.zero,
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
