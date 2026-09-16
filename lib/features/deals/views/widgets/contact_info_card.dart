import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class ContactInfoCard extends StatelessWidget {
  final String name;
  final String role;
  final String phone;
  final String address;
  final VoidCallback? onCallTap;

  const ContactInfoCard({
    super.key,
    required this.name,
    required this.role,
    required this.phone,
    required this.address,
    this.onCallTap,
  });

  // Helper to launch phone call if no custom handler is provided
  void _defaultCall(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: phone);
    try {
      // ignore: avoid_dynamic_calls
      await launchUrl(uri);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not launch dialer: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCallTap ?? () => _defaultCall(context),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppDimensions.fontSizeBodyLarge,
                    ),
                    children: [TextSpan(text: '$name, $role · ')],
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                AppText.titleSmall('Phone: '),
                // const Icon(
                //   Icons.phone,
                //   size: 20,
                //   color: AppColors.primaryColor,
                // ),
                const SizedBox(width: 2),
                AppText.titleSmall(phone, color: AppColors.primaryColor),
              ],
            ),
            const SizedBox(height: 4),
            AppText.bodyMedium(address),
          ],
        ),
      ),
    );
  }
}
