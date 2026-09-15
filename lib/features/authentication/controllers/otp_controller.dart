import 'dart:async';

import 'package:get/get.dart';

class otpController extends GetxController {
  final String phoneNumber;
  final VoidCallback onChangeNumber;
  final Future<void> Function(String code) onVerifyCode;
  final Future<void> Function() onResendCode;

  otpController({
    required this.phoneNumber,
    required this.onChangeNumber,
    required this.onVerifyCode,
    required this.onResendCode,
  });

  final RxString code = ''.obs;
  final RxBool isVerifying = false.obs;
  final RxInt secondsLeft = 42.obs;

  Timer? _timer;

  bool get isCodeComplete => code.value.length == 4;
  bool get canResend => secondsLeft.value == 0;

  String get timerLabel {
    final minutes = secondsLeft.value ~/ 60;
    final seconds = (secondsLeft.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    _timer?.cancel();
    secondsLeft.value = 42;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value <= 1) {
        timer.cancel();
        secondsLeft.value = 0;
      } else {
        secondsLeft.value -= 1;
      }
    });
  }

  void onCodeChanged(String value) {
    code.value = value;
  }

  Future<void> verify() async {
    if (!isCodeComplete || isVerifying.value) return;
    isVerifying.value = true;
    try {
      await onVerifyCode(code.value);
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> resend() async {
    if (!canResend) return;
    await onResendCode();
    _startTimer();
  }

  void changeNumber() => onChangeNumber();
}

typedef VoidCallback = void Function();
