import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const Color _primary = Color(0xFFCF0269);
const Color _bgLight = Color(0xFFF8F5F7);

// ---------------------------------------------------------------------------
// Mock data
// ---------------------------------------------------------------------------

enum _Badge { none, bestSeller, newArrival }

class _ProductItem {
  const _ProductItem({
    required this.brand,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.discountPct,
    required this.imagePath,
    this.badge = _Badge.none,
    this.isFavourited = false,
  });

  final String brand;
  final String name;
  final int price;
  final int originalPrice;
  final int discountPct;
  final String imagePath;
  final _Badge badge;
  final bool isFavourited;
}

const _kProducts = <_ProductItem>[
  _ProductItem(
    brand: 'Nalli',
    name: 'Kanjeevaram Pure Silk Saree',
    price: 12499,
    originalPrice: 15999,
    discountPct: 20,
    imagePath: 'assets/images/product_list_item_1.jpg',
    badge: _Badge.bestSeller,
  ),
  _ProductItem(
    brand: 'Fabindia',
    name: 'Handloom Cotton Saree',
    price: 3200,
    originalPrice: 4000,
    discountPct: 20,
    imagePath: 'assets/images/product_list_item_2.jpg',
  ),
  _ProductItem(
    brand: 'Meena Bazaar',
    name: 'Midnight Black Georgette',
    price: 6875,
    originalPrice: 8500,
    discountPct: 15,
    imagePath: 'assets/images/product_list_item_3.jpg',
    badge: _Badge.newArrival,
  ),
  _ProductItem(
    brand: 'Kalaniketan',
    name: 'Pastel Floral Chiffon',
    price: 5500,
    originalPrice: 7000,
    discountPct: 22,
    imagePath: 'assets/images/product_list_item_4.jpg',
  ),
  _ProductItem(
    brand: 'Mohey',
    name: 'Traditional Banarasi Silk',
    price: 18900,
    originalPrice: 24000,
    discountPct: 21,
    imagePath: 'assets/images/product_list_item_5.jpg',
  ),
  _ProductItem(
    brand: 'Anita Dongre',
    name: 'Golden Mustard Festive Saree',
    price: 25000,
    originalPrice: 32000,
    discountPct: 10,
    imagePath: 'assets/images/product_list_item_6.jpg',
    isFavourited: true,
  ),
];

const _kCategories = <String>[
  'All',
  'Silk',
  'Cotton',
  'Georgette',
  'Chiffon',
  'Banarasi',
];

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  int _selectedCategory = 0;
  late final List<bool> _favourites;

  @override
  void initState() {
    super.initState();
    _favourites = _kProducts.map((p) => p.isFavourited).toList();
  }

  void _toggleFavourite(int index) {
    setState(() => _favourites[index] = !_favourites[index]);
  }

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
                _ProductListAppBar(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (i) =>
                      setState(() => _selectedCategory = i),
                ),
                const _SortFilterBar(),
                _ProductGrid(
                  products: _kProducts,
                  favourites: _favourites,
                  onFavouriteTap: _toggleFavourite,
                ),
                // Bottom nav clearance
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _BottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App Bar (sticky header + category chips)
// ---------------------------------------------------------------------------

class _ProductListAppBar extends StatelessWidget {
  const _ProductListAppBar({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final int selectedCategory;
  final ValueChanged<int> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _AppBarDelegate(
        selectedCategory: selectedCategory,
        onCategorySelected: onCategorySelected,
      ),
    );
  }
}

class _AppBarDelegate extends SliverPersistentHeaderDelegate {
  const _AppBarDelegate({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final int selectedCategory;
  final ValueChanged<int> onCategorySelected;

  static const double _appBarHeight = 64.0;
  static const double _chipsHeight = 56.0;
  static const double _totalHeight = _appBarHeight + _chipsHeight;

  @override
  double get minExtent => _totalHeight;
  @override
  double get maxExtent => _totalHeight;

  @override
  bool shouldRebuild(_AppBarDelegate old) =>
      old.selectedCategory != selectedCategory;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: _bgLight.withValues(alpha: 0.92),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title row
          SizedBox(
            height: _appBarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {}, // TODO: navigator.pop
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Text(
                      'Sarees',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: Color(0xFF0D0D0D),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {}, // TODO: navigate to search
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined),
                    onPressed: () {}, // TODO: navigate to cart
                  ),
                ],
              ),
            ),
          ),
          // Category chips
          SizedBox(
            height: _chipsHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _kCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => _CategoryChip(
                label: _kCategories[i],
                isSelected: i == selectedCategory,
                onTap: () => onCategorySelected(i),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? _primary : _primary.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? Colors.white : _primary,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sort & Filter bar
// ---------------------------------------------------------------------------

class _SortFilterBar extends StatelessWidget {
  const _SortFilterBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: _bgLight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: _SortFilterButton(
                      icon: Icons.swap_vert,
                      label: 'Sort',
                      onTap: () {}, // TODO: show sort sheet
                    ),
                  ),
                  const VerticalDivider(width: 1, color: Color(0x1ACF0269)),
                  Expanded(
                    child: _SortFilterButton(
                      icon: Icons.tune,
                      label: 'Filter',
                      onTap: () {}, // TODO: show filter sheet
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0x0DCF0269)),
          ],
        ),
      ),
    );
  }
}

class _SortFilterButton extends StatelessWidget {
  const _SortFilterButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: const Color(0xFF4A4A4A)),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A4A4A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Product Grid
// ---------------------------------------------------------------------------

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.products,
    required this.favourites,
    required this.onFavouriteTap,
  });

  final List<_ProductItem> products;
  final List<bool> favourites;
  final ValueChanged<int> onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _ProductCard(
            item: products[index],
            isFavourited: favourites[index],
            onFavouriteTap: () => onFavouriteTap(index),
          ),
          childCount: products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 32,
          childAspectRatio: 0.55,
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.item,
    required this.isFavourited,
    required this.onFavouriteTap,
  });

  final _ProductItem item;
  final bool isFavourited;
  final VoidCallback onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // TODO: navigate to product detail
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(
            imagePath: item.imagePath,
            badge: item.badge,
            isFavourited: isFavourited,
            onFavouriteTap: onFavouriteTap,
          ),
          const SizedBox(height: 10),
          _ProductInfo(item: item),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.imagePath,
    required this.badge,
    required this.isFavourited,
    required this.onFavouriteTap,
  });

  final String imagePath;
  final _Badge badge;
  final bool isFavourited;
  final VoidCallback onFavouriteTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          // Favourite button
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: onFavouriteTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.80),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  isFavourited ? Icons.favorite : Icons.favorite_border,
                  size: 18,
                  color: isFavourited ? _primary : const Color(0xFF9E9E9E),
                ),
              ),
            ),
          ),
          // Badge
          if (badge != _Badge.none)
            Positioned(
              bottom: 8,
              left: badge == _Badge.bestSeller ? 8 : null,
              top: badge == _Badge.newArrival ? 8 : null,
              child: _BadgeLabel(badge: badge),
            ),
        ],
      ),
    );
  }
}

class _BadgeLabel extends StatelessWidget {
  const _BadgeLabel({required this.badge});

  final _Badge badge;

  @override
  Widget build(BuildContext context) {
    final isBestSeller = badge == _Badge.bestSeller;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isBestSeller
            ? _primary
            : const Color(0xFF0D0D0D).withValues(alpha: 0.80),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isBestSeller ? 'Best Seller' : 'New Arrival',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({required this.item});

  final _ProductItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.brand.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: _primary,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              '₹${_fmt(item.price)}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '₹${_fmt(item.originalPrice)}',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF9E9E9E),
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${item.discountPct}% OFF',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _fmt(int value) {
    // Simple thousands formatter
    final s = value.toString();
    if (s.length <= 3) return s;
    final buffer = StringBuffer();
    final offset = s.length % 3;
    if (offset > 0) {
      buffer.write(s.substring(0, offset));
      if (s.length > offset) buffer.write(',');
    }
    for (int i = offset; i < s.length; i += 3) {
      buffer.write(s.substring(i, i + 3));
      if (i + 3 < s.length) buffer.write(',');
    }
    return buffer.toString();
  }
}

// ---------------------------------------------------------------------------
// Bottom Navigation Bar
// ---------------------------------------------------------------------------

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: _bgLight.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(color: _primary.withValues(alpha: 0.10)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            active: false,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.grid_view,
            label: 'Category',
            active: true,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.favorite_border,
            label: 'Wishlist',
            active: false,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.shopping_bag_outlined,
            label: 'Cart',
            active: false,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            active: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? _primary : const Color(0xFF757575);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
