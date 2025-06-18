class GetConversationsModel {
 String? conversationId;
  String? doctorId;
  String? patientId;
  String? conversationCreatedAt;
  String? lastMessageContent;
  String? lastMessageSentAt;
  String? lastMessageSenderType;
  String? lastMessageSenderId;
  String? senderUsername;
  String? senderUserImage;

  GetConversationsModel(
      {this.conversationId,
      this.doctorId,
      this.patientId,
      this.conversationCreatedAt,
      this.lastMessageContent,
      this.lastMessageSentAt,
      this.lastMessageSenderType,
      this.lastMessageSenderId,
      this.senderUsername,
      this.senderUserImage});

  GetConversationsModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversation_id'];
    doctorId = json['doctor_id'];
    patientId = json['patient_id'];
    conversationCreatedAt = json['conversation_created_at'];
    lastMessageContent = json['last_message_content'];
    lastMessageSentAt = json['last_message_sent_at'];
    lastMessageSenderType = json['last_message_sender_type'];
    lastMessageSenderId = json['last_message_sender_id'];
    senderUsername = json['sender_username'];
    senderUserImage = json['sender_user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversation_id'] = conversationId;
    data['doctor_id'] = doctorId;
    data['patient_id'] = patientId;
    data['conversation_created_at'] = conversationCreatedAt;
    data['last_message_content'] = lastMessageContent;
    data['last_message_sent_at'] = lastMessageSentAt;
    data['last_message_sender_type'] = lastMessageSenderType;
    data['last_message_sender_id'] = lastMessageSenderId;
    data['sender_username'] = senderUsername;
    data['sender_user_image'] = senderUserImage;
    return data;
  }
}
