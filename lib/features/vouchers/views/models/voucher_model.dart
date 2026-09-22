enum VoucherStatus { available, redeemed, expired }

extension VoucherStatusX on VoucherStatus {
  String get apiValue => switch (this) {
    VoucherStatus.available => 'available',
    VoucherStatus.redeemed => 'redeemed',
    VoucherStatus.expired => 'expired',
  };

  String get label => switch (this) {
    VoucherStatus.available => 'Available',
    VoucherStatus.redeemed => 'Used',
    VoucherStatus.expired => 'Expired',
  };

  static VoucherStatus fromApiValue(String? value) => switch (value) {
    'redeemed' || 'used' => VoucherStatus.redeemed,
    'expired' => VoucherStatus.expired,
    _ => VoucherStatus.available,
  };
}

/// API-ready voucher record. The same shape can be used by a repository,
/// cached locally, or passed to the voucher detail route.
class VoucherModel {
  final String id;
  final String businessId;
  final String businessName;
  final String businessImageUrl;
  final String voucherName;
  final String secondaryText;
  final int points;
  final DateTime? expiresAt;
  final VoucherStatus status;
  final String? redemptionCode;

  const VoucherModel({
    required this.id,
    required this.businessId,
    required this.businessName,
    required this.businessImageUrl,
    required this.voucherName,
    required this.secondaryText,
    required this.points,
    required this.expiresAt,
    this.status = VoucherStatus.available,
    this.redemptionCode,
  });

  bool get canUse => status == VoucherStatus.available && !isExpired;

  bool get isExpired =>
      expiresAt != null && expiresAt!.isBefore(DateTime.now().toLocal());

  String get expiryLabel {
    if (expiresAt == null) return 'No expiry date';
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'Expires ${expiresAt!.day} ${months[expiresAt!.month - 1]}';
  }

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['id']?.toString() ?? '',
      businessId: json['business_id']?.toString() ?? '',
      businessName: json['business_name'] as String? ?? '',
      businessImageUrl:
          json['business_image_url'] as String? ??
          json['image_url'] as String? ??
          '',
      voucherName:
          json['voucher_name'] as String? ?? json['title'] as String? ?? '',
      secondaryText:
          json['secondary_text'] as String? ??
          json['subtitle'] as String? ??
          '',
      points: (json['points'] as num?)?.toInt() ?? 0,
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.tryParse(json['expires_at'].toString()),
      status: VoucherStatusX.fromApiValue(json['status'] as String?),
      redemptionCode: json['redemption_code'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'business_id': businessId,
    'business_name': businessName,
    'business_image_url': businessImageUrl,
    'voucher_name': voucherName,
    'secondary_text': secondaryText,
    'points': points,
    'expires_at': expiresAt?.toIso8601String(),
    'status': status.apiValue,
    'redemption_code': redemptionCode,
  };
}

/// Provider data returned by a voucher-providers endpoint. Voucher counts are
/// supplied by the API so this screen never needs to infer them from a list.
class VoucherProviderModel {
  final String businessId;
  final String businessName;
  final String imageUrl;
  final String category;
  final String description;
  final int activeVoucherCount;
  final int? startingPoints;
  final VoucherStatus voucherStatus;

  const VoucherProviderModel({
    required this.businessId,
    required this.businessName,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.activeVoucherCount,
    this.startingPoints,
    this.voucherStatus = VoucherStatus.available,
  });

  factory VoucherProviderModel.fromJson(Map<String, dynamic> json) {
    return VoucherProviderModel(
      businessId: json['business_id']?.toString() ?? '',
      businessName: json['business_name'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      activeVoucherCount: (json['active_voucher_count'] as num?)?.toInt() ?? 0,
      startingPoints: (json['starting_points'] as num?)?.toInt(),
      voucherStatus: VoucherStatusX.fromApiValue(
        json['voucher_status'] as String?,
      ),
    );
  }
}
