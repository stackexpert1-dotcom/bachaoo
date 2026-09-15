import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/chat/models/conversational_model.dart';
import 'package:bachaoo/features/chat/views/screens/chat_screen.dart';
import 'package:bachaoo/features/chat/views/widgets/conversational_tile.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _searchController = TextEditingController();

  final List<ConversationModel> _conversations = const [
    ConversationModel(
      id: 'nawab_royal',
      name: 'Nawab Royal Restaurant',
      lastMessage:
          'NY212: buy one medium pizza, get one free \u2014 members only.',
      timeLabel: 'Today',
      hasUnread: true,
      avatarInitials: 'NR',
    ),
    ConversationModel(
      id: 'bachaoo_team',
      name: 'Bachaoo team',
      lastMessage: 'hello, how can i help you?',
      timeLabel: '2h',
      hasUnread: true,
      avatarInitials: 'BT',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openChat(ConversationModel conversation) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ChatScreen(conversation: conversation)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header ---
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.pagePadding,
                AppDimensions.spacingSmall,
                AppDimensions.pagePadding,
                0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    color: AppColors.surfaceColor,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.textPrimary,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  const Expanded(
                    child: Text(
                      'Inbox',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: AppDimensions.fontSizeHeadlineMedium,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        for (final c in _conversations) {
                          // demo only — replace with real state update
                        }
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacingXSmall,
                        vertical: AppDimensions.spacingXXSmall,
                      ),
                      child: Text(
                        'Mark all read',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.spacingMedium),

            // --- Search ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.pagePadding,
              ),
              child: CustomTextFormField(
                controller: _searchController,
                hintText: 'Search inbox',
                fillColor: AppColors.surfaceColor,
                unfocusedBorderColor: AppColors.borderColor,
                radius: AppDimensions.radiusXLarge,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.iconMuted,
                  size: AppDimensions.inputIconSize,
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spacingLarge),

            // --- Conversation list ---
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.pagePadding,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusXLarge,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: _conversations.length,
                  separatorBuilder: (_, __) => const Divider(
                    height: 1,
                    thickness: AppDimensions.dividerThickness,
                    color: AppColors.borderColor,
                    indent: AppDimensions.paddingMedium,
                    endIndent: AppDimensions.paddingMedium,
                  ),
                  itemBuilder: (context, index) {
                    final conversation = _conversations[index];
                    return ConversationTile(
                      conversation: conversation,
                      onTap: () => _openChat(conversation),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spacingMedium),
          ],
        ),
      ),
    );
  }
}
