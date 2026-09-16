import 'package:bachaoo/common_widgets/primary_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/features/businesses/models/nearby_business_model.dart';
import 'package:bachaoo/features/qr_code/controllers/qr_controller.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartnerFoundSheet extends StatelessWidget {
  const PartnerFoundSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final QrController controller = Get.find<QrController>();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 56,
                  height: 56,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.restaurant, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7F3EA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 14, color: Color(0xFF1E6B3A)),
                          SizedBox(width: 4),
                          Text(
                            'Partner found',
                            style: TextStyle(
                              color: Color(0xFF1E6B3A),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Obx(
                      () => Text(
                        controller.partnerName.value ?? '',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.partnerAddress.value ?? '',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => _statTile('${controller.dealsCount.value}', 'Deals'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(
                  () => _statTile(
                    '${controller.discountPercent.value}%',
                    'Discount on bill',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(
                  () => _statTile(
                    '${controller.rating.value.toStringAsFixed(1)} ★',
                    '${controller.reviewsCount.value} reviews',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: const Color(0xFF1E5631),
          //       padding: const EdgeInsets.symmetric(vertical: 16),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(28),
          //       ),
          //     ),
          //     onPressed: () {
          //       // Close the sheet, then collapse the QR flow: replace the
          //       // entry screen with the partner's deals screen so pressing
          //       // back from the last screen lands straight on Home.
          //       final name = controller.partnerName.value ?? 'Partner';
          //       final address = controller.partnerAddress.value ?? '';
          //       final base = BusinessModel(
          //         name: name,
          //         location: _stripOpenIndicator(address),
          //         address: address,
          //         distanceKm: 0,
          //         discountLabel: '${controller.discountPercent.value}%',
          //         discountSubtitle: 'off bill',
          //         isOpenNow: true,
          //         dealsCount: controller.dealsCount.value,
          //         rating: controller.rating.value,
          //         reviewCount: controller.reviewsCount.value,
          //       );
          //       Get.back(); // close the "Partner found" sheet
          //       Get.offNamed(
          //         AppRoutes.discountExploreScreen,
          //         arguments: BusinessModel.forDetailDemo(base),
          //       );
          //     },
          //     child: const Text(
          //       'View deals & discounts',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
          PrimaryButton(
            label: 'View deals & discounts',
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
            onTap: () {
              final name = controller.partnerName.value ?? 'Partner';
              final address = controller.partnerAddress.value ?? '';
              final base = BusinessModel(
                name: name,
                location: _stripOpenIndicator(address),
                address: address,
                distanceKm: 0,
                discountLabel: '${controller.discountPercent.value}%',
                discountSubtitle: 'off bill',
                isOpenNow: true,
                dealsCount: controller.dealsCount.value,
                rating: controller.rating.value,
                reviewCount: controller.reviewsCount.value,
              );
              Get.back(); // close the "Partner found" sheet
              Get.offNamed(
                AppRoutes.discountExploreScreen,
                arguments: BusinessModel.forDetailDemo(base),
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            'Pick what you want, then ask staff for the business code at billing to confirm the sale.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// "Zafarullah Chowk, Satellite Town · Open now" -> "Zafarullah Chowk, Satellite Town"
  static String _stripOpenIndicator(String address) {
    final index = address.indexOf('·');
    if (index == -1) return address;
    return address.substring(0, index).trim();
  }

  Widget _statTile(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E5631),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
