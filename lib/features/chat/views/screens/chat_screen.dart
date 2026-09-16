import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/chat/models/chat_message_model.dart';
import 'package:bachaoo/features/chat/models/conversational_model.dart';
import 'package:bachaoo/features/chat/views/widgets/chat_bubble.dart';
import 'package:bachaoo/features/chat/views/widgets/chat_data_divider.dart';
import 'package:bachaoo/features/chat/views/widgets/chat_input_bar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final ConversationModel conversation;

  const ChatScreen({super.key, required this.conversation});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  late final List<ChatMessageModel> _messages = [
    ChatMessageModel(
      text: 'Hi',
      isMe: true,
      timestamp: DateTime(2026, 9, 1, 14, 57),
    ),
    ChatMessageModel(
      text: 'hello, how can i help you?',
      isMe: false,
      timestamp: DateTime(2026, 9, 2, 12, 42),
    ),
    ChatMessageModel(
      text: 'can i chat with restaurants? or only can with bachaoo team',
      isMe: true,
      timestamp: DateTime.now(),
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(
        ChatMessageModel(text: text, isMe: true, timestamp: DateTime.now()),
      );
    });
    _messageController.clear();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    if (isToday) return 'Today';
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header ---
            Container(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.pagePadding,
                AppDimensions.spacingSmall,
                AppDimensions.pagePadding,
                AppDimensions.spacingSmall,
              ),
              decoration: const BoxDecoration(
                color: AppColors.surfaceColor,
                border: Border(
                  bottom: BorderSide(color: AppColors.borderColor),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    color: AppColors.appBackroundColor,
                    // shape: const CircleBorder(),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusSmall,
                    ),
                    child: InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      // customBorder: const CircleBorder(),

                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.textPrimary,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  // CustomBackButton(),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  Container(
                    width: AppDimensions.avatarMedium,
                    height: AppDimensions.avatarMedium,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                    ),
                    child: Text(
                      widget.conversation.avatarInitials ?? '?',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeBodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  Expanded(
                    child: Text(
                      widget.conversation.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeTitleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- Messages ---
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.pagePadding,
                  vertical: AppDimensions.spacingMedium,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final showDateDivider =
                      index == 0 ||
                      _formatDate(message.timestamp) !=
                          _formatDate(_messages[index - 1].timestamp);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (showDateDivider)
                        ChatDateDivider(label: _formatDate(message.timestamp)),
                      ChatBubble(
                        text: message.text,
                        isMe: message.isMe,
                        timeLabel: _formatTime(message.timestamp),
                      ),
                    ],
                  );
                },
              ),
            ),

            ChatInputBar(controller: _messageController, onSend: _handleSend),
          ],
        ),
      ),
    );
  }
}
