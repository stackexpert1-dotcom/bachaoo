import 'package:bachaoo/features/authentication/controllers/otp_controller.dart';
import 'package:get/get.dart';

class OtpBindings extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};

    Get.lazyPut<otpController>(
      () => otpController(
        phoneNumber: args['phoneNumber'] as String? ?? '',
        onChangeNumber: args['onChangeNumber'] as void Function()? ?? () {},
        onVerifyCode:
            args['onVerifyCode'] as Future<void> Function(String)? ??
            (_) async {},
        onResendCode:
            args['onResendCode'] as Future<void> Function()? ?? () async {},
      ),
    );
  }
}
