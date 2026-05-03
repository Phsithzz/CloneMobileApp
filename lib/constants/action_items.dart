import 'package:flutter/material.dart';

class ActionItems {
  ActionItems._();

  static const List<(String, IconData, Color)> items = [
    ('ลางาน', Icons.event_busy, Color(0xffF45B26)),
    ('ปฏิบัติงานนอกสถานที่', Icons.location_on, Color(0xffF45B26)),
    ('ล่วงเวลา', Icons.access_time_filled, Color(0xffF45B26)),
    ('รับรองเวลา', Icons.check_circle, Color(0xffF45B26)),
    ('ขอสะสมเวลา', Icons.add_circle, Color(0xffF45B26)),
    ('แลกเวลา', Icons.swap_horiz, Color(0xffF45B26)),
    ('ค่าใช้จ่าย', Icons.attach_money, Color(0xffF45B26)),
  ];
}
