import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/profile/widgets/account_list_item.dart';
import 'package:bachaoo/features/profile/widgets/profile_avatar.dart';
import 'package:bachaoo/features/profile/widgets/status_chip.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _firstNameController = TextEditingController(text: 'Shafqat');
  final _lastNameController = TextEditingController(text: 'Ullah');
  final _emailController = TextEditingController(
    text: 'shafqat@brandreturns.com',
  );
  final _phoneController = TextEditingController(text: '+92 304 7665454');
  final _cityController = TextEditingController(text: 'Sargodha');

  bool _notificationsEnabled = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                  const Expanded(
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: AppDimensions.fontSizeHeadlineSmall,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacingXSmall,
                        vertical: AppDimensions.spacingXXSmall,
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyLarge,
                        ),
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
                  AppDimensions.spacingXLarge,
                  AppDimensions.pagePadding,
                  AppDimensions.spacingXLarge,
                ),
                children: [
                  // avatar + chips
                  Center(
                    child: ProfileAvatarWithBadge(
                      initials: 'SU',
                      onEditTap: () {},
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spacingMedium),
                  const Center(
                    child: Wrap(
                      spacing: AppDimensions.spacingSmall,
                      children: [
                        StatusChip(
                          label: 'Verified',
                          background: AppColors.successLight,
                          textColor: AppColors.successDark,
                        ),
                        StatusChip(
                          label: 'Standard',
                          background: AppColors.warningLight,
                          textColor: AppColors.warningDark,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingLarge),

                  // first / last name
                  CustomTextFormField(
                    label: 'Name',
                    controller: _firstNameController,
                  ),
                  const SizedBox(height: AppDimensions.spacingSmall),

                  CustomTextFormField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.check_rounded,
                        color: AppColors.success,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingSmall),

                  CustomTextFormField(
                    label: 'Phone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.check_rounded,
                        color: AppColors.success,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingSmall),

                  CustomTextFormField(
                    label: 'City',
                    controller: _cityController,
                    readOnly: true,
                    onTap: () {},
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.iconMuted,
                        size: 22,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingXXLarge),

                  const Text(
                    'Account',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSizeHeadlineXSmall,
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spacingSmall),

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
                          title: 'Change password',
                          onTap: () {
                            Get.toNamed(AppRoutes.changePasswordScreen);
                          },
                        ),
                        const AccountDivider(),
                        AccountListItem(
                          title: 'Notifications',
                          showSwitch: true,
                          switchValue: _notificationsEnabled,
                          onSwitchChanged: (v) {
                            setState(() => _notificationsEnabled = v);
                          },
                        ),
                        const AccountDivider(),
                        AccountListItem(
                          title: 'Delete Account',
                          titleColor: AppColors.error,
                          showChevron: false,
                          onTap: () {},
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
