import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/day_model.dart';

class ShiftBottomSheet extends StatelessWidget {
  final DayModel day;

  const ShiftBottomSheet({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('EEE, d MMMM yyyy').format(day.date);

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 20),
          Text(formattedDate, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Row(
              children: [
                Icon(day.isHoliday ? Icons.beach_access : Icons.work, color: Colors.deepOrange),
                const SizedBox(width: 16),
                Expanded(child: Text(day.details, style: const TextStyle(fontSize: 16))),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}