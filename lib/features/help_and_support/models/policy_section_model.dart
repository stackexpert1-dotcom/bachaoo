class PolicySection {
  final String heading;
  final String body;

  const PolicySection({required this.heading, required this.body});
}

class PolicyContent {
  final String title;
  final String metaLabel; // e.g. "Updated 1 Sep 2026 · 5 min read"
  final List<PolicySection> sections;

  const PolicyContent({
    required this.title,
    required this.metaLabel,
    required this.sections,
  });
}
