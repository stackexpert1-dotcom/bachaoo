import 'dart:async';

import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class BachaooPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final void Function(PhoneNumber)? onChanged;
  final void Function(Country)? onCountryChanged;
  final String initialCountryCode;
  final bool enabled;
  final String label;

  const BachaooPhoneField({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
    this.onCountryChanged,
    this.initialCountryCode = 'PK',
    this.enabled = true,
    this.label = 'Phone number',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- Label — matches CustomTextFormField ---
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            fontSize: AppDimensions.fontSizeBodyMedium,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingXSmall),

        IntlPhoneField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          onCountryChanged: onCountryChanged,
          initialCountryCode: initialCountryCode,
          enabled: enabled,
          showDropdownIcon: false,
          flagsButtonMargin: const EdgeInsets.only(left: 4),
          dropdownIconPosition: IconPosition.trailing,
          cursorColor: AppColors.primaryColor,

          // Text typed by the user
          style: const TextStyle(
            color: AppColors.inputText,
            fontSize: AppDimensions.fontSizeBodyLarge,
          ),

          // "+92" next to the flag
          dropdownTextStyle: const TextStyle(
            color: AppColors.inputText,
            fontSize: AppDimensions.fontSizeBodyLarge,
            fontWeight: FontWeight.w700,
          ),

          decoration: InputDecoration(
            hintText: '3XX XXXXXXX',
            hintStyle: const TextStyle(
              color: AppColors.inputHint,
              fontSize: AppDimensions.fontSizeBodyLarge,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: AppColors.inputBackground,
            contentPadding: AppDimensions.inputPadding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.inputBorder,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.inputBorder,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: AppDimensions.inputFocusedBorderWidth,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.inputErrorBorder,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
              borderSide: const BorderSide(
                color: AppColors.inputErrorBorder,
                width: AppDimensions.inputFocusedBorderWidth,
              ),
            ),
            errorStyle: const TextStyle(
              fontSize: AppDimensions.fontSizeCaption,
              color: AppColors.inputErrorBorder,
            ),
          ),

          // --- Country picker dialog ---
          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: AppColors.surfaceColor,
            countryNameStyle: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppDimensions.fontSizeBodyMedium,
              fontWeight: FontWeight.w600,
            ),
            countryCodeStyle: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppDimensions.fontSizeBodyMedium,
            ),
            searchFieldInputDecoration: InputDecoration(
              hintText: 'Search country',
              hintStyle: const TextStyle(color: AppColors.inputHint),
              prefixIcon: const Icon(Icons.search, color: AppColors.iconMuted),
              filled: true,
              fillColor: AppColors.surfaceVariant,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: const BorderSide(color: AppColors.inputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                borderSide: const BorderSide(
                  color: AppColors.primaryColor,
                  width: AppDimensions.inputFocusedBorderWidth,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
