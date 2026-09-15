import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onAttachImage;
  final VoidCallback? onAttachFile;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.onAttachImage,
    this.onAttachFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.pagePadding,
        AppDimensions.spacingSmall,
        AppDimensions.pagePadding,
        AppDimensions.spacingSmall,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 48,
                  maxHeight: 120,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                ),
                decoration: BoxDecoration(
                  color: AppColors.appBackroundColor,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusXLarge,
                  ),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        minLines: 1,
                        maxLines: 5,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppDimensions.fontSizeBodyLarge,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: AppColors.inputHint),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(
                        Icons.image_outlined,
                        color: AppColors.iconMuted,
                        size: AppDimensions.inputIconSize,
                      ),
                      onPressed: onAttachImage,
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(
                        Icons.attach_file_rounded,
                        color: AppColors.iconMuted,
                        size: AppDimensions.inputIconSize,
                      ),
                      onPressed: onAttachFile,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacingSmall),
            Material(
              color: AppColors.primaryColor,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onSend,
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    color: AppColors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
