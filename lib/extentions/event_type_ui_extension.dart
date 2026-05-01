import 'package:clone_mobile_app/model/shift_model.dart';
import 'package:flutter/material.dart';

extension EventTypeUI on EventType {
  (IconData, Color) get iconAndColor {
    switch (this) {
      case EventType.interview:
        return (Icons.people_outline, const Color(0xFF5C6BC0));
      case EventType.location:
        return (Icons.location_on_outlined, const Color(0xFF42A5F5));
      case EventType.document:
        return (Icons.description_outlined, const Color(0xFF78909C));
      case EventType.activity:
        return (Icons.event_note_outlined, const Color(0xFF78909C));
      case EventType.announcement:
        return (Icons.campaign_outlined, const Color(0xFF78909C));
      case EventType.leave:
        return (Icons.beach_access_outlined, const Color(0xFF66BB6A));
      case EventType.overtime:
        return (Icons.more_time, const Color(0xFFFFA726));
      case EventType.birthday:
        return (Icons.cake_outlined, const Color(0xFFEC407A));
    }
  }
}