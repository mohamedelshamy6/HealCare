class AppointementScheduleModel {
  final Map<String, List<TimeSlot>> days;

  AppointementScheduleModel({required this.days});

  factory AppointementScheduleModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<TimeSlot>> parsedDays = {};

    json.forEach((date, slotsJson) {
      if (slotsJson is List) {
        parsedDays[date] = slotsJson.map((slot) {
          if (slot is Map<String, dynamic>) {
            return TimeSlot.fromJson(slot);
          }
          throw FormatException('Invalid slot format');
        }).toList();
      }
    });

    return AppointementScheduleModel(days: parsedDays);
  }

  Map<String, dynamic> toJson() {
    return days.map((date, slots) => MapEntry(
          date,
          slots.map((slot) => slot.toJson()).toList(),
        ));
  }
}

class TimeSlot {
  final String time;
  final bool isBooked;

  TimeSlot({required this.time, required this.isBooked});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      time: json['time'] as String,
      isBooked: json['is_booked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'is_booked': isBooked,
    };
  }
}
