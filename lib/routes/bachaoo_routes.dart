import 'package:bachaoo/common_widgets/login_required_screen.dart';
import 'package:bachaoo/common_widgets/onboarding_screen.dart';
import 'package:bachaoo/common_widgets/splash_screen.dart';
import 'package:bachaoo/features/authentication/bindings/otp_bindings.dart';
import 'package:bachaoo/features/authentication/views/screens/change_password_screen.dart';
import 'package:bachaoo/features/authentication/views/screens/forgot_password_screen.dart';
import 'package:bachaoo/features/authentication/views/screens/login_screen.dart';
import 'package:bachaoo/features/authentication/views/screens/otp_screen.dart';
import 'package:bachaoo/features/activity/views/screens/activity_history_screen.dart';
// import 'package:bachaoo/features/authentication/views/screens/otp_screen.dart';
import 'package:bachaoo/features/authentication/views/screens/register_screen.dart';
import 'package:bachaoo/features/businesses/views/screens/businesses_partener_screen.dart';
// import 'package:bachaoo/features/card/views/screens/card_screen.dart';
import 'package:bachaoo/features/cart/bindings/cart_binding.dart';
import 'package:bachaoo/features/cart/views/screens/cart_screen.dart';
import 'package:bachaoo/features/category/views/screens/category_screen.dart';
import 'package:bachaoo/features/catelog/bindings/catelog_bindinds.dart';
import 'package:bachaoo/features/catelog/views/screens/all_deals_screen.dart';
import 'package:bachaoo/features/catelog/views/screens/all_discount_screen.dart';
import 'package:bachaoo/features/chat/views/screens/inbox_screen.dart';
import 'package:bachaoo/features/deals/bindings/deal_bindings.dart';
import 'package:bachaoo/features/deals/models/deal_detail_model.dart';
import 'package:bachaoo/features/deals/models/deal_model.dart';
import 'package:bachaoo/features/deals/views/screens/explore_deal_screen.dart';
import 'package:bachaoo/features/deals/views/screens/deal_summary_screen.dart';
import 'package:bachaoo/features/deals/views/screens/my_deals_screen.dart';
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
import 'package:bachaoo/features/subscription/bindings/subscription_bindings.dart';
import 'package:bachaoo/features/subscription/views/screens/payment_submission_screen.dart';
import 'package:bachaoo/features/subscription/views/screens/subscription_screen.dart';
import 'package:bachaoo/features/virtual_card/bindings/card_bindings.dart';
import 'package:bachaoo/features/virtual_card/views/screens/card_screen.dart';
import 'package:bachaoo/features/vouchers/notifications/bindings/notification_bindings.dart';
import 'package:bachaoo/features/vouchers/notifications/views/screens/notification_screen.dart';
import 'package:bachaoo/features/vouchers/views/screens/voucher_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const homeScreen = "/homeScreen";
  static const loginScreen = "/loginScreen";
  static const registerScreen = "/registerScreen";
  static const changePasswordScreen = "/changePasswordScreen";
  static const categoryScreen = "/categoryScreen";

  static const loginRequiredScreen = "/loginRequiredScreen";
  static const cartScreen = "/cartScreen";

  static const businessesPartnerScreen = "/businessesPartnerScreen";
  static const discountExploreScreen = "/discountExploreScreen";
  static const discountViewScreen = "/discountViewScreen";
  static const dealsExploreScreen = "/dealsExploreScreen";
  static const myDealsScreen = "/myDealsScreen";
  static const dealSummaryScreen = "/dealSummaryScreen";
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
  static const activityHistoryScreen = "/activityHistoryScreen";
  static const referralScreen = "/referralScreen";
  static const otpScreen = "/otpScreen";
  static const voucherScreen = "/voucherScreen";

  static const notificationScreen = "/notificationScreen";
  static const allDiscountsScreen = "/allDiscountsScreen";
  static const allDealsScreen = "/allDealsScreen";

  static const forgotPasswordScreen = "/forgotPasswordScreen";
  static const subscriptionScreen = "/subscriptionScreen";
  static const paymentSubmissionScreen = "/paymentSubmissionScreen";
  static const onboardingScreen = "/onboardingScreen";

  static final List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      binding: BottomBavBindings(),
    ),
    GetPage(
      name: loginRequiredScreen,
      page: () => LoginRequiredScreen(
        onCreateCard: () => Get.toNamed(AppRoutes.registerScreen),
        onHaveAccount: () => Get.toNamed(AppRoutes.loginScreen),
      ),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
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
      binding: CartBinding(),
    ),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(
      name: changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: categoryScreen, page: () => const CategoryScreen()),
    GetPage(
      name: businessesPartnerScreen,
      page: () => BusinessPartenerScreen(subCategoryName: Get.arguments),
    ),
    GetPage(
      name: discountExploreScreen,
      page: () => const DiscountExploreScreen(),
      // Required so "Add N Deals to Cart" can always resolve the shared
      // CartController, even when this screen is reached without first
      // opening the cart screen.
      binding: CartBinding(),
    ),
    GetPage(name: discountViewScreen, page: () => const DiscountViewScreen()),
    GetPage(name: dealsExploreScreen, page: () => const DealsExploreScreen()),
    GetPage(
      name: myDealsScreen,
      page: () => const DealsScreen(),
      binding: DealBindings(),
    ),
    GetPage(
      name: dealSummaryScreen,
      page: () => DealSummaryScreen(deal: Get.arguments as DealModel),
    ),
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
      name: activityHistoryScreen,
      page: () => const ActivityHistoryScreen(),
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
    GetPage(
      name: notificationScreen,
      page: () => const NotificationsScreen(),
      binding: NotificationBinding(),
    ),

    GetPage(
      name: allDiscountsScreen,
      page: () => const AllDiscountsScreen(),
      binding: CatalogDiscountsBinding(),
    ),
    GetPage(
      name: allDealsScreen,
      page: () => const AllDealsScreen(),
      binding: CatalogDealsBinding(),
    ),
    GetPage(
      name: subscriptionScreen,
      page: () => const SubscriptionScreen(),
      binding: SubscriptionBindings(),
    ),
    GetPage(
      name: paymentSubmissionScreen,
      page: () => const PaymentSubmissionScreen(),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => OnboardingScreen(
        onFinished: () => Get.offAllNamed(AppRoutes.homeScreen),
      ),
    ),
  ];
}
