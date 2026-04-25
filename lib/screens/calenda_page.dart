import 'package:clone_mobile_app/bloc/calenda_bloc.dart';
import 'package:clone_mobile_app/bloc/calenda_state.dart';
import 'package:clone_mobile_app/components/day_cell.dart';
import 'package:clone_mobile_app/theme/theme_cubit.dart';
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
            if (state is CalendarLoaded) {
              return Text(DateFormat('MMMM yyyy').format(state.currentMonth), style: const TextStyle(fontWeight: FontWeight.bold));
            }
            return const Text('Calendar');
          },
        ),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () {}),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
          IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state is CalendarInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CalendarLoaded) {
            return Column(
              children: [
                _buildDaysOfWeek(context),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      childAspectRatio: 0.65, // ปรับให้ทรงคล้าย UI ต้นฉบับ
                    ),
                    itemCount: state.days.length,
                    itemBuilder: (context, index) {
                      return DayCell(day: state.days[index]);
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDaysOfWeek(BuildContext context) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days.map((day) => Text(day, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Theme.of(context).textTheme.bodySmall?.color))).toList(),
      ),
    );
  }
}