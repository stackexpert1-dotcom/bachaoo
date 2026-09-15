import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/features/refer_and_earn/views/widgets/dashed_border.dart';
import 'package:flutter/material.dart';

import '../../models/share_channel_model.dart';

class ReferralCodeBox extends StatelessWidget {
  final String label;
  final String code;
  final VoidCallback onCopy;
  final List<ShareChannelModel> channels;
  final ValueChanged<ShareChannelModel> onChannelTap;

  const ReferralCodeBox({
    super.key,
    required this.code,
    required this.onCopy,
    required this.channels,
    required this.onChannelTap,
    this.label = 'Your code',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DashedBorderContainer(
          color: AppColors.primaryColor.withValues(alpha: 0.4),
          borderRadius: 16,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    code,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.textOnPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: onCopy,
                  child: const Text(
                    'Copy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (channels.isNotEmpty)
          Row(
            children: [
              for (final channel in channels) ...[
                Expanded(
                  flex: channel.isIconOnly ? 0 : 1,
                  child: _ShareChannelButton(
                    channel: channel,
                    onTap: () => onChannelTap(channel),
                  ),
                ),
                if (channel != channels.last) const SizedBox(width: 10),
              ],
            ],
          ),
      ],
    );
  }
}

class _ShareChannelButton extends StatelessWidget {
  final ShareChannelModel channel;
  final VoidCallback onTap;

  const _ShareChannelButton({required this.channel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        padding: EdgeInsets.symmetric(
          vertical: 14,
          horizontal: channel.isIconOnly ? 14 : 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (channel.faIcon != null)
            SizedBox(width: 18, height: 18, child: channel.faIcon)
          else
            Icon(
              channel.icon!,
              size: 18,
              color: channel.accentColor ?? Colors.black87,
            ),
          if (!channel.isIconOnly) ...[
            const SizedBox(width: 8),
            Text(
              channel.label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
    );
  }
}
