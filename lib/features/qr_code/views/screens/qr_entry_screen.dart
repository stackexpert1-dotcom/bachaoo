import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/features/qr_code/controllers/qr_controller.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The very first screen: just the two buttons.
/// Tapping "Scan" pushes the live camera screen; the scanner starts
/// immediately and finishes on its own once a code is detected.
class QrEntryScreen extends StatelessWidget {
  const QrEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QrController controller = Get.put(QrController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // --- Back to previous screen, using the shared CustomBackButton ---
            const Positioned(
              top: 16,
              left: 16,
              // onTap defaults to Get.back() (returns to Home).
              child: CustomBackButton(size: 40, iconSize: 22),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white54,
                      size: 72,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Scan a partner QR to see deals',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildButtons(controller),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(QrController controller) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF5A623),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () {
              controller.startScan();
              Get.toNamed(AppRoutes.qrScanScreen);
            },
            child: const Text(
              'Scan',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white24),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: controller.goToEnterCode,
            child: const Text(
              'Enter partner code',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
