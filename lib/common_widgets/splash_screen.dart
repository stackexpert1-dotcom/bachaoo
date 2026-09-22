import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bachaoo/core/constants/bachaoo_assets.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ============================================================
  // AMBIENT (loops for the life of the splash)
  // ============================================================

  late final AnimationController _glowController; // soft pulsing halo

  // ============================================================
  // ONE-SHOT SEQUENCE CONTROLLERS
  // ============================================================

  late final AnimationController _logoController;
  late final AnimationController _ringController;
  late final AnimationController _paintController; // paints "Bachaoo" in
  late final AnimationController _taglineController; // typewriter reveal
  late final AnimationController _exitController;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoRotate;

  late final Animation<double> _ringScale;
  late final Animation<double> _ringOpacity;

  late final Animation<double> _exitOpacity;
  late final Animation<double> _exitScale;

  // ============================================================
  // CONTENT
  // ============================================================

  static const String _word = 'Bachaoo';
  static const String _tagline = 'Save With Every Buy';

  // ============================================================
  // TIMING
  // ============================================================

  static const Duration _initialDelay = Duration(milliseconds: 300);
  static const Duration _logoDuration = Duration(milliseconds: 650);
  static const Duration _ringDuration = Duration(milliseconds: 550);
  static const Duration _gapBeforePaint = Duration(milliseconds: 150);
  static const Duration _paintDuration = Duration(milliseconds: 750);
  static const Duration _gapBeforeTagline = Duration(milliseconds: 150);
  static const Duration _taglineDuration = Duration(milliseconds: 650);
  static const Duration _holdDuration = Duration(milliseconds: 300);
  static const Duration _exitDuration = Duration(milliseconds: 350);

  @override
  void initState() {
    super.initState();

    // ============================================================
    // AMBIENT GLOW behind the logo
    // ============================================================
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    // ============================================================
    // LOGO ENTRANCE
    // ============================================================
    _logoController = AnimationController(vsync: this, duration: _logoDuration);

    _logoScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.3,
          end: 1.12,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.12,
          end: 0.96,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.96,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 15,
      ),
    ]).animate(_logoController);

    _logoOpacity = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _logoRotate = Tween<double>(begin: -0.18, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    // ============================================================
    // RING BURST — fires once the logo lands
    // ============================================================
    _ringController = AnimationController(vsync: this, duration: _ringDuration);

    _ringScale = Tween<double>(
      begin: 0.6,
      end: 1.8,
    ).animate(CurvedAnimation(parent: _ringController, curve: Curves.easeOut));

    _ringOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 0.5), weight: 20),
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 0.0), weight: 80),
    ]).animate(_ringController);

    // ============================================================
    // WORDMARK PAINT REVEAL
    // ============================================================
    _paintController = AnimationController(
      vsync: this,
      duration: _paintDuration,
    );

    // ============================================================
    // TAGLINE — character by character
    // ============================================================
    _taglineController = AnimationController(
      vsync: this,
      duration: _taglineDuration,
    );

    // ============================================================
    // EXIT
    // ============================================================
    _exitController = AnimationController(vsync: this, duration: _exitDuration);

    _exitOpacity = CurvedAnimation(
      parent: _exitController,
      curve: Curves.easeIn,
    );

    _exitScale = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _exitController, curve: Curves.easeIn));

    _startAnimation();
  }

  Future<void> _startAnimation() async {
    // 0. A small beat of nothing before anything moves
    await Future.delayed(_initialDelay);
    if (!mounted) return;

    // 1. Logo pops in
    await _logoController.forward();
    if (!mounted) return;

    // Ring burst fires as the logo settles
    _ringController.forward();

    // 2. Wordmark gets painted on, left to right — the "B" is the first
    // thing revealed since the brush starts from the left edge.
    await Future.delayed(_gapBeforePaint);
    if (!mounted) return;
    await _paintController.forward();

    // 3. Tagline types itself out
    await Future.delayed(_gapBeforeTagline);
    if (!mounted) return;
    await _taglineController.forward();

    // 4. Hold, then exit + navigate
    await Future.delayed(_holdDuration);
    if (!mounted) return;

    await _exitController.forward();
    if (!mounted) return;

    Get.offAllNamed(AppRoutes.onboardingScreen);
  }

  @override
  void dispose() {
    _glowController.dispose();
    _logoController.dispose();
    _ringController.dispose();
    _paintController.dispose();
    _taglineController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ==========================================================
      // STATIC BACKGROUND — never changes during the splash.
      // ==========================================================
      backgroundColor: AppColors.primaryColor,

      body: AnimatedBuilder(
        animation: _exitController,
        builder: (context, child) {
          return Opacity(
            opacity: 1 - _exitOpacity.value,
            child: Transform.scale(scale: _exitScale.value, child: child),
          );
        },
        child: Container(
          color: AppColors.primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ==================================================
                // LOGO + glow halo + burst ring
                // ==================================================
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Continuous soft glow pulse
                      AnimatedBuilder(
                        animation: _glowController,
                        builder: (context, _) {
                          final glow = 0.85 + (_glowController.value * 0.25);
                          return Container(
                            width: 170 * glow,
                            height: 170 * glow,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.secondaryColor.withValues(
                                    alpha: 0.18,
                                  ),
                                  blurRadius: 38,
                                  spreadRadius: 6,
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // One-time expanding ring burst
                      AnimatedBuilder(
                        animation: _ringController,
                        builder: (context, _) {
                          return Opacity(
                            opacity: _ringOpacity.value,
                            child: Transform.scale(
                              scale: _ringScale.value,
                              child: Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.secondaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // The logo itself
                      AnimatedBuilder(
                        animation: _logoController,
                        builder: (context, _) {
                          return Opacity(
                            opacity: _logoOpacity.value,
                            child: Transform.rotate(
                              angle: _logoRotate.value,
                              child: Transform.scale(
                                scale: _logoScale.value,
                                child: Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.14,
                                        ),
                                        blurRadius: 20,
                                        spreadRadius: 1,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    AppAssets.bachaooLogoWhite,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // WORDMARK — painted on left to right, like a brush
                // stroke. "B" is revealed first simply because the
                // brush starts from the left edge of the word.
                // ==================================================
                AnimatedBuilder(
                  animation: _paintController,
                  builder: (context, _) {
                    final edge = _paintController.value.clamp(0.0, 1.0);
                    final s0 = (edge - 0.05).clamp(0.0, 1.0);
                    final s1 = edge;
                    final s2 = (edge + 0.05).clamp(0.0, 1.0);

                    return ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: const [
                            Colors.white, // painted (final color below)
                            Colors.white,
                            Colors.transparent,
                          ],
                          stops: [s0, s1, s2],
                        ).createShader(bounds);
                      },
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          // Base painted color
                          Text(
                            _word,
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 52,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 6),

                // ==================================================
                // TAGLINE — types itself out one character at a time
                // ==================================================
                AnimatedBuilder(
                  animation: _taglineController,
                  builder: (context, _) {
                    final progress = _taglineController.value;
                    final charCount = (progress * _tagline.length)
                        .clamp(0, _tagline.length)
                        .floor();

                    return Opacity(
                      opacity: progress == 0 ? 0 : 1,
                      child: Text(
                        _tagline.substring(0, charCount),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.secondaryColor.withValues(
                            alpha: 0.90,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
