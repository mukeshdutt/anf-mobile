import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const Color _primary = Color(0xFFCF0269);
const Color _bgLight = Color(0xFFF8F5F7);
const Color _secondary = Color(0xFF34889E);

// ---------------------------------------------------------------------------
// Mock data
// ---------------------------------------------------------------------------

const _kImages = <String>[
  'assets/images/product_detail_hero.jpg',
  'assets/images/product_detail_hero.jpg',
  'assets/images/product_detail_hero.jpg',
  'assets/images/product_detail_hero.jpg',
];

const _kColors = <Color>[
  Color(0xFF8B0000),
  Color(0xFF002366),
  Color(0xFFFFD700),
];

const _kRatingBars = <_RatingBar>[
  _RatingBar(stars: 5, pct: 0.80),
  _RatingBar(stars: 4, pct: 0.15),
  _RatingBar(stars: 3, pct: 0.05),
];

// ---------------------------------------------------------------------------
// Simple value objects
// ---------------------------------------------------------------------------

class _RatingBar {
  const _RatingBar({required this.stars, required this.pct});
  final int stars;
  final double pct;
}

class _AccordionSection {
  _AccordionSection({required this.title, this.body, this.expanded = false});
  final String title;
  final String? body;
  bool expanded;
}

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentImage = 0;
  int _selectedColor = 0;
  bool _isFavourited = false;

  late final List<_AccordionSection> _sections = [
    _AccordionSection(
      title: 'Product Description',
      body:
          'Experience elegance with this handwoven pure silk saree featuring '
          'intricate zari work. Perfect for weddings and festive occasions. '
          'This masterpiece represents centuries of weaving tradition from '
          'Varanasi.',
      expanded: true,
    ),
    _AccordionSection(title: 'Fabric & Care'),
    _AccordionSection(title: 'Shipping & Returns'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const _DetailAppBar(),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ImageGallery(
                        images: _kImages,
                        currentIndex: _currentImage,
                        onPageChanged: (i) => setState(() => _currentImage = i),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _ProductHeaderInfo(),
                            const SizedBox(height: 20),
                            _ColorSelector(
                              colors: _kColors,
                              selected: _selectedColor,
                              onSelect: (i) =>
                                  setState(() => _selectedColor = i),
                            ),
                            const SizedBox(height: 20),
                            const _SizeSelector(),
                            const SizedBox(height: 20),
                            _AccordionGroup(
                              sections: _sections,
                              onToggle: (i) => setState(
                                () => _sections[i].expanded =
                                    !_sections[i].expanded,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const _RatingSection(),
                            // Bottom action bar clearance
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Sticky bottom action bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _BottomActionBar(
                isFavourited: _isFavourited,
                onFavouriteTap: () =>
                    setState(() => _isFavourited = !_isFavourited),
                onAddToCart: () {}, // TODO: dispatch AddToCart event
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App Bar
// ---------------------------------------------------------------------------

class _DetailAppBar extends StatelessWidget {
  const _DetailAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: _bgLight.withValues(alpha: 0.85),
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
              onPressed: () {}, // TODO: navigator.pop
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search, color: Color(0xFF1A1A1A)),
              onPressed: () {}, // TODO: navigate to search
            ),
            _CartIconButton(count: 1, onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class _CartIconButton extends StatelessWidget {
  const _CartIconButton({required this.count, required this.onTap});
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Color(0xFF1A1A1A),
          ),
          onPressed: onTap, // TODO: navigate to cart
        ),
        if (count > 0)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: _primary,
                shape: BoxShape.circle,
                border: Border.all(color: _bgLight, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Image Gallery
// ---------------------------------------------------------------------------

class _ImageGallery extends StatelessWidget {
  const _ImageGallery({
    required this.images,
    required this.currentIndex,
    required this.onPageChanged,
  });

  final List<String> images;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Stack(
          children: [
            // Gallery page view
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: PageView.builder(
                itemCount: images.length,
                onPageChanged: onPageChanged,
                itemBuilder: (_, i) => Image.asset(
                  images[i],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            // Page indicator dots
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      images.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: i == currentIndex
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.40),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Share button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () {}, // TODO: share product
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.90),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.share_outlined,
                    size: 18,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Product Header Info
// ---------------------------------------------------------------------------

class _ProductHeaderInfo extends StatelessWidget {
  const _ProductHeaderInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'HANDCRAFTED COLLECTION',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: _primary,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFDD835).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star_rounded, size: 16, color: Color(0xFF9A7700)),
                  SizedBox(width: 3),
                  Text(
                    '4.8 (120 Reviews)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF7A5F00),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Handwoven Banarasi Silk Saree',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A1A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const Text(
              '₹4,999',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              '₹12,499',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF9E9E9E),
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '60% OFF',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Color Selector
// ---------------------------------------------------------------------------

class _ColorSelector extends StatelessWidget {
  const _ColorSelector({
    required this.colors,
    required this.selected,
    required this.onSelect,
  });

  final List<Color> colors;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Color',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4A4A4A),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(
            colors.length,
            (i) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors[i],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.10),
                    ),
                    boxShadow: i == selected
                        ? [
                            BoxShadow(
                              color: _primary.withValues(alpha: 0.35),
                              blurRadius: 0,
                              spreadRadius: 2,
                              offset: const Offset(0, 0),
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Size Selector
// ---------------------------------------------------------------------------

class _SizeSelector extends StatelessWidget {
  const _SizeSelector();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Size & Fit',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A4A4A),
              ),
            ),
            TextButton(
              onPressed: () {}, // TODO: show size guide
              style: TextButton.styleFrom(
                foregroundColor: _secondary,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'SIZE GUIDE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: _primary, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: _primary.withValues(alpha: 0.05),
          ),
          child: const Text(
            'One Size (Standard)',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _primary,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Accordion Group
// ---------------------------------------------------------------------------

class _AccordionGroup extends StatelessWidget {
  const _AccordionGroup({required this.sections, required this.onToggle});

  final List<_AccordionSection> sections;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: List.generate(sections.length, (i) {
          final isLast = i == sections.length - 1;
          return Column(
            children: [
              _AccordionTile(section: sections[i], onTap: () => onToggle(i)),
              if (!isLast) const Divider(height: 1, color: Color(0xFFF1F5F9)),
            ],
          );
        }),
      ),
    );
  }
}

class _AccordionTile extends StatelessWidget {
  const _AccordionTile({required this.section, required this.onTap});
  final _AccordionSection section;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Icon(
                  section.expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF94A3B8),
                  size: 22,
                ),
              ],
            ),
            if (section.expanded && section.body != null) ...[
              const SizedBox(height: 10),
              Text(
                section.body!,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Rating Section
// ---------------------------------------------------------------------------

class _RatingSection extends StatelessWidget {
  const _RatingSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score + stars
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '4.8',
                style: TextStyle(
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A1A),
                  height: 1.0,
                  letterSpacing: -2,
                ),
              ),
              const SizedBox(height: 4),
              const _StarRow(),
              const SizedBox(height: 6),
              const Text(
                '120 VERIFIED REVIEWS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // Bar breakdown
          Expanded(
            child: Column(
              children: _kRatingBars
                  .map((rb) => _RatingBarRow(bar: rb))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  const _StarRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.star_rounded, size: 18, color: _primary),
        Icon(Icons.star_rounded, size: 18, color: _primary),
        Icon(Icons.star_rounded, size: 18, color: _primary),
        Icon(Icons.star_rounded, size: 18, color: _primary),
        Icon(Icons.star_half_rounded, size: 18, color: _primary),
      ],
    );
  }
}

class _RatingBarRow extends StatelessWidget {
  const _RatingBarRow({required this.bar});
  final _RatingBar bar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 12,
            child: Text(
              '${bar.stars}',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A4A4A),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: bar.pct,
                minHeight: 6,
                backgroundColor: const Color(0xFFF1F5F9),
                valueColor: const AlwaysStoppedAnimation<Color>(_primary),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 30,
            child: Text(
              '${(bar.pct * 100).toInt()}%',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom Action Bar
// ---------------------------------------------------------------------------

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.isFavourited,
    required this.onFavouriteTap,
    required this.onAddToCart,
  });

  final bool isFavourited;
  final VoidCallback onFavouriteTap;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        16 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        border: const Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          // Favourite button
          GestureDetector(
            onTap: onFavouriteTap,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isFavourited
                      ? _primary.withValues(alpha: 0.30)
                      : const Color(0xFFE2E8F0),
                  width: 2,
                ),
              ),
              child: Icon(
                isFavourited ? Icons.favorite : Icons.favorite_border,
                size: 26,
                color: isFavourited ? _primary : const Color(0xFF9E9E9E),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Add to Cart button
          Expanded(
            child: FilledButton.icon(
              onPressed: onAddToCart,
              icon: const Icon(Icons.shopping_bag_outlined, size: 20),
              label: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: _primary.withValues(alpha: 0.35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
