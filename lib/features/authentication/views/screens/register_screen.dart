import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/authentication/views/widgets/phone_text_field.dart';
import 'package:bachaoo/features/authentication/views/widgets/referal_code_card.dart';
import 'package:bachaoo/features/authentication/views/widgets/step_progressbar.dart';
import 'package:bachaoo/features/authentication/views/widgets/terms_agreement_text.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController referalCodeController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      appBar: AppBar(
        leading: const Center(child: CustomBackButton(size: 36, iconSize: 22)),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Create your card',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Text(
              'Step 1 of 2',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppDimensions.fontSizeBodySmall,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.appBackroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AppDimensions.verticalSpace20,
              // --- Progress bar: Step 1 of 2 — empty, nothing completed yet ---
              const StepProgressBar(currentStep: 1, totalSteps: 2),
              AppDimensions.verticalSpace28,
              CustomTextFormField(
                label: 'Your Name',
                hintText: 'Full Name',
                controller: nameController,
              ),
              AppDimensions.verticalSpace24,
              CustomTextFormField(
                label: 'Email Address',
                hintText: 'yourname@gmail.com',
                controller: emailController,
              ),
              AppDimensions.verticalSpace24,
              BachaooPhoneField(controller: phoneController),
              AppDimensions.verticalSpace24,
              CustomTextFormField(
                label: 'Password',
                hintText: 'At lease 8 Characters',
                controller: passwordController,
                isPassword: true,
              ),
              AppDimensions.verticalSpace24,
              CustomTextFormField(
                label: 'Confirm Password',
                hintText: 'Repeat Password',
                controller: confirmPasswordController,
                isPassword: true,
              ),
              AppDimensions.verticalSpace24,
              ReferralCodeCard(
                referredMe: true,
                onReferredChanged: (val) {},
                codeController: referalCodeController,
              ),
              AppDimensions.verticalSpace24,
              TermsAgreementSection(
                agreed: false,
                onAgreedChanged: (val) {},
                onTermsTap: () =>
                    Get.toNamed(AppRoutes.policiesScreen, arguments: 'terms'),
                onPrivacyTap: () =>
                    Get.toNamed(AppRoutes.policiesScreen, arguments: 'privacy'),
                onContinue: () {},
              ),

              AppDimensions.verticalSpace20,

              // --- Continue ---
              PrimaryButton(
                label: 'Continue',
                onTap: () {
                  Get.toNamed(
                    AppRoutes.otpScreen,
                    arguments: {
                      'phoneNumber': phoneController.text,
                      'onChangeNumber': () => Get.back(),
                      'onVerifyCode': (String code) async {
                        Get.offAllNamed(AppRoutes.onboardingScreen);
                      },
                      'onResendCode': () async {
                        Get.snackbar(
                          'Code sent',
                          'A new 4-digit code was sent to your phone.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                    },
                  );
                },
              ),
              AppDimensions.verticalSpace24,
            ],
          ),
        ),
      ),
    );
  }
}
