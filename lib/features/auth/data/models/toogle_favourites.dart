class ToogleFavouritesModel {
  String? status;
  String? action;
  String? message;

  ToogleFavouritesModel({this.status, this.action, this.message});

  ToogleFavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    action = json['action'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['action'] = action;
    data['message'] = message;
    return data;
  }
}
