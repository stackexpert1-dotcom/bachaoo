import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/home/models/promo_model.dart';
import 'package:bachaoo/features/home/views/widgets/promo_card.dart';

class PromoCarousel extends StatefulWidget {
  final List<PromoModel> promos;
  final void Function(PromoModel promo)? onPromoTap;

  const PromoCarousel({super.key, required this.promos, this.onPromoTap});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late final PageController _controller = PageController(viewportFraction: 1.0);
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.promos.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.promos.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final promo = widget.promos[index];
              // viewportFraction 1.0 shows exactly ONE image on screen —
              // no corner of the next/previous promo is ever visible.
              // A small left gutter (skipped on the first image) keeps a
              // little space between the two images when the carousel slides.
              return Padding(
                padding: EdgeInsets.only(
                  left: index > 0 ? AppDimensions.spacingSmall : 0,
                ),
                child: PromoCard(
                  promo: promo,
                  onTap: widget.onPromoTap == null
                      ? null
                      : () => widget.onPromoTap!(promo),
                ),
              );
            },
          ),
        ),
        AppDimensions.verticalSpace12,

        // --- Dot indicators ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.promos.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primaryColor
                    : AppColors.disabledBackground,
                borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
              ),
            );
          }),
        ),
      ],
    );
  }
}
