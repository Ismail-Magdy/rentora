class ChatScreenArgs {
  final String chatId;
  final String? receiverName;
  final String? receiverAvatar;
  final String? itemTitle;

  const ChatScreenArgs({
    required this.chatId,
    this.receiverName,
    this.receiverAvatar,
    this.itemTitle,
  });
}
