class ReviewModel {
  final String reviewerName;
  final int rating; // 1–5
  final String comment;

  const ReviewModel({
    required this.reviewerName,
    required this.rating,
    required this.comment,
  });

  /// e.g. "Ahmed K." → "AK"
  String get initials {
    final parts = reviewerName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewerName: json['reviewer_name'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'reviewer_name': reviewerName,
    'rating': rating,
    'comment': comment,
  };
}
