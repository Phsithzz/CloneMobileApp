import 'package:clone_mobile_app/components/bottom_sheet_drag_handle.dart';
import 'package:clone_mobile_app/constants/legend_items.dart';
import 'package:flutter/material.dart';

class LegendBottomSheet extends StatelessWidget {
  const LegendBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const LegendBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetDragHandle(),
          const SizedBox(height: 16),
          const Text(
            'คำอธิบายสัญลักษณ์',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ...LegendItems.items.map(
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
    );
  }
}