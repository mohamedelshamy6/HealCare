class PaymentsHistoryModel {
  int? paymentId;
  String? status;
  String? price;
  String? createdAt;

  PaymentsHistoryModel({this.paymentId, this.status, this.price, this.createdAt});

  PaymentsHistoryModel.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    status = json['status'];
    price = json['price'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_id'] = paymentId;
    data['status'] = status;
    data['price'] = price;
    data['created_at'] = createdAt;
    return data;
  }
}
