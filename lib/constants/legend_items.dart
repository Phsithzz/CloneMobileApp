
import 'package:flutter/material.dart';

class LegendItems {
  LegendItems._();

  static const List<(IconData, Color, String)> items = [
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
}