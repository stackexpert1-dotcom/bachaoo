import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color unfocusedBorderColor;
  final Color focusedBorderColor;
  final Color fillColor;
  final TextStyle? textStyle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double radius;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.unfocusedBorderColor = AppColors.inputBorder,
    this.focusedBorderColor = AppColors.primaryColor,
    this.fillColor = AppColors.inputBackground,
    this.textStyle,
    this.validator,
    this.onChanged,
    this.onTap,
    this.hintStyle,
    this.radius = AppDimensions.inputRadius,
    this.inputFormatters,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: AppDimensions.fontSizeBodyMedium,
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingXSmall),
        ],
        TextFormField(
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          validator: widget.validator,
          style:
              widget.textStyle ??
              const TextStyle(
                color: AppColors.inputText,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                height: 1.35,
              ),
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                const TextStyle(
                  color: AppColors.inputHint,
                  fontSize: AppDimensions.fontSizeBodyMedium,
                  fontWeight: FontWeight.w400,
                  height: 1.35,
                ),
            filled: true,
            fillColor: widget.fillColor,
            contentPadding: AppDimensions.inputPadding,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.iconMuted,
                      size: AppDimensions.inputIconSize,
                    ),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  )
                : widget.suffixIcon,
            // --- Unfocused: gray border ---
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: widget.unfocusedBorderColor,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: widget.unfocusedBorderColor,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            // --- Focused: colored border ---
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                color: widget.focusedBorderColor,
                width: AppDimensions.inputFocusedBorderWidth,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: const BorderSide(
                color: AppColors.inputErrorBorder,
                width: AppDimensions.inputBorderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: const BorderSide(
                color: AppColors.inputErrorBorder,
                width: AppDimensions.inputFocusedBorderWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
