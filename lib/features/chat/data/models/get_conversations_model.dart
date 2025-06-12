class GetConversationsModel {
  String? conversationId;
  String? counterpartName;
  String? counterpartImage;
  String? lastMessageContent;
  String? lastMessageSentAt;

  GetConversationsModel(
      {this.conversationId,
      this.counterpartName,
      this.counterpartImage,
      this.lastMessageContent,
      this.lastMessageSentAt});

  GetConversationsModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversation_id'];
    counterpartName = json['counterpart_name'];
    counterpartImage = json['counterpart_image'];
    lastMessageContent = json['last_message_content'];
    lastMessageSentAt = json['last_message_sent_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversation_id'] = conversationId;
    data['counterpart_name'] = counterpartName;
    data['counterpart_image'] = counterpartImage;
    data['last_message_content'] = lastMessageContent;
    data['last_message_sent_at'] = lastMessageSentAt;
    return data;
  }
}
