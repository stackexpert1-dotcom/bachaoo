import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/reviews/models/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Avatar + name + stars ---
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  review.initials,
                  style: const TextStyle(
                    color: AppColors.successDark,
                    fontWeight: FontWeight.w700,
                    fontSize: AppDimensions.fontSizeBodyMedium,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spacingMedium),
              Expanded(
                child: AppText.titleMedium(review.reviewerName, maxLines: 1),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  final filled = index < review.rating;
                  return Icon(
                    filled ? Icons.star_rounded : Icons.star_border_rounded,
                    color: AppColors.secondaryColor,
                    size: 18,
                  );
                }),
              ),
            ],
          ),
          AppDimensions.verticalSpace12,

          // --- Comment ---
          AppText.bodyLarge(review.comment, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
