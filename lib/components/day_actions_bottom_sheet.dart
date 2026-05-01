import 'package:clone_mobile_app/components/bottom_sheet_drag_handle.dart';
import 'package:clone_mobile_app/constants/action_items.dart';
import 'package:flutter/material.dart';

class DayActionsBottomSheet extends StatelessWidget {
  const DayActionsBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const DayActionsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetDragHandle(),
          const SizedBox(height: 16),
          ...ActionItems.items.map(
            (a) => ListTile(
              dense: true,
              leading: _ActionIcon(icon: a.$2, color: a.$3),
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

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _ActionIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 17),
    );
  }
}