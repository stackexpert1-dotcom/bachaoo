import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/checkbox.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/authentication/views/widgets/google_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:bachaoo/routes/bachaoo_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool keepSignedIn = true;

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
              const CustomBackButton(),

              AppDimensions.verticalSpace28,

              // --- Brand badge ---
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusLarge,
                  ),
                ),
                child: const Text(
                  'B',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: AppDimensions.fontSizeHeadlineXLarge,
                  ),
                ),
              ),

              AppDimensions.verticalSpace24,

              // --- Title + subtitle ---
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeDisplaySmall,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Sign in to see your card and deals.',
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeBodyLarge,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
              ),
              AppDimensions.verticalSpace24,

              // --- Fields ---
              CustomTextFormField(
                label: 'Email or phone',
                hintText: 'Enter your email or phone',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              AppDimensions.verticalSpace20,
              CustomTextFormField(
                label: 'Password',
                hintText: 'Enter your password',
                controller: passwordController,
                isPassword: true,
              ),

              AppDimensions.verticalSpace8,

              // --- Keep signed in / Forgot password ---
              Row(
                children: [
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CustomCheckbox(
                      value: keepSignedIn,
                      onChanged: (value) =>
                          setState(() => keepSignedIn = value),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  const Text(
                    'Keep me signed in',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: AppDimensions.fontSizeBodyMedium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeBodyMedium,
                      ),
                    ),
                  ),
                ],
              ),

              AppDimensions.verticalSpace24,

              // --- Sign in ---
              PrimaryButton(label: 'Sign in', onTap: () {}),

              const SizedBox(height: 20),

              // --- Divider ---
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.borderColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: AppColors.textHint,
                        fontSize: AppDimensions.fontSizeBodyMedium,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.borderColor)),
                ],
              ),

              AppDimensions.verticalSpace20,
              // --- Google ---
              GoogleAuthButton(onTap: () {}),

              AppDimensions.verticalSpace24,

              // --- Sign up link ---
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.registerScreen);
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'New here? ',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppDimensions.fontSizeBodyMedium,
                      ),
                      children: [
                        TextSpan(
                          text: 'Create your card',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              AppDimensions.verticalSpace24,
            ],
          ),
        ),
      ),
    );
  }
}
