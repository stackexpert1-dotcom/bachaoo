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
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.partners.isNotEmpty) {
      _loadVideo(widget.partners[_currentIndex].videoUrl);
    }
  }

  void _loadVideo(String url) {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _controller = controller;
    controller.initialize().then((_) {
      if (!mounted || _controller != controller) return;
      controller
        ..setLooping(true)
        ..setVolume(0)
        ..play();
      setState(() {});
    });
  }

  Future<void> _goToNext() async {
    if (widget.partners.length <= 1) return;

    final nextIndex = (_currentIndex + 1) % widget.partners.length;
    final oldController = _controller;

    setState(() => _currentIndex = nextIndex);
    _loadVideo(widget.partners[nextIndex].videoUrl);

    await oldController?.pause();
    await oldController?.dispose();

    widget.onArrowTap?.call(widget.partners[nextIndex]);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.partners.isEmpty) return const SizedBox.shrink();

    final partner = widget.partners[_currentIndex];
    final controller = _controller;
    final isReady = controller != null && controller.value.isInitialized;

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
              // --- Video ---
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 10,
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
                  if (partner.isFeatured)
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
              ),

              // --- Title, subtitle, next button ---
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.titleLarge(partner.title),
                          const SizedBox(height: 4),
                          AppText.bodyMedium(partner.subtitle),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spacingMedium),
                    GestureDetector(
                      onTap: _goToNext,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppColors.white,
                        ),
                      ),
                    ),
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
