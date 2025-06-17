class CreateConversationModel {
  String? message;
  String? conversationId;

  CreateConversationModel({this.message, this.conversationId});

  CreateConversationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    conversationId = json['conversation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['conversation_id'] = conversationId;
    return data;
  }
}
