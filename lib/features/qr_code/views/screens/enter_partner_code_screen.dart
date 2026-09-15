import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/qr_code/controllers/qr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterPartnerCodeScreen extends StatelessWidget {
  const EnterPartnerCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QrController controller = Get.find<QrController>();
    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme: const IconThemeData(color: Colors.black),
      //   title: const Text(
      //     'Enter partner code',
      //     style: TextStyle(color: Colors.black),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(),
            AppDimensions.verticalSpace28,
            const Text(
              'Ask staff for the partner code and type it in below.',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            AppDimensions.verticalSpace20,
            CustomTextFormField(
              label: 'Enter code',
              controller: textController,
              hintText: 'e.g. BACHAOO-1234',
              // textCapitalization: TextCapitalization.characters,
            ),
            AppDimensions.verticalSpace20,
            PrimaryButton(
              label: 'Confirm code',
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.white,
              onTap: () {
                final code = textController.text.trim();
                if (code.isEmpty) return;
                controller.completeScan(code);
              },
            ),
          ],
        ),
      ),
    );
  }
}
