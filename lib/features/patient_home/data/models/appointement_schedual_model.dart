class AppointementScheduleModel {
  final Map<String, List<TimeSlot>> days;

  AppointementScheduleModel({required this.days});

  factory AppointementScheduleModel.fromJson(Map<String, dynamic> json) {
    return AppointementScheduleModel(
      days: json.map((date, slotsJson) => MapEntry(
            date,
            List<TimeSlot>.from(
              slotsJson.map((slot) => TimeSlot.fromJson(slot)),
            ),
          )),
    );
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
      time: json['time'],
      isBooked: json['is_booked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'is_booked': isBooked,
    };
  }
}
