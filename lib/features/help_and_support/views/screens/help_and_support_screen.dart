import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/help_and_support/views/widgets/contact_banner_card.dart';
import 'package:bachaoo/features/help_and_support/views/widgets/contact_method_tile.dart';
import 'package:bachaoo/features/help_and_support/views/widgets/outline_button.dart';
import 'package:bachaoo/features/profile/widgets/account_list_item.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header (same pattern as CartHeaderWidget/ProfileScreen, no trailing action) ---
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
                  CustomBackButton(),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  Expanded(child: AppText.appBarTitle('Help & support')),
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
                  // --- Search ---
                  CustomTextFormField(
                    hintText: 'Search help',
                    fillColor: AppColors.surfaceColor,
                    unfocusedBorderColor: AppColors.borderColor,
                    radius: AppDimensions.radiusXLarge,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.iconMuted,
                      size: AppDimensions.inputIconSize,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingXXLarge),

                  AppText.headlineXSmall('Common questions'),
                  const SizedBox(height: AppDimensions.spacingMedium),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusXLarge,
                      ),
                    ),
                    child: Column(
                      children: const [
                        AccountListItem(
                          title: "The partner didn't accept my card",
                        ),
                        AccountDivider(),
                        AccountListItem(
                          title: "Staff don't have a business code",
                        ),
                        AccountDivider(),
                        AccountListItem(
                          title: "My referral points haven't arrived",
                        ),
                        AccountDivider(),
                        AccountListItem(
                          title: 'How do refunds and cancellations work?',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingXXLarge),

                  AppText.headlineXSmall('Contact us'),
                  const SizedBox(height: AppDimensions.spacingMedium),

                  const ContactBannerCard(
                    imageUrl: 'https://example.com/support-team.jpg',
                    caption: 'Bachaoo support team, Sargodha',
                  ),

                  const SizedBox(height: AppDimensions.spacingMedium),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ContactMethodTile(
                          tag: 'WhatsApp',
                          title: 'Chat with us',
                          subtitle: '9am \u2013 9pm, daily',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingMedium),
                      Expanded(
                        child: ContactMethodTile(
                          tag: 'Call',
                          title: '0300 0000000',
                          subtitle: 'Sargodha office',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.spacingMedium),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.cardRadius,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.titleSmall('Report a problem with a visit'),
                        const SizedBox(height: 4),
                        AppText.bodyMedium(
                          'Tell us which partner and what happened. We follow up within a working day.',
                        ),
                        const SizedBox(height: AppDimensions.spacingMedium),
                        OutlineButton(label: 'Start a report', onTap: () {}),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingXXLarge),

                  AppText.headlineXSmall('Policies'),
                  const SizedBox(height: AppDimensions.spacingMedium),

                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceColor,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusXLarge,
                      ),
                    ),
                    child: Column(
                      children: [
                        AccountListItem(
                          title: 'About Bachaoo',
                          onTap: () => Get.toNamed(
                            AppRoutes.policiesScreen,
                            arguments: 'about',
                          ),
                        ),
                        const AccountDivider(),
                        AccountListItem(
                          title: 'Privacy policy',
                          onTap: () => Get.toNamed(
                            AppRoutes.policiesScreen,
                            arguments: 'privacy',
                          ),
                        ),
                        const AccountDivider(),
                        AccountListItem(
                          title: 'Terms & conditions',
                          onTap: () => Get.toNamed(
                            AppRoutes.policiesScreen,
                            arguments: 'terms',
                          ),
                        ),
                        const AccountDivider(),
                        AccountListItem(
                          title: 'Refund policy',
                          onTap: () => Get.toNamed(
                            AppRoutes.policiesScreen,
                            arguments: 'refund',
                          ),
                        ),
                        const AccountDivider(),
                        AccountListItem(
                          title: 'Cancellation policy',
                          onTap: () => Get.toNamed(
                            AppRoutes.policiesScreen,
                            arguments: 'cancellation',
                          ),
                        ),
                      ],
                    ),
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
