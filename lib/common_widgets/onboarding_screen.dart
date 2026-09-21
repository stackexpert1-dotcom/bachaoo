import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bachaoo/common_widgets/app_text.dart'; // for appFont (Sora)
import 'package:bachaoo/core/constants/bachaoo_colors.dart';

class _OnboardingPageData {
  final String image;
  final String title;

  final String highlight;
  final String description;

  const _OnboardingPageData({
    required this.image,
    required this.title,
    required this.highlight,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinished;

  const OnboardingScreen({super.key, required this.onFinished});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const List<_OnboardingPageData> _pages = [
    _OnboardingPageData(
      image: AppAssets.onboarding1,
      title: 'Bachaoo More',
      highlight: 'Bachaoo',
      description:
          'Find the best deals and discounts from your favorite local '
          'businesses, all in one place.',
    ),
    _OnboardingPageData(
      image: AppAssets.onboarding2,
      title: 'Save More with Bachaoo',
      highlight: 'Bachaoo',
      description:
          'Enjoy exclusive discounts and special offers while getting more '
          'value from every purchase.',
    ),
    _OnboardingPageData(
      image: AppAssets.onboarding3,
      title: 'Your Deals. Your Savings.',
      highlight: 'Your Savings.',
      description:
          'Discover great offers, save money, and enjoy more of what you '
          'love with Bachaoo.',
    ),
  ];

  final PageController _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_isLast) {
      widget.onFinished();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            // ------------------------------------------------ mascot area
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          24,
                          mediaQuery.padding.top + 32,
                          24,
                          8,
                        ),
                        child: Image.asset(
                          _pages[i].image,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),

                  // Skip
                  Positioned(
                    top: mediaQuery.padding.top + 8,
                    right: 12,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isLast ? 0 : 1,
                      child: TextButton(
                        onPressed: _isLast ? null : widget.onFinished,
                        child: Text(
                          'Skip',
                          style: appFont(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ------------------------------------------------ bottom panel
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                24,
                28,
                24,
                mediaQuery.padding.bottom + 24,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0A2313), AppColors.primaryColor],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title + description (fixed height so the panel never jumps)
                  SizedBox(
                    height: 150,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.08),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                      child: _buildText(_pages[_index]),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, _buildDot),
                  ),

                  const SizedBox(height: 24),

                  // CTA
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        foregroundColor: AppColors.primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Row(
                          key: ValueKey(_isLast),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _isLast ? 'Get Started' : 'Next',
                              style: appFont(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 20,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------ pieces

  Widget _buildText(_OnboardingPageData page) {
    final titleStyle = appFont(
      color: AppColors.white,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      height: 1.25,
      letterSpacing: -0.4,
    );

    // Split the title around the highlighted phrase.
    final start = page.title.indexOf(page.highlight);
    final spans = <InlineSpan>[];
    if (start < 0) {
      spans.add(TextSpan(text: page.title));
    } else {
      final end = start + page.highlight.length;
      if (start > 0) {
        spans.add(TextSpan(text: page.title.substring(0, start)));
      }
      spans.add(
        TextSpan(
          text: page.highlight,
          style: const TextStyle(color: AppColors.secondaryColor),
        ),
      );
      if (end < page.title.length) {
        spans.add(TextSpan(text: page.title.substring(end)));
      }
    }

    return Column(
      key: ValueKey(page.title),
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(style: titleStyle, children: spans),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          page.description,
          textAlign: TextAlign.center,
          style: appFont(
            color: AppColors.white.withValues(alpha: 0.85),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildDot(int i) {
    final active = i == _index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 26 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active
            ? AppColors.secondaryColor
            : AppColors.white.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
