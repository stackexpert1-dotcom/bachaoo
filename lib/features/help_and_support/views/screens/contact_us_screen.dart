import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/profile/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum ContactActionType { whatsapp, call }

class ContactUsScreen extends StatelessWidget {
  static const _whatsappNumber = '923000000000';
  static const _callNumber = '+923000000000';

  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header (same pattern as HelpSupportScreen) ---
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
                  const CustomBackButton(),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  const Expanded(
                    child: Text(
                      'Contact us',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: AppDimensions.fontSizeHeadlineMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.pagePadding,
                  AppDimensions.spacingLarge,
                  AppDimensions.pagePadding,
                  AppDimensions.spacingXLarge,
                ),
                children: [
                  const Text(
                    'Reach the Bachaoo support team directly \u2014 tap a card below.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppDimensions.fontSizeBodyLarge,
                      height: AppDimensions.lineHeightNormal,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingLarge),
                  const ContactActionCard(
                    type: ContactActionType.whatsapp,
                    title: 'Chat with us',
                    subtitle: '9am \u2013 9pm, daily',
                    rawNumber: _whatsappNumber,
                  ),
                  const SizedBox(height: AppDimensions.spacingMedium),
                  const ContactActionCard(
                    type: ContactActionType.call,
                    title: '0300 0000000',
                    subtitle: 'Sargodha office',
                    rawNumber: _callNumber,
                  ),
                  const SizedBox(height: AppDimensions.spacingXLarge),
                  const ContactInfoCardText(
                    lines: [
                      'Main Zafar Ullah Chowk, Satellite Town, Sargodha',
                      'support@bachaoo.com',
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactInfoCardText extends StatelessWidget {
  final List<String> lines;

  const ContactInfoCardText({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.map((line) {
          return AppText.bodyLarge(line, color: AppColors.textSecondary);
        }).toList(),
      ),
    );
  }
}

class ContactActionCard extends StatelessWidget {
  final ContactActionType type;
  final String title;
  final String subtitle;

  /// WhatsApp: digits only, with country code, no '+' or spaces (e.g. "923000000000").
  /// Call: any phone string url_launcher's tel: scheme accepts (e.g. "+923000000000").
  final String rawNumber;

  const ContactActionCard({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.rawNumber,
  });

  Future<void> _handleTap(BuildContext context) async {
    final uri = type == ContactActionType.whatsapp
        ? Uri.parse('https://wa.me/$rawNumber')
        : Uri(scheme: 'tel', path: rawNumber);

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            type == ContactActionType.whatsapp
                ? "Couldn't open WhatsApp"
                : "Couldn't start the call",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWhatsapp = type == ContactActionType.whatsapp;
    return InkWell(
      onTap: () => _handleTap(context),
      borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        child: Row(
          children: [
            Container(
              width: AppDimensions.avatarMedium,
              height: AppDimensions.avatarMedium,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.successLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: Icon(
                isWhatsapp ? Icons.chat_rounded : Icons.call_rounded,
                color: AppColors.successDark,
                size: AppDimensions.iconSizeMedium,
              ),
            ),
            const SizedBox(width: AppDimensions.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusChip(
                    label: isWhatsapp ? 'WhatsApp' : 'Call',
                    background: AppColors.successLight,
                    textColor: AppColors.successDark,
                  ),
                  const SizedBox(height: AppDimensions.spacingSmall),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: AppDimensions.fontSizeTitleSmall,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: AppDimensions.fontSizeBodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.iconMuted,
              size: AppDimensions.iconSizeMedium,
            ),
          ],
        ),
      ),
    );
  }
}
