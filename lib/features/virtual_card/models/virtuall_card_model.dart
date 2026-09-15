class MemberCardModel {
  final String holderName;
  final String tierLabel;
  final String referralCode;
  final DateTime validTill;

  final int points;
  final int pointsTarget;

  final int referralsCompleted;
  final int referralsRequiredForNextTier;
  final int pointsPerReferral;
  final String nextTierLabel; // e.g. "Pro mode"

  const MemberCardModel({
    required this.holderName,
    required this.tierLabel,
    required this.referralCode,
    required this.validTill,
    required this.points,
    required this.pointsTarget,
    required this.referralsCompleted,
    required this.referralsRequiredForNextTier,
    required this.pointsPerReferral,
    required this.nextTierLabel,
  });

  /// 0.0–1.0, safe against divide-by-zero and overshoot.
  double get pointsProgress =>
      pointsTarget <= 0 ? 0 : (points / pointsTarget).clamp(0.0, 1.0);

  int get referralsRemaining =>
      (referralsRequiredForNextTier - referralsCompleted).clamp(
        0,
        referralsRequiredForNextTier,
      );

  factory MemberCardModel.fromJson(Map<String, dynamic> json) {
    return MemberCardModel(
      holderName: json['holderName'] as String,
      tierLabel: json['tierLabel'] as String,
      referralCode: json['referralCode'] as String,
      validTill: DateTime.parse(json['validTill'] as String),
      points: json['points'] as int,
      pointsTarget: json['pointsTarget'] as int,
      referralsCompleted: json['referralsCompleted'] as int,
      referralsRequiredForNextTier: json['referralsRequiredForNextTier'] as int,
      pointsPerReferral: json['pointsPerReferral'] as int,
      nextTierLabel: json['nextTierLabel'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'holderName': holderName,
    'tierLabel': tierLabel,
    'referralCode': referralCode,
    'validTill': validTill.toIso8601String(),
    'points': points,
    'pointsTarget': pointsTarget,
    'referralsCompleted': referralsCompleted,
    'referralsRequiredForNextTier': referralsRequiredForNextTier,
    'pointsPerReferral': pointsPerReferral,
    'nextTierLabel': nextTierLabel,
  };

  MemberCardModel copyWith({int? points, int? referralsCompleted}) {
    return MemberCardModel(
      holderName: holderName,
      tierLabel: tierLabel,
      referralCode: referralCode,
      validTill: validTill,
      points: points ?? this.points,
      pointsTarget: pointsTarget,
      referralsCompleted: referralsCompleted ?? this.referralsCompleted,
      referralsRequiredForNextTier: referralsRequiredForNextTier,
      pointsPerReferral: pointsPerReferral,
      nextTierLabel: nextTierLabel,
    );
  }
}
