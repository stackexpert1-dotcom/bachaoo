import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/authentication/controllers/otp_controller.dart';
import 'package:bachaoo/features/authentication/views/widgets/otp_input_row.dart';
import 'package:bachaoo/features/authentication/views/widgets/step_progressbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends GetView<otpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      appBar: AppBar(
        leading: const Center(child: CustomBackButton(size: 36, iconSize: 22)),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Verify your number',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              'Step 2 of 2',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDimensions.verticalSpace20,
              // --- Progress bar: half filled for step 2 of 2 ---
              const StepProgressBar(currentStep: 2, totalSteps: 2),

              AppDimensions.verticalSpace28,

              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppDimensions.fontSizeBodyLarge,
                    height: AppDimensions.lineHeightRelaxed,
                  ),
                  children: [
                    const TextSpan(text: 'We sent a 4-digit code by SMS to '),
                    TextSpan(
                      text: controller.phoneNumber,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const TextSpan(text: '. '),
                    TextSpan(
                      text: 'Change',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.changeNumber,
                    ),
                  ],
                ),
              ),

              AppDimensions.verticalSpace28,

              OtpInputRow(
                onChanged: controller.onCodeChanged,
                onCompleted: (value) {
                  controller.onCodeChanged(value);
                  controller.verify();
                },
              ),

              AppDimensions.verticalSpace20,

              Center(
                child: Obx(
                  () => GestureDetector(
                    onTap: controller.canResend ? controller.resend : null,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppDimensions.fontSizeBodyLarge,
                        ),
                        children: controller.canResend
                            ? [
                                TextSpan(
                                  text: 'Resend code',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ]
                            : [
                                const TextSpan(text: 'Resend code in '),
                                TextSpan(
                                  text: controller.timerLabel,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ),
                ),
              ),

              AppDimensions.verticalSpace32,

              Obx(
                () => PrimaryButton(
                  label: 'Verify and create card',
                  isEnabled: controller.isCodeComplete,
                  isLoading: controller.isVerifying.value,
                  onTap: controller.verify,
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
