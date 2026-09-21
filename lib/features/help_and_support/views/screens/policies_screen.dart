import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/filter_chip_button.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/help_and_support/models/policy_section_model.dart';
import 'package:bachaoo/features/help_and_support/views/screens/contact_us_screen.dart';
import 'package:bachaoo/features/help_and_support/views/widgets/policy_section_list.dart';
import 'package:bachaoo/routes/bachaoo_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

enum PolicyTab { about, contact, privacy, terms, refund, cancellation }

class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({super.key});

  @override
  State<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  late PolicyTab _selected;

  /// One key per chip so we can scroll the active filter button into view
  /// (e.g. arriving on "Privacy"/"Terms" from another screen).
  final Map<PolicyTab, GlobalKey> _tabKeys = {
    for (final tab in PolicyTab.values) tab: GlobalKey(),
  };

  static const _whatsappNumber = '923000000000';
  static const _callNumber = '+923000000000';

  @override
  void initState() {
    super.initState();
    _selected = _tabFromArg(Get.arguments);
    // After the first frame, bring the selected filter button on-screen.
    WidgetsBinding.instance.addPostFrameCallback((_) => _revealSelected());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _select(PolicyTab tab) {
    setState(() => _selected = tab);
    WidgetsBinding.instance.addPostFrameCallback((_) => _revealSelected());
  }

  void _revealSelected() {
    if (!mounted) return;
    final context = _tabKeys[_selected]?.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      alignment: 0.5,
    );
  }

  /// Resolves the initially selected tab from navigation arguments, e.g.
  /// `Get.toNamed(AppRoutes.policiesScreen, arguments: 'privacy')`.
  /// Falls back to [PolicyTab.terms] when nothing usable is passed.
  static PolicyTab _tabFromArg(Object? arg) {
    if (arg is PolicyTab) return arg;
    if (arg is String) {
      switch (arg.toLowerCase()) {
        case 'about':
          return PolicyTab.about;
        case 'contact':
          return PolicyTab.contact;
        case 'privacy':
          return PolicyTab.privacy;
        case 'refund':
          return PolicyTab.refund;
        case 'cancellation':
          return PolicyTab.cancellation;
      }
    }
    return PolicyTab.terms;
  }

  static const Map<PolicyTab, String> _tabLabels = {
    PolicyTab.about: 'About',
    PolicyTab.contact: 'Contact us',
    PolicyTab.privacy: 'Privacy',
    PolicyTab.terms: 'Terms',
    PolicyTab.refund: 'Refund',
    PolicyTab.cancellation: 'Cancellation',
  };

  static const Map<PolicyTab, String> _screenTitles = {
    PolicyTab.about: 'About Bachaoo',
    PolicyTab.contact: 'Contact us',
    PolicyTab.privacy: 'Privacy policy',
    PolicyTab.terms: 'Terms & conditions',
    PolicyTab.refund: 'Refund policy',
    PolicyTab.cancellation: 'Cancellation policy',
  };

  static final Map<PolicyTab, PolicyContent> _content = {
    PolicyTab.about: const PolicyContent(
      title: 'About Bachaoo',
      metaLabel: 'Updated September 2026',
      sections: [
        PolicySection(
          heading: 'Welcome to BACHAOO – Bachat ka " س " On Hai!',
          body:
              'BACHAOO is your gateway to smarter savings and bigger rewards. We connect you to a vibrant community of value-driven businesses offering exclusive prepaid vouchers, special deals, and cashback opportunities. Every time you shop through BACHAOO, you enjoy upfront discounts and unlock exciting rewards.\n\n'
              'But that’s not all – BACHAOO empowers you to earn too! Invite your friends, grow the community, and earn real income through our rewarding referral system. The more you share, the more you gain.\n\n'
              'At BACHAOO, we believe saving should be simple, social, and rewarding. Join thousands of members who are maximizing their savings and growing their earnings – all in one smart app.\n\n'
              'Start saving like a pro with BACHAOO today!',
        ),
      ],
    ),
    PolicyTab.privacy: const PolicyContent(
      title: 'Privacy policy',
      metaLabel: 'Updated September 2026',
      sections: [
        PolicySection(
          heading: 'Overview',
          body: 'BACHAOO (“we”, “us”, or “our”) respects your privacy and is committed to protecting your personal data. This Privacy Policy explains how we collect, use, and safeguard your information when you use the Bachaoo mobile application (the “App”), whether as a user or business partner.',
        ),
        PolicySection(
          heading: '1. Information We Collect',
          body:
              'a) Personal Information\n'
              '• Users: Name, phone number, email address, referral code, location (optional)\n'
              '• Business Partners: Business name, contact person, phone number, email, business address, and account/payment details\n\n'
              'b) Usage Data\n'
              '• App interactions, clicks, pages viewed, vouchers redeemed, and referral activity\n\n'
              'c) Device & Technical Data\n'
              '• IP address, device type, operating system, mobile network, browser type',
        ),
        PolicySection(
          heading: '2. How We Use Your Information',
          body:
              'We use your information to:\n'
              '• Provide and manage your access to the App\n'
              '• Facilitate voucher redemptions and referral tracking\n'
              '• Process payments or credits as applicable\n'
              '• Send important updates, notifications, and personalized offers\n'
              '• Improve the App’s performance, features, and security',
        ),
        PolicySection(
          heading: '3. Sharing Your Information',
          body:
              'We do not sell your personal information. We may share data with:\n'
              '• Business partners (only relevant details required for voucher redemptions)\n'
              '• Service providers (e.g., payment processors, SMS/email services)\n'
              '• Authorities, if required by law or to prevent fraud or abuse',
        ),
        PolicySection(
          heading: '4. Referral System',
          body:
              'When you refer others to Bachaoo:\n'
              '• You may share a referral link/code\n'
              '• Referrals are tracked only for reward purposes\n'
              '• Your personal information is not shared with referrals',
        ),
        PolicySection(
          heading: '5. Data Security',
          body: 'We use encryption, secure servers, and strict access controls to protect your data. While no system is 100% secure, we take reasonable measures to safeguard your information.',
        ),
        PolicySection(
          heading: '6. Your Rights',
          body:
              'Depending on your location, you may have the right to:\n'
              '• Access or correct your personal information\n'
              '• Request deletion of your data\n'
              '• Opt-out of promotional communications\n\n'
              'To exercise your rights, contact us at: Email: Info@bachaoo.co',
        ),
        PolicySection(
          heading: '7. Cookies and Tracking',
          body: 'The App may use cookies or similar technologies to enhance your experience. You can manage your preferences via device settings.',
        ),
        PolicySection(
          heading: '8. Changes to This Policy',
          body: 'We may update this Privacy Policy periodically. Major updates will be communicated via the App. Continued use after updates constitutes acceptance of the revised policy.',
        ),
        PolicySection(
          heading: '9. Contact Us',
          body:
              'If you have questions or concerns, contact us:\n'
              '• Email: Info@bachaoo.co\n'
              '• Phone: +92 317 7709871\n'
              '• Address: Mezzanine Floor, Suzuki Falcon Motors, Lahore Road, Sargodha\n\n'
              'By using the Bachaoo App, you agree to this Privacy Policy.',
        ),
      ],
    ),
    PolicyTab.terms: const PolicyContent(
      title: 'Terms & conditions',
      metaLabel: 'Updated September 2026',
      sections: [
        PolicySection(
          heading: 'Welcome to Bachaoo',
          body: 'These Terms and Conditions ("Terms") govern access to and use of the Bachaoo mobile application ("App") by individuals ("Members") and businesses ("Business Partners"). By creating an account or using the App, you acknowledge that you have read, understood, and agree to these Terms.',
        ),
        PolicySection(
          heading: 'Eligibility',
          body:
              '• Members must be 18 years of age or older and legally capable of entering into a binding agreement.\n'
              '• Business Partners must be lawfully registered entities or authorized representatives with the authority to act on behalf of the business.',
        ),
        PolicySection(
          heading: 'Account Registration and Security',
          body:
              '• You agree to provide accurate, current, and complete information during registration and to keep such information updated.\n'
              '• You are responsible for maintaining the confidentiality of your account credentials.\n'
              '• All activities conducted through your account are deemed to be performed by you.',
        ),
        PolicySection(
          heading: 'Services Overview',
          body:
              'Bachaoo provides a digital platform that enables:\n'
              '• Members to discover and access prepaid vouchers, discounts, and promotional offers provided by Business Partners.\n'
              '• Business Partners to publish, manage, and promote offers to Members within the App.\n'
              '• Optional referral and engagement features that may allow users to receive non-cash rewards or benefits for inviting others.\n'
              '• In-app visibility and communication tools for Business Partners, subject to applicable policies.\n\n'
              'Bachaoo may update, modify, suspend, or discontinue any feature or service at its discretion to improve user experience or comply with legal and platform requirements.',
        ),
        PolicySection(
          heading: 'Member Responsibilities',
          body:
              'As a Member, you agree to:\n'
              '• Use the App lawfully and in accordance with these Terms.\n'
              '• Avoid misuse, manipulation, or abuse of vouchers, referral features, or promotional systems.\n'
              '• Ensure your account details remain accurate.\n'
              '• Comply with all offer-specific terms defined by the relevant Business Partner.',
        ),
        PolicySection(
          heading: 'Business Partner Responsibilities',
          body:
              'As a Business Partner, you agree to:\n'
              '• Offer lawful, accurate, and clearly described products or services.\n'
              '• Transparently define voucher conditions, values, limitations, and validity periods.\n'
              '• Address Member inquiries or disputes related to your offers in a professional manner.\n'
              '• Honor all valid vouchers in accordance with their stated terms.\n'
              '• Comply with all applicable laws, licenses, regulations, and platform policies.\n\n'
              'Bachaoo reserves the right to limit, suspend, or terminate Partner access in cases of policy violations, misrepresentation, or fraudulent activity.',
        ),
        PolicySection(
          heading: 'Vouchers and Offers',
          body:
              '• Vouchers are issued by Business Partners and are subject to the Partner’s stated terms.\n'
              '• Bachaoo acts solely as a facilitating platform and does not guarantee the quality, safety, pricing, or fulfillment of Partner offerings.\n'
              '• Unless expressly stated, vouchers are non-refundable and have no cash value.\n'
              '• Unauthorized resale, transfer, or misuse of vouchers may result in account restrictions.',
        ),
        PolicySection(
          heading: 'Referral and Engagement Features',
          body:
              '• From time to time, Bachaoo may offer referral or engagement features that provide points, rewards, or in-app benefits.\n'
              '• Such rewards are non-monetary, subject to eligibility checks, and may be modified or discontinued at any time.\n'
              '• Any attempt to exploit or abuse these features may lead to forfeiture of benefits and account action.',
        ),
        PolicySection(
          heading: 'Payments and Billing',
          body:
              '• Payments are processed through secure third-party payment service providers.\n'
              '• Bachaoo does not store full payment card or banking details.\n'
              '• Any refunds or adjustments are handled in accordance with the applicable voucher terms and relevant payment provider policies.',
        ),
        PolicySection(
          heading: 'Intellectual Property and Branding',
          body:
              '• Business Partners grant Bachaoo a non-exclusive, royalty-free, limited license to display their business name, logo, and offer-related materials within the App.\n'
              '• Partners may not use Bachaoo’s trademarks or branding without prior written permission.',
        ),
        PolicySection(
          heading: 'Privacy and Data Protection',
          body: 'Use of the App is subject to our Privacy Policy, which explains how personal data is collected, used, and protected. Bachaoo implements reasonable safeguards to protect user information in line with applicable laws.',
        ),
        PolicySection(
          heading: 'Suspension and Termination',
          body:
              '• Bachaoo may restrict, suspend, or terminate accounts that violate these Terms, applicable laws, or platform rules.\n'
              '• Business Partners may discontinue participation by providing at least 30 days’ written notice.\n'
              '• Members may close their accounts through the App or by contacting customer support.',
        ),
        PolicySection(
          heading: 'Limitation of Liability',
          body:
              'To the maximum extent permitted by law, Bachaoo is not responsible for:\n'
              '• Indirect, incidental, or consequential damages.\n'
              '• Loss of revenue, profit, or business opportunities.\n'
              '• Disputes, service quality issues, or fulfillment failures between Members and Business Partners.',
        ),
        PolicySection(
          heading: 'Updates to These Terms',
          body: 'Bachaoo may revise these Terms periodically. Material changes will be communicated through the App or other appropriate means. Continued use of the App indicates acceptance of the updated Terms.',
        ),
        PolicySection(
          heading: 'Governing Law',
          body:
              'These Terms are governed by the laws of the Islamic Republic of Pakistan, and any disputes shall be subject to the exclusive jurisdiction of the competent courts in Pakistan.\n\n'
              'By accessing or using the Bachaoo App, you confirm your agreement to these Terms and Conditions.',
        ),
      ],
    ),
    PolicyTab.refund: const PolicyContent(
      title: 'Refund policy',
      metaLabel: 'Updated September 2026',
      sections: [
        PolicySection(
          heading: 'Refund Policy',
          body: 'Refunds for purchases depend on the business partner’s policy. Bachaoo acts as a bridge between users and businesses and does not process direct refunds.',
        ),
      ],
    ),
    PolicyTab.cancellation: const PolicyContent(
      title: 'Cancellation policy',
      metaLabel: 'Updated September 2026',
      sections: [
        PolicySection(
          heading: 'Overview',
          body: 'At Bachaoo, we aim to provide a transparent and fair experience for all users. This Cancellation Policy explains how cancellations, credits, or voucher-related issues are handled on our platform.',
        ),
        PolicySection(
          heading: '1. For App Users',
          body:
              'a) Prepaid Voucher Use\n'
              '• Once a prepaid voucher is activated through the Bachaoo app, it is final and non-reversible, unless otherwise stated by the issuing business.\n'
              '• Users are advised to review the voucher terms, expiry date, and usage conditions before activation.\n\n'
              'b) Voucher Errors or Technical Issues\n'
              'If a voucher was activated by mistake or due to a technical issue:\n'
              '• Contact Bachaoo Support within 24 hours of activation.\n'
              '• Adjustments, credits, or replacements will be reviewed on a case-by-case basis.\n\n'
              'c) Partner Business Issues\n'
              'If a partner business is unable to honor a valid voucher:\n'
              '• Contact Bachaoo Support immediately.\n'
              '• Bachaoo may issue a replacement voucher or wallet credit, provided the voucher was valid and unused.',
        ),
        PolicySection(
          heading: '2. For Business Partners',
          body:
              'a) Voucher Campaign Changes\n'
              '• Business partners may request to cancel or modify an active voucher campaign by contacting the Bachaoo team.\n'
              '• Vouchers that have already been activated by users cannot be canceled retroactively.\n'
              '• All previously issued and active vouchers must be honored.\n\n'
              'b) Temporary Service Disruptions\n'
              '• In case of temporary service unavailability (e.g., closure or maintenance), partners must inform Bachaoo in advance.\n'
              '• Voucher redemptions may be paused until services resume.',
        ),
        PolicySection(
          heading: '3. How to Request an Adjustment or Report an Issue',
          body:
              'Please contact us via email with the required details:\n'
              '• Email: info@devirtualclub.com\n\n'
              'Include:\n'
              '• Your full name\n'
              '• Voucher code\n'
              '• Activation date\n'
              '• Reason for the request',
        ),
        PolicySection(
          heading: '4. Processing Time',
          body:
              '• Approved adjustments or replacements (if applicable) will be processed within 5–7 business days.\n'
              '• Credits will be issued via the Bachaoo Wallet or the original payment method, as applicable.',
        ),
        PolicySection(
          heading: '5. Policy Updates',
          body:
              '• Bachaoo reserves the right to update this policy at any time.\n'
              '• Major changes will be communicated through the app notifications or email.\n\n'
              'Still have questions?\n'
              'Our support team is always here to help.',
        ),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header ---
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.pagePadding,
                AppDimensions.spacingSmall,
                AppDimensions.pagePadding,
                0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomBackButton(),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  Expanded(
                    child: AppText.appBarTitle(_screenTitles[_selected]!),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.spacingMedium),

            // --- Filter chip tabs ---
            SizedBox(
              height: 44,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.pagePadding,
                ),
                // All chips are always built (not lazy), so the selected
                // chip's GlobalKey always resolves and the row can be
                // auto-scrolled to centre it, even when it starts off-screen
                // (e.g. arriving on "Privacy"/"Cancellation" from another
                // screen). Only 5 chips exist, so building them eagerly is
                // cheap.
                child: Row(
                  children: [
                    for (final tab in PolicyTab.values) ...[
                      KeyedSubtree(
                        key: _tabKeys[tab],
                        child: FilterChipButton(
                          label: _tabLabels[tab]!,
                          isSelected: _selected == tab,
                          onTap: () => _select(tab),
                        ),
                      ),
                      if (tab != PolicyTab.values.last)
                        const SizedBox(width: AppDimensions.spacingSmall),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spacingLarge),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.pagePadding,
                  0,
                  AppDimensions.pagePadding,
                  AppDimensions.spacingXLarge,
                ),
                children: [
                  if (_selected == PolicyTab.contact)
                    _buildContactTab()
                  else
                    PolicySectionList(
                      metaLabel: _content[_selected]!.metaLabel,
                      sections: _content[_selected]!.sections,
                    ),
                  const SizedBox(height: AppDimensions.spacingXLarge),
                  const Center(
                    child: Text(
                      'Developed By StackExpert.PK',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: AppDimensions.fontSizeLabelMedium,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.inboxScreen);
        },
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        child: FaIcon(FontAwesomeIcons.solidMessage),
      ),
    );
  }

  Widget _buildContactTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reach the Bachaoo support team directly \u2014 tap a card below.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppDimensions.fontSizeBodyLarge,
            height: AppDimensions.lineHeightNormal,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingLarge),
        const ContactActionCard(
          type: ContactActionType.whatsapp,
          title: 'Chat with us',
          subtitle: '9am \u2013 9pm, daily',
          rawNumber: _whatsappNumber,
        ),
        const SizedBox(height: AppDimensions.spacingMedium),
        const ContactActionCard(
          type: ContactActionType.call,
          title: '0300 0000000',
          subtitle: 'Sargodha office',
          rawNumber: _callNumber,
        ),
      ],
    );
  }
}
