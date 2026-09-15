import 'package:bachaoo/features/reviews/views/widgets/review_dialoge.dart'
    show WriteReviewDialog;
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/reviews/models/review_model.dart';
import 'package:bachaoo/features/reviews/views/widgets/review_card.dart';

class ReviewsSection extends StatelessWidget {
  final List<ReviewModel> reviews;
  final void Function(ReviewModel review)? onReviewSubmitted;

  const ReviewsSection({
    super.key,
    required this.reviews,
    this.onReviewSubmitted,
  });

  Future<void> _openWriteReviewDialog(BuildContext context) async {
    final result = await WriteReviewDialog.show(context);
    if (result != null) {
      onReviewSubmitted?.call(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.headlineSmall('Reviews'),
            GestureDetector(
              onTap: () => _openWriteReviewDialog(context),
              child: AppText.titleSmall(
                'Write a review',
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        AppDimensions.verticalSpace16,

        // --- List ---
        if (reviews.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: AppText.bodyMedium('No reviews yet'),
            ),
          )
        else
          ...List.generate(reviews.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == reviews.length - 1
                    ? 0
                    : AppDimensions.spacingMedium,
              ),
              child: ReviewCard(review: reviews[index]),
            );
          }),
      ],
    );
  }
}
