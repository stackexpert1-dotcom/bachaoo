import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/features/vouchers/views/models/voucher_model.dart';
import 'package:bachaoo/features/vouchers/views/widgets/voucher_list_item.dart';
import 'package:bachaoo/features/vouchers/views/widgets/voucher_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class VouchersScreen extends StatefulWidget {
  const VouchersScreen({super.key});

  @override
  State<VouchersScreen> createState() => _VouchersScreenState();
}

class _VouchersScreenState extends State<VouchersScreen> {
  int _selectedTab = 0;

  // Replace with real data from your repository / bloc / provider.
  final List<VoucherModel> _available = const [
    VoucherModel(
      id: 'v1',
      type: VoucherType.price,
      amountLabel: 'Rs 500',
      amountCaption: 'voucher',
      imageUrl:
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=200',
      title: 'Welcome voucher',
      subtitle: 'Any partner · minimum bill Rs 1,500',
      expiryLabel: 'Expires 30 Sep',
    ),
    VoucherModel(
      id: 'v2',
      type: VoucherType.free,
      amountLabel: 'Free',
      amountCaption: 'dessert',
      imageUrl:
          'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?w=200',
      title: 'Cake Planet · birthday treat',
      subtitle: 'Show at counter with your card',
      expiryLabel: 'Expires 14 Sep',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimensions.pagePadding,
            AppDimensions.paddingMedium,
            AppDimensions.pagePadding,
            AppDimensions.paddingXXLarge,
          ),
          children: [
            // ── Header row ───────────────────────────────
            Row(
              children: [
                CustomBackButton(),
                const SizedBox(width: 14),
                AppText.headlineLarge('Vouchers'),
              ],
            ),
            AppDimensions.verticalSpace24,

            // ── Tab selector ─────────────────────────────
            VoucherTabSelector(
              tabs: const [
                VoucherTab(label: 'Available', count: 2),
                VoucherTab(label: 'Used', count: 3),
                VoucherTab(label: 'Expired'),
              ],
              selectedIndex: _selectedTab,
              onChanged: (index) => setState(() => _selectedTab = index),
            ),
            AppDimensions.verticalSpace24,

            // ── Voucher list ─────────────────────────────
            ..._available.map(
              (voucher) => Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimensions.spacingMedium,
                ),
                child: VoucherListItem(voucher: voucher),
              ),
            ),

            // ── Premium banner (commented out per user request) ──
            // AppDimensions.verticalSpace8,
            // PremiumVoucherBanner(
            //   currentPoints: 2000,
            //   targetPoints: 5000,
            //   description: "Unlock at 5,000 points. You're at 2,000 — three referrals away.",
            //   onReferFriend: () {},
            // ),
          ],
        ),
      ),
    );
  }
}

// class _BackButton extends StatelessWidget {
//   final VoidCallback onTap;

//   const _BackButton({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 48,
//         height: 48,
//         decoration: BoxDecoration(
//           color: AppColors.surfaceColor,
//           borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.shadow,
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         alignment: Alignment.center,
//         child: const Icon(
//           Icons.chevron_left_rounded,
//           color: AppColors.textPrimary,
//           size: 28,
//         ),
//       ),
//     );
//   }
// }
