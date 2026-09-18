import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppleAuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const AppleAuthButton({
    super.key,
    this.label = 'Continue with Apple',
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeightLarge,
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: InkWell(
          onTap: isLoading ? null : onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.white,
                        size: AppDimensions.iconSizeMedium,
                      ),
                      const SizedBox(width: AppDimensions.spacingSmall),
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyLarge,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
