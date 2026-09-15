import 'package:bachaoo/common_widgets/checkbox.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAgreementSection extends StatelessWidget {
  final bool agreed;
  final ValueChanged<bool> onAgreedChanged;
  final VoidCallback onContinue;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;
  final bool isLoading;

  const TermsAgreementSection({
    super.key,
    required this.agreed,
    required this.onAgreedChanged,
    required this.onContinue,
    required this.onTermsTap,
    required this.onPrivacyTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      color: AppColors.textSecondary,
      fontSize: AppDimensions.fontSizeBodySmall,
      height: AppDimensions.lineHeightNormal,
    );
    const linkStyle = TextStyle(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w700,
      fontSize: AppDimensions.fontSizeBodyMedium,
      height: AppDimensions.lineHeightNormal,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Checkbox + rich agreement text ---
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCheckbox(value: agreed, onChanged: onAgreedChanged),
            const SizedBox(width: AppDimensions.spacingSmall),
            Expanded(
              child: GestureDetector(
                onTap: () => onAgreedChanged(!agreed),
                child: Text.rich(
                  TextSpan(
                    style: bodyStyle,
                    children: [
                      const TextSpan(text: 'I agree to the '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = onPrivacyTap,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
