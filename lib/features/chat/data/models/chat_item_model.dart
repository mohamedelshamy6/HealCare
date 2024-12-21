class ChatItemModel {
  final bool? isShown;
  final String? name;
  final String? receivedMessage;
  final String? sendedMessage;
  final String? time;

  ChatItemModel(
      {required this.isShown,
      required this.name,
      required this.receivedMessage,
      required this.sendedMessage,
      required this.time});
}
