import 'package:flutter/material.dart';

class LegendItems {
  LegendItems._();

  static const List<(IconData, Color, String)> items = [
    (Icons.error, Colors.red, 'สถานะการทำงานผิดปกติ'),
    (Icons.access_time, Colors.black, 'ทำงานล่วงเวลา'),
    (Icons.description, Colors.black, 'เอกสาร'),
    (Icons.event, Colors.black, 'กิจกรรม'),
    (Icons.campaign, Colors.black, 'ประกาศ'),
    (Icons.receipt_long, Colors.black, 'สลับกะ'),
    (Icons.people, Colors.blueAccent, 'นัดสัมภาษณ์'),
    (Icons.cake, Colors.orangeAccent, 'วันเกิด'),
    (Icons.celebration, Colors.orangeAccent, 'เริ่มงานวันแรก'),
    (Icons.logout, Colors.red, 'สิ้นสุดการทำงาน'),
  ];
}
