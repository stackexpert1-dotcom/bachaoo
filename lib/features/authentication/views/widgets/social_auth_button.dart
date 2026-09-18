import 'package:bachaoo/features/authentication/views/widgets/apple_auth_button.dart';
import 'package:bachaoo/features/authentication/views/widgets/google_auth_button.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final bool isLoading;

  const SocialAuthButton({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

    return isIOS
        ? AppleAuthButton(onTap: onAppleTap, isLoading: isLoading)
        : GoogleAuthButton(onTap: onGoogleTap, isLoading: isLoading);
  }
}
