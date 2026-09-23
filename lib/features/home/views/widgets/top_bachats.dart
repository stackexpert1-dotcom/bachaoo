import 'package:bachaoo/features/home/models/top_bachat_model.dart';
import 'package:flutter/material.dart';

class TopBachatsSection extends StatefulWidget {
  final String title;
  final List<TopBachatModel> logos;
  final double tileSize;
  final double tileSpacing;
  final ValueChanged<int>? onTileTap;

  const TopBachatsSection({
    super.key,
    this.title = 'Top Bachats',
    required this.logos,
    this.tileSize = 84,
    this.tileSpacing = 8,
    this.onTileTap,
  });

  @override
  State<TopBachatsSection> createState() => _TopBachatsSectionState();
}

class _TopBachatsSectionState extends State<TopBachatsSection>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  AnimationController? _autoScrollController;

  double get _oneSetWidth =>
      (widget.tileSize + widget.tileSpacing) * widget.logos.length;

  @override
  void initState() {
    super.initState();

    // onAttach/onDetach let us listen to the horizontal list's position so
    // the marquee can pause while the user drags it and resume afterwards.
    _scrollController = ScrollController(
      onAttach: _handlePositionAttach,
      onDetach: _handlePositionDetach,
    );

    if (widget.logos.isNotEmpty) {
      final durationMs = (_oneSetWidth / 30 * 1000).round();

      _autoScrollController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: durationMs),
      )..addListener(_onTick);

      // Start after the first frame so the ScrollController is attached.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _autoScrollController?.repeat();
      });
    }
  }

  void _handlePositionAttach(ScrollPosition position) {
    position.isScrollingNotifier.addListener(_handleScrollChange);
  }

  void _handlePositionDetach(ScrollPosition position) {
    position.isScrollingNotifier.removeListener(_handleScrollChange);
  }

  void _handleScrollChange() {
    final controller = _autoScrollController;
    if (controller == null || !_scrollController.hasClients) return;
    controller.value = (_scrollController.offset % _oneSetWidth) / _oneSetWidth;

    if (!_scrollController.position.isScrollingNotifier.value) {
      controller.repeat();
    }
  }

  void _onTick() {
    if (_autoScrollController == null || !_scrollController.hasClients) return;
    if (_scrollController.position.isScrollingNotifier.value) return;
    _scrollController.jumpTo(_autoScrollController!.value * _oneSetWidth);
  }

  @override
  void dispose() {
    _autoScrollController?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildImage(String path) {
    final isNetwork = path.startsWith('http://') || path.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        path,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image_outlined, color: Colors.grey),
      );
    }

    return Image.asset(
      path,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image_outlined, color: Colors.grey),
    );
  }

  Widget _buildTile(int index) {
    final logo = widget.logos[index % widget.logos.length];

    return GestureDetector(
      onTap: widget.onTileTap == null
          ? null
          : () => widget.onTileTap!(index % widget.logos.length),
      child: Container(
        width: widget.tileSize,
        height: widget.tileSize,
        margin: EdgeInsets.only(right: widget.tileSpacing),
        decoration: BoxDecoration(
          // Brand color sits behind the logo so every tile reads as the brand.
          color: logo.brandColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: _buildImage(logo.imageUrl),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.logos.isEmpty) return const SizedBox.shrink();
    final tileCount = widget.logos.length * 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF14213D),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: widget.tileSize,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            // Matches the small card inset used by "Trending deals" so the
            // tiles line up with the other sections (the page column already
            // supplies the horizontal page padding).
            padding: const EdgeInsets.symmetric(horizontal: 2),
            itemCount: tileCount,
            itemBuilder: (context, index) => _buildTile(index),
          ),
        ),
      ],
    );
  }
}
