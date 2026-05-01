import 'package:flutter/material.dart';

class ActionItems {
  ActionItems._();

  static const List<(String, IconData, Color)> items = [
    ('ลางาน', Icons.beach_access_outlined, Color(0xFFD84315)),
    ('ปฏิบัติงานนอกสถานที่', Icons.map_outlined, Color(0xFFD84315)),
    ('ล่วงเวลา', Icons.access_time, Color(0xFFD84315)),
    ('รับรองเวลา', Icons.person_add_outlined, Color(0xFF78909C)),
    ('ขอสะสมเวลา', Icons.person_remove_outlined, Color(0xFF78909C)),
    ('แลกเวลา', Icons.swap_horiz, Color(0xFF78909C)),
    ('ค่าใช้จ่าย', Icons.attach_money, Color(0xFF78909C)),
  ];
}