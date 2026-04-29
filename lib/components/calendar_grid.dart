import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clone_mobile_app/bloc/calendar_bloc.dart';
import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:clone_mobile_app/utils/thai_date_util.dart';
import 'calendar_day_cell.dart';

class CalendarGrid extends StatelessWidget {
  const CalendarGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SizedBox(
            height: 320,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final now = DateTime.now();

        return Column(
          children: [
            // ── Header: month nav ──────────────────────────────────────────
            _buildMonthHeader(context, state),

            const SizedBox(height: 8),

            // ── Weekday labels ─────────────────────────────────────────────
            _buildWeekdayRow(),

            const SizedBox(height: 4),

            // ── Calendar grid ──────────────────────────────────────────────
            _buildGrid(context, state, now),
          ],
        );
      },
    );
  }

  Widget _buildMonthHeader(BuildContext context, CalendarState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Prev month
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 22),
            onPressed: () =>
                context.read<CalendarBloc>().add(const NavigateMonthEvent(-1)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          // Month + Year (Thai)
          Expanded(
            child: Center(
              child: Text(
                ThaiDateUtils.monthYearThai(state.year, state.month),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
            ),
          ),

          // Next month
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 22),
            onPressed: () =>
                context.read<CalendarBloc>().add(const NavigateMonthEvent(1)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          const SizedBox(width: 4),
          // Help + Add icons
          IconButton(
            icon: const Icon(Icons.help_outline, size: 20),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.add, size: 22),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayRow() {
    const days = ThaiDateUtils.thaiShortDays;
    const colors = [
      Color(0xFF424242), // จ
      Color(0xFF424242), // อ
      Color(0xFF424242), // พ
      Color(0xFF424242), // พฤ
      Color(0xFF424242), // ศ
      Color(0xFF9E9E9E), // ส
      Color(0xFF9E9E9E), // อา
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: List.generate(7, (i) {
          return Expanded(
            child: Center(
              child: Text(
                days[i],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: colors[i],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, CalendarState state, DateTime now) {
    final days = state.days;
    final rows = (days.length / 7).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: List.generate(rows, (rowIndex) {
          return SizedBox(
            height: 58,
            child: Row(
              children: List.generate(7, (colIndex) {
                final index = rowIndex * 7 + colIndex;
                if (index >= days.length)
                  return const Expanded(child: SizedBox());

                final day = days[index];
                final isCurrentMonth =
                    day.date.month == state.month &&
                    day.date.year == state.year;
                final isSelected =
                    state.selectedDate != null &&
                    _sameDay(day.date, state.selectedDate!);
                final isToday = _sameDay(day.date, now);

                return Expanded(
                  child: CalendarDayCell(
                    day: day,
                    isCurrentMonth: isCurrentMonth,
                    isSelected: isSelected,
                    isToday: isToday,
                    onTap: () {
                      context.read<CalendarBloc>().add(
                        SelectDayEvent(day.date),
                      );
                    },
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
