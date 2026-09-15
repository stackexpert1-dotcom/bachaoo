import 'package:bachaoo/features/refer_and_earn/models/refer_and_earn_model.dart';
import 'package:bachaoo/features/virtual_card/models/virtuall_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/share_channel_model.dart';

class ReferralController extends GetxController {
  final Rx<MemberCardModel?> summary = Rx<MemberCardModel?>(null);
  final RxList<ReferralModel> referrals = <ReferralModel>[].obs;

  final RxBool isLoadingSummary = true.obs;
  final RxBool isLoadingReferrals = true.obs;
  final RxString errorMessage = ''.obs;

  /// Data-driven share row — add/remove a channel here and the UI follows.
  final List<ShareChannelModel> shareChannels = [
    ShareChannelModel(
      id: 'whatsapp',
      label: 'WhatsApp',
      faIcon: FaIcon(
        FontAwesomeIcons.whatsapp,
        size: 18,
        color: const Color(0xFF25D366),
      ),
      accentColor: Color(0xFF25D366),
    ),
    ShareChannelModel(
      id: 'sms',
      label: 'SMS',
      icon: Icons.sms_outlined,
    ),
    ShareChannelModel(id: 'more', label: '', icon: Icons.ios_share),
  ];

  @override
  void onInit() {
    super.onInit();
    loadSummary();
    loadReferrals();
  }

  Future<void> loadSummary() async {
    isLoadingSummary.value = true;
    errorMessage.value = '';
    try {
      // TODO: replace with your real API call, e.g.
      // final json = await MemberRepository.fetchCard();
      // summary.value = MemberCardModel.fromJson(json);
      await Future.delayed(const Duration(milliseconds: 400));
      summary.value = MemberCardModel(
        holderName: 'Shafqat Ullah',
        tierLabel: 'Standard',
        referralCode: 'O2JR3EWS38',
        validTill: DateTime(2027, 9, 2),
        points: 2000,
        pointsTarget: 5000,
        referralsCompleted: 2,
        referralsRequiredForNextTier: 5,
        pointsPerReferral: 1000,
        nextTierLabel: 'Pro mode',
      );
    } catch (_) {
      errorMessage.value =
          'Could not load your referral details. Pull to retry.';
    } finally {
      isLoadingSummary.value = false;
    }
  }

  Future<void> loadReferrals() async {
    isLoadingReferrals.value = true;
    try {
      // TODO: replace with your real API call, e.g.
      // final list = await MemberRepository.fetchReferrals();
      await Future.delayed(const Duration(milliseconds: 400));
      referrals.assignAll([
        ReferralModel(
          id: '1',
          name: 'Ahmed K.',
          status: ReferralStatus.joined,
          joinedDate: DateTime(2026, 9, 3),
          pointsEarned: 1000,
        ),
        ReferralModel(
          id: '2',
          name: 'Maryam R.',
          status: ReferralStatus.joined,
          joinedDate: DateTime(2026, 8, 21),
          pointsEarned: 1000,
        ),
        const ReferralModel(
          id: '3',
          name: 'Bilal H.',
          status: ReferralStatus.pending,
        ),
      ]);
    } finally {
      isLoadingReferrals.value = false;
    }
  }

  Future<void> refreshAll() async {
    await Future.wait([loadSummary(), loadReferrals()]);
  }

  int get joinedCount =>
      referrals.where((r) => r.status == ReferralStatus.joined).length;

  /// Steps carry the live points-per-referral value, so the copy never
  /// drifts out of sync with the number shown up in the header card.
  List<String> get howItWorksSteps {
    final points = summary.value?.pointsPerReferral;
    final pointsLabel = points != null ? formatNumber(points) : '';
    return [
      'Share your code with a friend.',
      'They enter it when creating their card.',
      points != null
          ? 'You get $pointsLabel points once they verify their number.'
          : 'You get points once they verify their number.',
    ];
  }

  Future<void> copyCode() async {
    final code = summary.value?.referralCode;
    if (code == null) return;
    await Clipboard.setData(ClipboardData(text: code));
    Get.snackbar(
      'Copied',
      'Referral code copied to clipboard',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> shareVia(String channelId) async {
    final code = summary.value?.referralCode ?? '';

    if (channelId == 'whatsapp') {
      // Open the online WhatsApp chat-prefill link ("wa.me") with the
      // referral code pre-filled — launches the installed WhatsApp app or
      // the web client if WhatsApp isn't installed.
      final message = Uri.encodeComponent(
        'Join me on Bachaoo and we both earn points! My referral code: $code',
      );
      final uri = Uri.parse('https://wa.me/?text=$message');
      try {
        final opened =
            await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (opened) return;
      } catch (_) {
        // Fall through to the snackbar so the tap always gives feedback.
      }
    }

    Get.snackbar(
      'Share',
      'Sharing code $code via $channelId',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  String formatNumber(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return buffer.toString();
  }
}
