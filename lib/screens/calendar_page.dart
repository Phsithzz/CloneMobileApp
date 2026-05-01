import 'package:clone_mobile_app/bloc/calendar_bloc.dart';
import 'package:clone_mobile_app/components/calendar_day_cell.dart';
import 'package:clone_mobile_app/components/calendar_day_panel.dart';
import 'package:clone_mobile_app/components/calendar_weekday_header.dart';
import 'package:clone_mobile_app/components/day_actions_bottom_sheet.dart';
import 'package:clone_mobile_app/components/legend_bottom_sheet.dart';
import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:clone_mobile_app/theme/theme_cubit.dart';
import 'package:clone_mobile_app/utils/thai_date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: _buildAppBar(context, state),
          body: Column(
            children: [
              const CalendarWeekdayHeader(),
              _buildCalendarGrid(context, state),
              const Divider(height: 1),
              Expanded(
                child: CalendarDayPanel(
                  state: state,
                  onShiftTap: (day) => DayActionsBottomSheet.show(context),
                  onEventTap: (event) => DayActionsBottomSheet.show(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, CalendarState state) {
    return AppBar(
      centerTitle: true,
      title: Text(
        ThaiDateUtils.monthYearThai(state.year, state.month),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
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
          onPressed: () =>
              context.read<CalendarBloc>().add(const NavigateMonthEvent(-1)),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () =>
              context.read<CalendarBloc>().add(const NavigateMonthEvent(1)),
        ),
        IconButton(
          icon: const Icon(Icons.help_outline),
          onPressed: () => LegendBottomSheet.show(context),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCalendarGrid(BuildContext context, CalendarState state) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 0.65,
      ),
      itemCount: state.days.length,
      itemBuilder: (context, index) {
        final day = state.days[index];
        return CalendarDayCell(
          day: day,
          isCurrentMonth: day.date.month == state.month,
          isSelected:
              state.selectedDate != null &&
              day.date.day == state.selectedDate!.day &&
              day.date.month == state.selectedDate!.month,
          isToday:
              day.date.day == DateTime.now().day &&
              day.date.month == DateTime.now().month &&
              day.date.year == DateTime.now().year,
          onTap: () =>
              context.read<CalendarBloc>().add(SelectDayEvent(day.date)),
        );
      },
    );
  }
}