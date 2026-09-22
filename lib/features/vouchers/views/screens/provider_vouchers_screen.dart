import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/vouchers/views/models/voucher_model.dart';
import 'package:bachaoo/features/vouchers/views/widgets/voucher_business_code_bottom_sheet.dart';
import 'package:bachaoo/features/vouchers/views/widgets/voucher_list_item.dart';
import 'package:bachaoo/features/vouchers/views/widgets/voucher_tab_selector.dart';
import 'package:bachaoo/features/vouchers/views/widgets/used_voucher_details_bottom_sheet.dart';
import 'package:flutter/material.dart';

/// Vouchers for one selected business. Production code can construct this with
/// GET /businesses/{businessId}/vouchers results; no UI changes are required.
class ProviderVouchersScreen extends StatefulWidget {
  final VoucherProviderModel provider;

  const ProviderVouchersScreen({super.key, required this.provider});

  @override
  State<ProviderVouchersScreen> createState() => _ProviderVouchersScreenState();
}

class _ProviderVouchersScreenState extends State<ProviderVouchersScreen> {
  int _selectedTab = 0;

  VoucherProviderModel get provider => widget.provider;

  List<VoucherModel> get _vouchers => [
    VoucherModel(
      id: '${provider.businessId}-1',
      businessId: provider.businessId,
      businessName: provider.businessName,
      businessImageUrl: provider.imageUrl,
      voucherName: provider.businessName == 'KFC'
          ? 'Free Zinger add-on'
          : provider.businessName == 'Sapphire'
          ? '20% off new arrivals'
          : provider.businessName == 'Cinepax'
          ? '15% off weekday tickets'
          : '15% off value meals',
      secondaryText: provider.businessName == 'KFC'
          ? 'Redeem with any bucket purchase'
          : 'Present your member card before payment',
      points: provider.startingPoints ?? 500,
      expiresAt: DateTime(2026, 10, 12),
    ),
    VoucherModel(
      id: '${provider.businessId}-2',
      businessId: provider.businessId,
      businessName: provider.businessName,
      businessImageUrl: provider.imageUrl,
      voucherName: 'Member special reward',
      secondaryText: 'Available at participating locations only',
      points: (provider.startingPoints ?? 500) + 250,
      expiresAt: DateTime(2026, 10, 24),
      status: VoucherStatus.redeemed,
    ),
    VoucherModel(
      id: '${provider.businessId}-3',
      businessId: provider.businessId,
      businessName: provider.businessName,
      businessImageUrl: provider.imageUrl,
      voucherName: 'Seasonal member reward',
      secondaryText: 'This offer is no longer available for redemption',
      points: provider.startingPoints ?? 500,
      expiresAt: DateTime(2026, 9, 15),
      status: VoucherStatus.expired,
    ),
  ];

  List<VoucherModel> get _visibleVouchers {
    final status = switch (_selectedTab) {
      1 => VoucherStatus.redeemed,
      2 => VoucherStatus.expired,
      _ => VoucherStatus.available,
    };
    return _vouchers.where((voucher) => voucher.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final vouchers = _visibleVouchers;
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
            Row(
              children: [
                CustomBackButton(),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(
                  child: Text(
                    '${provider.businessName} vouchers',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppDimensions.fontSizeHeadlineLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            AppDimensions.verticalSpace20,
            VoucherTabSelector(
              tabs: const [
                VoucherTab(label: 'Available', count: 1),
                VoucherTab(label: 'Used', count: 1),
                VoucherTab(label: 'Expired', count: 1),
              ],
              selectedIndex: _selectedTab,
              onChanged: (index) => setState(() => _selectedTab = index),
            ),
            AppDimensions.verticalSpace20,
            for (final voucher in vouchers) ...[
              VoucherListItem(
                voucher: voucher,
                onTap: () => _handleVoucherTap(context, voucher),
                onUseNow: () => _handleVoucherTap(context, voucher),
              ),
              AppDimensions.verticalSpace16,
            ],
          ],
        ),
      ),
    );
  }

  void _showRedeemed(BuildContext context, VoucherModel voucher) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${voucher.voucherName} redeemed successfully.')),
    );
  }

  void _handleVoucherTap(BuildContext context, VoucherModel voucher) {
    if (voucher.status == VoucherStatus.redeemed) {
      UsedVoucherDetailsBottomSheet.show(context, voucher: voucher);
      return;
    }
    if (!voucher.canUse) return;
    VoucherBusinessCodeBottomSheet.show(
      context,
      voucher: voucher,
      onConfirm: (code) => _showRedeemed(context, voucher),
    );
  }
}
