class ChatMessageModel {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  const ChatMessageModel({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}
