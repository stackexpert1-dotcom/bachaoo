import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:flutter/material.dart';

class SubscriptionPromoCard extends StatelessWidget {
  final VoidCallback onExploreTap;

  const SubscriptionPromoCard({super.key, required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Explore Bachaoo Plus membership plans',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onExploreTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
          child: Ink(
            height: 208,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF123B24),
                  Color(0xFF006B2E),
                  Color(0xFF005025),
                ],
                stops: [0, 0.58, 1],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.22),
                  blurRadius: 18,
                  offset: const Offset(0, 9),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final mascotWidth = constraints.maxWidth * 0.48;

                  return Stack(
                    children: [
                      const Positioned(
                        top: -72,
                        right: -52,
                        child: _GlowCircle(size: 218, color: Color(0x1FFFFFFF)),
                      ),
                      const Positioned(
                        bottom: -94,
                        right: 30,
                        child: _GlowCircle(size: 174, color: Color(0x16000000)),
                      ),
                      Positioned(
                        top: 15,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: const Text(
                            'BACHAOO PLUS',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.7,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: -5,
                        bottom: -12,
                        width: mascotWidth,
                        height: 190,
                        child: IgnorePointer(
                          child: Image.asset(
                            AppAssets.quala,
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 25,
                        width: constraints.maxWidth * 0.56,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your savings\njust got smarter.',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                                height: 1.06,
                                letterSpacing: -0.55,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              'Unlock more value every\ntime you shop.',
                              maxLines: 2,
                              style: TextStyle(
                                color: Color(0xD9FFFFFF),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: 35,
                        child: Row(
                          children: [
                            const Expanded(
                              child: _BenefitRow(
                                icon: Icons.local_offer_outlined,
                                label: 'Member-only deals',
                              ),
                            ),
                            // const SizedBox(width: 6),
                            // Container(
                            //   height: 38,
                            //   padding: const EdgeInsets.symmetric(
                            //     horizontal: 13,
                            //   ),
                            //   decoration: BoxDecoration(
                            //     color: AppColors.white,
                            //     borderRadius: BorderRadius.circular(12),
                            //   ),
                            //   child: const Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       // Text(
                            //       //   'View plans',
                            //       //   style: TextStyle(
                            //       //     color: AppColors.primaryColor,
                            //       //     fontSize: 12,
                            //       //     fontWeight: FontWeight.w800,
                            //       //   ),
                            //       // ),
                            //       // SizedBox(width: 5),
                            //       Icon(
                            //         Icons.arrow_forward_rounded,
                            //         color: AppColors.primaryColor,
                            //         size: 17,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BenefitRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white.withValues(alpha: 0.22)),
          ),
          child: Icon(icon, size: 16, color: AppColors.secondaryColor),
        ),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
