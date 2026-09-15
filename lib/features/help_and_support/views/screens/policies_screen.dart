import 'package:bachaoo/common_widgets/filter_chip_button.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';
import 'package:bachaoo/features/help_and_support/models/policy_section_model.dart';
import 'package:bachaoo/features/help_and_support/views/screens/contact_us_screen.dart';
import 'package:bachaoo/features/help_and_support/views/widgets/policy_section_list.dart';
import 'package:flutter/material.dart';
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
      metaLabel: 'Updated 1 Sep 2026',
      sections: [
        PolicySection(
          heading: 'Who we are',
          body:
              'Bachaoo is a savings app that partners with restaurants and '
              'shops in your city to offer exclusive deals to members. '
              'Show your card, claim the deal, save money.',
        ),
        PolicySection(
          heading: 'How it works',
          body:
              'Browse deals near you, visit the partner, and present your '
              'Bachaoo card at billing. Staff confirm the claim with a '
              'business code, and the discount applies instantly.',
        ),
        PolicySection(
          heading: 'Our partners',
          body:
              'We work directly with local businesses so every deal is '
              'genuine and honoured in-store, with new partners added '
              'regularly across Sargodha and beyond.',
        ),
      ],
    ),
    PolicyTab.privacy: const PolicyContent(
      title: 'Privacy policy',
      metaLabel: 'Updated 1 Sep 2026 \u00b7 4 min read',
      sections: [
        PolicySection(
          heading: '1. Information we collect',
          body:
              'We collect your name, phone number, email, and city to '
              'create your membership, along with your deal-claim history '
              'to calculate savings and points.',
        ),
        PolicySection(
          heading: '2. How we use it',
          body:
              'Your information is used to verify your identity at '
              'partner locations, personalise deals, and send updates '
              'about your account. We do not sell your data to third parties.',
        ),
        PolicySection(
          heading: '3. Data sharing with partners',
          body:
              'Partners only see that a valid Bachaoo member is claiming '
              'a deal and the business code confirming it — not your '
              'contact details.',
        ),
        PolicySection(
          heading: '4. Your controls',
          body:
              'You can update your profile, opt out of notifications, or '
              'delete your account at any time from the Profile screen.',
        ),
      ],
    ),
    PolicyTab.terms: const PolicyContent(
      title: 'Terms & conditions',
      metaLabel: 'Updated 1 Sep 2026 \u00b7 5 min read',
      sections: [
        PolicySection(
          heading: '1. Membership',
          body:
              'Your Bachaoo card is personal and valid until the expiry '
              'date shown on it. It must be presented in the app at the '
              'time of billing to claim any deal or discount.',
        ),
        PolicySection(
          heading: '2. Deals and discounts',
          body:
              'Only offers displayed in the app are valid. Offers cannot '
              'be combined with other promotions or already-discounted '
              'items. Credit is not extended to members. Partners may '
              'cap the discount amount per bill.',
        ),
        PolicySection(
          heading: '3. Business codes',
          body:
              'Each claim is confirmed with a code provided by the '
              'partner at billing. Claims without a code are not '
              'recorded and may not count towards your savings history.',
        ),
        PolicySection(
          heading: '4. Points and referrals',
          body:
              'Points are earned only when a referred member verifies '
              'their phone number. Points have no cash value and expire '
              'with your membership.',
        ),
        PolicySection(
          heading: '5. Availability',
          body:
              'Offers may be unavailable during internet or app outages. '
              'Bachaoo is not liable for partner pricing changes.',
        ),
      ],
    ),
    PolicyTab.refund: const PolicyContent(
      title: 'Refund policy',
      metaLabel: 'Updated 1 Sep 2026 \u00b7 2 min read',
      sections: [
        PolicySection(
          heading: '1. Membership refunds',
          body:
              'You can request a full refund of your Bachaoo membership fee '
              'within 14 days of joining if you have not yet used any deal '
              'or discount. Refunds are processed back to your original '
              'payment method within 5\u20137 working days.',
        ),
        PolicySection(
          heading: '2. In-store claims',
          body:
              'Deals and discounts are honoured at the partner location at '
              'the time of billing. If a partner refuses to honour a valid '
              'Bachaoo offer, contact support with your receipt and '
              'business code and we will resolve it with the partner.',
        ),
        PolicySection(
          heading: '3. Points and rewards',
          body:
              'Points and referral rewards have no cash value and are not '
              'refundable or transferable. They are issued only when a '
              'referred member verifies their phone number and expire with '
              'your membership.',
        ),
      ],
    ),
    PolicyTab.cancellation: const PolicyContent(
      title: 'Cancellation policy',
      metaLabel: 'Updated 1 Sep 2026 \u00b7 2 min read',
      sections: [
        PolicySection(
          heading: '1. Cancelling membership',
          body:
              'You can cancel your Bachaoo membership at any time from '
              'the Profile screen. Cancellation takes effect immediately '
              'and unused points are forfeited.',
        ),
        PolicySection(
          heading: '2. Claimed deals',
          body:
              'Deals already claimed and confirmed with a business code '
              'before cancellation are not affected and remain valid at '
              'the partner.',
        ),
        PolicySection(
          heading: '3. Re-joining',
          body:
              'You may create a new membership at any time. Previous '
              'points and referral history are not restored.',
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
                  Material(
                    color: AppColors.surfaceColor,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 44,
                        height: 44,
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.textPrimary,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingMedium),
                  Expanded(
                    child: Text(
                      _screenTitles[_selected]!,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: AppDimensions.fontSizeHeadlineMedium,
                      ),
                    ),
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
                ],
              ),
            ),
          ],
        ),
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
