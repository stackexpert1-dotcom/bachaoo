import 'package:bachaoo/features/qr_code/views/widgets/partner_found_sheet.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Where the scan flow currently is.
enum QrScanStatus { idle, scanning, success, error }

class QrController extends GetxController {
  /// Camera controller for the live scanner view.
  final MobileScannerController scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  final Rx<QrScanStatus> status = QrScanStatus.idle.obs;
  final RxString scannedCode = ''.obs;
  final RxBool isTorchOn = false.obs;

  // Result of a successful scan — swap this for your real API response model.
  final RxnString partnerName = RxnString();
  final RxnString partnerAddress = RxnString();
  final RxnString partnerImageUrl = RxnString();
  final RxInt dealsCount = 0.obs;
  final RxInt discountPercent = 0.obs;
  final RxDouble rating = 0.0.obs;
  final RxInt reviewsCount = 0.obs;

  /// Call when the user taps "Scan" — resets state and (re)starts the camera.
  void startScan() {
    status.value = QrScanStatus.scanning;
    scannedCode.value = '';
    scannerController.start();
  }

  /// Wired to MobileScanner's onDetect callback.
  void onDetect(BarcodeCapture capture) {
    // Ignore frames once we've already got a result — prevents double-fires.
    if (status.value != QrScanStatus.scanning) return;

    final barcode = capture.barcodes.firstWhereOrNull(
      (b) => b.rawValue != null && b.rawValue!.isNotEmpty,
    );
    if (barcode == null) return;

    scannedCode.value = barcode.rawValue!;
    completeScan(barcode.rawValue!);
  }

  /// Single completion path for BOTH the camera scanner and the manual
  /// "Enter partner code" screen. Runs automatically the moment a valid
  /// code is available — no extra "done" tap needed — then closes whatever
  /// screen is open and shows the "Partner found" sheet.
  Future<void> completeScan(String code) async {
    if (scannerController.value.isRunning) {
      await scannerController.stop();
    }

    try {
      // TODO: replace this with your real partner lookup, e.g.
      // final partner = await PartnerRepository.lookup(code);
      await Future.delayed(const Duration(milliseconds: 400));

      partnerName.value = 'Dhuaan N Dhukan';
      partnerAddress.value = 'Zafarullah Chowk, Satellite Town · Open now';
      partnerImageUrl.value = '';
      dealsCount.value = 3;
      discountPercent.value = 12;
      rating.value = 5.0;
      reviewsCount.value = 4;

      status.value = QrScanStatus.success;

      Get.back(); // close the scan or manual-entry screen
      Get.bottomSheet(
        const PartnerFoundSheet(),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } catch (_) {
      status.value = QrScanStatus.error;
    }
  }

  void toggleTorch() {
    isTorchOn.value = !isTorchOn.value;
    scannerController.toggleTorch();
  }

  /// Back to the two-button entry state.
  void reset() {
    status.value = QrScanStatus.idle;
    scannedCode.value = '';
    partnerName.value = null;
  }

  void goToEnterCode() => Get.toNamed(AppRoutes.enterPartnerCodeScreen);

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
