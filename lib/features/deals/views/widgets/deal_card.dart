import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class DealCard extends StatelessWidget {
  final DealModel deal;
  final VoidCallback? onTap;

  const DealCard({super.key, required this.deal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Badge is capped to half the card's width, so a long label
        // ellipsizes instead of stretching the card.
        //final badgeMaxWidth = constraints.maxWidth / 2;

        return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
              border: Border.all(color: AppColors.borderColor),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Image + save badge + brand badge ---
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.1,
                      child: deal.imageUrl != null
                          ? Image.network(
                              deal.imageUrl!,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return Container(
                            color: AppColors.disabledBackground,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primaryColor,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: AppColors.disabledBackground,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.iconMuted,
                          ),
                            ),
                          )
                          : Container(
                              color: AppColors.disabledBackground,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.iconMuted,
                              ),
                            ),
                    ),

                    // SAVE / DISCOUNT BADGE — TOP LEFT
                    Positioned(
                      top: AppDimensions.spacingSmall,
                      left: AppDimensions.spacingSmall,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSmall,
                          ),
                        ),
                        child: Text(
                          deal.badgeLabel ?? '',
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            color: AppColors.textOnSecondary,
                            fontWeight: FontWeight.w700,
                            fontSize: AppDimensions.fontSizeBodyXSmall,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),

                    // BRAND — BOTTOM RIGHT
                    Positioned(
                      bottom: AppDimensions.spacingSmall,
                      right: AppDimensions.spacingSmall,
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSmall,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          deal.brandTagShort,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppDimensions.fontSizeBodyXSmall,
                            height: 1.1,
                            color: deal.brandColor ?? AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // --- Title + subtitle + price ---
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingXSmall),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: AppDimensions.fontSizeBodyMedium,
                          height: 1.25,
                        ),
                      ),
                      // AppDimensions.verticalSpace4,
                      Text(
                        deal.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: AppDimensions.fontSizeLabelMedium,
                          height: 1.3,
                        ),
                      ),
                      // AppDimensions.verticalSpace1,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            deal.currency,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppDimensions.fontSizeLabelMedium,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              deal.currentPrice ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: AppDimensions.fontSizeBodyMedium,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              deal.originalPrice ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                decoration: TextDecoration.lineThrough,
                                fontSize: AppDimensions.fontSizeLabelMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
