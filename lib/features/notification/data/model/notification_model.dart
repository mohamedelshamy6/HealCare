class NotificationModel {
  String? message;
  String? createdAt;

  NotificationModel({this.message, this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}
