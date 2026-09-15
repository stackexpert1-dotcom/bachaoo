import 'package:intl/intl.dart';

enum ReferralStatus { joined, pending }

class ReferralModel {
  final String id;
  final String name;
  final ReferralStatus status;
  final DateTime? joinedDate; // null while pending
  final int? pointsEarned; // null while pending

  const ReferralModel({
    required this.id,
    required this.name,
    required this.status,
    this.joinedDate,
    this.pointsEarned,
  });

  /// "Ahmed K." -> "AK". Falls back to the first letter if there's no space.
  String get initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts[1].substring(0, 1))
        .toUpperCase();
  }

  String get statusLabel {
    if (status == ReferralStatus.pending) return 'Signed up, not yet verified';
    if (joinedDate != null)
      return 'Joined ${DateFormat('d MMM').format(joinedDate!)}';
    return 'Joined';
  }

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      id: json['id'] as String,
      name: json['name'] as String,
      status: ReferralStatus.values.firstWhere((s) => s.name == json['status']),
      joinedDate: json['joinedDate'] != null
          ? DateTime.parse(json['joinedDate'] as String)
          : null,
      pointsEarned: json['pointsEarned'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status.name,
    'joinedDate': joinedDate?.toIso8601String(),
    'pointsEarned': pointsEarned,
  };
}
