class PaymentsHistoryModel {
  String? paymentId;
  String? status;
  String? price;
  String? createdAt;
  String? patient_name;

  PaymentsHistoryModel({
    this.paymentId,
    this.status,
    this.price,
    this.createdAt,
    this.patient_name,
  });

  PaymentsHistoryModel.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    status = json['status'];
    price = json['price'];
    createdAt = json['created_at'];
    patient_name = json['patient_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    data['status'] = status;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['patient_name'] = patient_name;
    return data;
  }
}
