class GetAllMessagesForAspecificConversationModel {
 String? id;
  String? conversationId;
  String? senderType;
  String? senderId;
  String? content;
  String? sentAt;

  GetAllMessagesForAspecificConversationModel(
      {this.id,
      this.conversationId,
      this.senderType,
      this.senderId,
      this.content,
      this.sentAt});

  GetAllMessagesForAspecificConversationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    senderType = json['sender_type'];
    senderId = json['sender_id'];
    content = json['content'];
    sentAt = json['sent_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['conversation_id'] = conversationId;
    data['sender_type'] = senderType;
    data['sender_id'] = senderId;
    data['content'] = content;
    data['sent_at'] = sentAt;
    return data;
  }
}
