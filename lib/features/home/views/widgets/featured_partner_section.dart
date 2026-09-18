import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/home/models/partner_model.dart';

class FeaturedPartnersSection extends StatefulWidget {
  final List<PartnerModel> partners;
  final void Function(PartnerModel partner)? onArrowTap;

  const FeaturedPartnersSection({
    super.key,
    required this.partners,
    this.onArrowTap,
  });

  @override
  State<FeaturedPartnersSection> createState() =>
      _FeaturedPartnersSectionState();
}

class _FeaturedPartnersSectionState extends State<FeaturedPartnersSection> {
  int _currentIndex = 0;
  late final PageController _pageController;
  final Map<int, VideoPlayerController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    if (widget.partners.isNotEmpty) {
      _loadVideoForIndex(_currentIndex);
      // Preload next video if available
      if (widget.partners.length > 1) {
        _loadVideoForIndex(1);
      }
    }
  }

  void _loadVideoForIndex(int index) {
    if (index < 0 || index >= widget.partners.length) return;
    if (_controllers.containsKey(index)) return;

    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.partners[index].videoUrl),
    );
    _controllers[index] = controller;

    controller.initialize().then((_) {
      if (!mounted) return;
      controller
        ..setLooping(true)
        ..setVolume(0);
      if (index == _currentIndex) {
        controller.play();
      }
      setState(() {});
    });
  }

  void _onPageChanged(int index) {
    // Pause previous video
    _controllers[_currentIndex]?.pause();

    setState(() {
      _currentIndex = index;
    });

    // Play current video
    final currentController = _controllers[index];
    if (currentController != null && currentController.value.isInitialized) {
      currentController.play();
    } else {
      _loadVideoForIndex(index);
    }

    // Preload adjacent videos
    _loadVideoForIndex(index + 1);
    _loadVideoForIndex(index - 1);

    widget.onArrowTap?.call(widget.partners[index]);
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.partners.isEmpty) return const SizedBox.shrink();

    final partner = widget.partners[_currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText.headlineXSmall('Featured partners'),
            AppText.titleSmall(
              '${_currentIndex + 1} / ${widget.partners.length}',
              color: AppColors.primaryColor,
            ),
          ],
        ),
        AppDimensions.verticalSpace12,

        // --- Card ---
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXLarge),
            border: Border.all(color: AppColors.borderColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Video PageView for Horizontal Swipe ---
              AspectRatio(
                aspectRatio: 16 / 10,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: widget.partners.length,
                  itemBuilder: (context, index) {
                    final p = widget.partners[index];
                    final controller = _controllers[index];
                    final isReady =
                        controller != null && controller.value.isInitialized;

                    return Stack(
                      children: [
                        Positioned.fill(
                          child: isReady
                              ? FittedBox(
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                    width: controller.value.size.width,
                                    height: controller.value.size.height,
                                    child: VideoPlayer(controller),
                                  ),
                                )
                              : Container(
                                  color: AppColors.disabledBackground,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                        ),
                        if (p.isFeatured)
                          Positioned(
                            top: AppDimensions.spacingMedium,
                            left: AppDimensions.spacingMedium,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.warningLight,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusRound,
                                ),
                              ),
                              child: const Text(
                                'Featured',
                                style: TextStyle(
                                  color: AppColors.warningDark,
                                  fontWeight: FontWeight.w700,
                                  fontSize: AppDimensions.fontSizeLabelLarge,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),

              AppDimensions.verticalSpace12,

              // --- Dot indicators (below video, above text) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.partners.length, (index) {
                  final isActive = index == _currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isActive ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primaryColor
                          : AppColors.disabledBackground,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusRound,
                      ),
                    ),
                  );
                }),
              ),

              // --- Title & subtitle ---
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.titleLarge(partner.title),
                    const SizedBox(height: 4),
                    AppText.bodyMedium(partner.subtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
