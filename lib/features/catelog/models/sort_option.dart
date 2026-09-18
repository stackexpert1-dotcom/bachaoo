enum SortOption {
  defaultOrder,
  aToZ,
  zToA,
  trending,
  popular,
  newest,
  recommended,
}

extension SortOptionLabel on SortOption {
  String get label {
    switch (this) {
      case SortOption.defaultOrder:
        return 'Default';
      case SortOption.aToZ:
        return 'A to Z';
      case SortOption.zToA:
        return 'Z to A';
      case SortOption.trending:
        return 'Trending';
      case SortOption.popular:
        return 'Popular';
      case SortOption.newest:
        return 'Newest';
      case SortOption.recommended:
        return 'Recommended';
    }
  }
}
