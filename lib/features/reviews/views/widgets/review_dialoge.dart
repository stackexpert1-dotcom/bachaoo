import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/reviews/models/review_model.dart';

class WriteReviewDialog extends StatefulWidget {
  final String? reviewerName;

  const WriteReviewDialog({super.key, this.reviewerName});

  /// Shows the dialog and returns the submitted [ReviewModel], or null
  /// if the person cancelled without submitting.
  static Future<ReviewModel?> show(
    BuildContext context, {
    String? reviewerName,
  }) {
    return showDialog<ReviewModel>(
      context: context,
      builder: (context) => WriteReviewDialog(reviewerName: reviewerName),
    );
  }

  @override
  State<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  int _selectedRating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedRating == 0) return; // require a star rating
    Navigator.of(context).pop(
      ReviewModel(
        reviewerName: widget.reviewerName ?? 'You',
        rating: _selectedRating,
        comment: _commentController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = _selectedRating > 0;

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.pagePaddingSmall,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.titleLarge('Write a review'),
            AppDimensions.verticalSpace8,
            AppText.bodyMedium('How was your experience?'),
            AppDimensions.verticalSpace20,

            // --- Star picker ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starValue = index + 1;
                final filled = starValue <= _selectedRating;
                return GestureDetector(
                  onTap: () => setState(() => _selectedRating = starValue),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      filled ? Icons.star_rounded : Icons.star_border_rounded,
                      color: AppColors.secondaryColor,
                      size: 36,
                    ),
                  ),
                );
              }),
            ),
            AppDimensions.verticalSpace20,

            // --- Comment ---
            CustomTextFormField(
              hintText: 'Share details of your experience',
              controller: _commentController,
              keyboardType: TextInputType.multiline,
            ),
            AppDimensions.verticalSpace20,

            // --- Actions ---
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(
                  flex: 1,
                  child: PrimaryButton(
                    label: 'Submit',
                    isEnabled: canSubmit,
                    onTap: _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
