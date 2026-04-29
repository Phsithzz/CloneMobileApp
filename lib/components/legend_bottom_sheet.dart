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
    final items = [
      _LegendItem(Icons.circle, const Color(0xFFD84315), 'สถานะการทำงานผิดปกติ'),
      _LegendItem(Icons.access_time, Colors.black54, 'ทำงานล่วงเวลา'),
      _LegendItem(Icons.description_outlined, Colors.black54, 'เอกสาร'),
      _LegendItem(Icons.event_note_outlined, Colors.black54, 'กิจกรรม'),
      _LegendItem(Icons.campaign_outlined, Colors.black54, 'ประกาศ'),
      _LegendItem(Icons.swap_horiz, Colors.black54, 'สลับกะ'),
      _LegendItem(Icons.people_outline, Colors.black54, 'นัดสัมภาษณ์'),
      _LegendItem(Icons.cake_outlined, Colors.black54, 'วันเกิด'),
      _LegendItem(Icons.play_circle_outline, Colors.black54, 'เริ่มงานวันแรก'),
      _LegendItem(Icons.stop_circle_outlined, Colors.black54, 'สิ้นสุดการทำงาน'),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Icon(item.icon, color: item.color, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      item.label,
                      style: const TextStyle(fontSize: 14, color: Color(0xFF424242)),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _LegendItem {
  final IconData icon;
  final Color color;
  final String label;
  const _LegendItem(this.icon, this.color, this.label);
}
