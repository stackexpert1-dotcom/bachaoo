class ConversationModel {
  final String id;
  final String name;
  final String lastMessage;
  final String timeLabel;
  final bool hasUnread;
  final String? avatarUrl; // null falls back to initials avatar
  final String? avatarInitials;

  const ConversationModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.timeLabel,
    this.hasUnread = false,
    this.avatarUrl,
    this.avatarInitials,
  });
}
