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
    this.tileSpacing = 14,
    this.onTileTap,
  });

  @override
  State<TopBachatsSection> createState() => _TopBachatsSectionState();
}

class _TopBachatsSectionState extends State<TopBachatsSection> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
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
          borderRadius: BorderRadius.circular(18),
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF14213D),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: widget.tileSize,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            // Let the user swipe horizontally through the brands.
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.logos.length,
            itemBuilder: (context, index) => _buildTile(index),
          ),
        ),
      ],
    );
  }
}
