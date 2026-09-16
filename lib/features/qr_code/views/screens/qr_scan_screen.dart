import 'package:bachaoo/features/qr_code/controllers/qr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../widgets/scan_frame_painter.dart';

/// Full-screen camera view with the orange corner-bracket frame and moving
/// scan line, styled after the reference screens. Detection is fully
/// automatic: the moment the camera reads a valid QR, controller.onDetect
/// fires -> controller.completeScan runs -> this screen is popped and the
/// "Partner found" sheet opens, all without any extra tap.
class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen>
    with SingleTickerProviderStateMixin {
  final QrController controller = Get.find<QrController>();
  late final AnimationController _lineAnim;

  @override
  void initState() {
    super.initState();
    _lineAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _lineAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.scannerController,
            onDetect: controller.onDetect,
          ),
          _buildOverlay(context),
        ],
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 260,
                height: 260,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(260, 260),
                      painter: ScanFramePainter(color: const Color(0xFFF5A623)),
                    ),
                    AnimatedBuilder(
                      animation: _lineAnim,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment(0, -1 + 2 * _lineAnim.value),
                          child: Container(
                            width: 220,
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5A623),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF5A623)
                                      .withOpacity(0.6),
                                  blurRadius: 8,
                                ),
                              ],
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              children: [
                const Text(
                  'Point at the partner QR at the counter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Every partner displays one. Scanning opens their deals and discounts so you can claim right there.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: TextButton(
              onPressed: controller.goToEnterCode,
              child: const Text(
                'Enter partner code',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _circleButton(icon: Icons.close, onTap: Get.back),
          const Text(
            'Scan partner QR',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Obx(
            () => _circleButton(
              icon: controller.isTorchOn.value
                  ? Icons.flash_on
                  : Icons.flash_off,
              onTap: controller.toggleTorch,
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
