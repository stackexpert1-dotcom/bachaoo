import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reset link sent to ${_emailController.text}')),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDimensions.verticalSpace12,

              // --- Back button ---
              const CustomBackButton(size: 36, iconSize: 22),

              AppDimensions.verticalSpace28,

              // --- Title + subtitle ---
              AppText.displayLarge('Forgot Password'),
              const SizedBox(height: 6),
              AppText.bodyLarge(
                "Enter the email linked to your card and we'll send you "
                'a link to reset your password.',
                color: AppColors.textSecondary,
              ),

              AppDimensions.verticalSpace24,

              // --- Form ---
              Form(
                key: _formKey,
                child: CustomTextFormField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),

              AppDimensions.verticalSpace24,

              // --- Submit ---
              PrimaryButton(
                label: 'Send Reset Link',
                onTap: _isLoading ? null : _submit,
                isLoading: _isLoading,
              ),

              AppDimensions.verticalSpace24,
            ],
          ),
        ),
      ),
    );
  }
}
