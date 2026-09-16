import 'package:bachaoo/common_widgets/login_required_screen.dart';
import 'package:bachaoo/common_widgets/splash_screen.dart';
import 'package:bachaoo/features/authentication/bindings/otp_bindings.dart';
import 'package:bachaoo/features/authentication/views/screens/login_screen.dart';
import 'package:bachaoo/features/authentication/views/screens/otp_screen.dart';
// import 'package:bachaoo/features/authentication/views/screens/otp_screen.dart';
import 'package:bachaoo/features/authentication/views/screens/register_screen.dart';
import 'package:bachaoo/features/businesses/views/screens/businesses_partener_screen.dart';
// import 'package:bachaoo/features/card/views/screens/card_screen.dart';
import 'package:bachaoo/features/cart/views/screens/cart_screen.dart';
import 'package:bachaoo/features/category/views/screens/category_screen.dart';
import 'package:bachaoo/features/chat/views/screens/inbox_screen.dart';
import 'package:bachaoo/features/deals/models/deal_detail_model.dart';
import 'package:bachaoo/features/deals/views/screens/explore_deal_screen.dart';
import 'package:bachaoo/features/discounts/views/screens/claim_discount_screen.dart';
import 'package:bachaoo/features/discounts/views/screens/discount_confirmed_screen.dart';
import 'package:bachaoo/features/discounts/views/screens/discount_explore_screen.dart';
import 'package:bachaoo/features/discounts/views/screens/discount_view_screen.dart';
import 'package:bachaoo/features/home/views/screens/home_screen.dart';
import 'package:bachaoo/features/home/bindings/bottom_bav_bindings.dart';
import 'package:bachaoo/features/help_and_support/views/screens/contact_us_screen.dart';
import 'package:bachaoo/features/help_and_support/views/screens/help_and_support_screen.dart';
import 'package:bachaoo/features/help_and_support/views/screens/policies_screen.dart';
import 'package:bachaoo/features/profile/screens/edit_profile_screen.dart';
import 'package:bachaoo/features/qr_code/views/screens/enter_partner_code_screen.dart';
import 'package:bachaoo/features/qr_code/views/screens/qr_entry_screen.dart';
import 'package:bachaoo/features/qr_code/views/screens/qr_scan_screen.dart';
import 'package:bachaoo/features/refer_and_earn/bindings/referral_bindings.dart';
import 'package:bachaoo/features/refer_and_earn/views/screens/referral_screen.dart';
import 'package:bachaoo/features/virtual_card/bindings/card_bindings.dart';
import 'package:bachaoo/features/virtual_card/views/screens/card_screen.dart';
import 'package:bachaoo/features/vouchers/views/screens/voucher_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const homeScreen = "/homeScreen";
  static const loginScreen = "/loginScreen";
  static const registerScreen = "/registerScreen";
  static const categoryScreen = "/categoryScreen";

  static const cardScreen = "/cardScreen";
  static const cartScreen = "/cartScreen";

  static const businessesPartnerScreen = "/businessesPartnerScreen";
  static const discountExploreScreen = "/discountExploreScreen";
  static const discountViewScreen = "/discountViewScreen";
  static const dealsExploreScreen = "/dealsExploreScreen";
  static const claimDiscountScreen = "/claimDiscountScreen";
  static const discountConfirmedScreen = "/discountConfirmedScreen";

  static const editProfileScreen = "/editProfileScreen";

  static const contactUsScreen = "/contactUsScreen";
  static const helpSupportScreen = "/helpSupportScreen";
  static const policiesScreen = "/policiesScreen";
  static const inboxScreen = "/inboxScreen";

  static const qrEntryScreen = "/qrEntryScreen";
  static const qrScanScreen = "/qrScanScreen";
  static const enterPartnerCodeScreen = "/enterPartnerCodeScreen";

  static const memberShipCardScreen = "/memberShipCardScreen";
  static const referralScreen = "/referralScreen";
  static const otpScreen = "/otpScreen";
  static const voucherScreen = "/voucherScreen";

  static final List<GetPage> pages = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      binding: BottomBavBindings(),
    ),
    GetPage(
      name: cardScreen,
      page: () => LoginRequiredScreen(
        onCreateCard: () => Get.toNamed(AppRoutes.registerScreen),
        onHaveAccount: () => Get.toNamed(AppRoutes.loginScreen),
      ),
    ),
    GetPage(
      name: cartScreen,
      page: () {
        final args = Get.arguments;
        if (args is Map) {
          return CartScreen(
            vendorName: args['vendorName'] as String? ?? '',
            vendorLocation: args['vendorLocation'] as String? ?? '',
            deal: args['deal'] as DealDetailModel?,
            initialQuantity: args['quantity'] as int? ?? 1,
          );
        }
        return const CartScreen(vendorName: '', vendorLocation: '');
      },
    ),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: categoryScreen, page: () => const CategoryScreen()),
    GetPage(
      name: businessesPartnerScreen,
      page: () => BusinessPartenerScreen(subCategoryName: Get.arguments),
    ),
    GetPage(
      name: discountExploreScreen,
      page: () => const DiscountExploreScreen(),
    ),
    GetPage(name: discountViewScreen, page: () => const DiscountViewScreen()),
    GetPage(name: dealsExploreScreen, page: () => const DealsExploreScreen()),
    GetPage(name: claimDiscountScreen, page: () => const ClaimDiscountScreen()),
    GetPage(
      name: discountConfirmedScreen,
      page: () {
        final args = Get.arguments;
        if (args is Map) {
          return DiscountConfirmedScreen(
            businessName: args['businessName'] as String? ?? '',
            businessLogoUrl: args['businessLogoUrl'] as String?,
            discountAmount: (args['discountAmount'] as num?)?.toDouble() ?? 0,
            totalSavedAllTime:
                (args['totalSavedAllTime'] as num?)?.toDouble() ?? 0,
            visitCount: args['visitCount'] as int? ?? 0,
          );
        }
        return const DiscountConfirmedScreen(
          businessName: '',
          discountAmount: 0,
          totalSavedAllTime: 0,
          visitCount: 0,
        );
      },
    ),
    GetPage(name: editProfileScreen, page: () => const ProfileScreen()),
    GetPage(name: contactUsScreen, page: () => const ContactUsScreen()),
    GetPage(name: helpSupportScreen, page: () => const HelpSupportScreen()),
    GetPage(name: policiesScreen, page: () => const PoliciesScreen()),
    GetPage(name: inboxScreen, page: () => const InboxScreen()),
    GetPage(name: qrEntryScreen, page: () => const QrEntryScreen()),
    GetPage(name: qrScanScreen, page: () => const QrScanScreen()),
    GetPage(
      name: enterPartnerCodeScreen,
      page: () => const EnterPartnerCodeScreen(),
    ),

    GetPage(
      name: memberShipCardScreen,
      page: () => const MemberCardScreen(),
      binding: CardBindings(),
    ),
    GetPage(
      name: referralScreen,
      page: () => const ReferEarnScreen(),
      binding: ReferralBindings(),
    ),
    GetPage(
      name: otpScreen,
      page: () => const OtpScreen(),
      binding: OtpBindings(),
    ),
    GetPage(name: voucherScreen, page: () => const VouchersScreen()),
  ];
}
