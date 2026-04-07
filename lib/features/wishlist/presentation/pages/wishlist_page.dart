import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Mock model – replace with real domain entity when ready
// ---------------------------------------------------------------------------
class _WishlistItem {
  const _WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  final String id;
  final String name;
  final String price;
  final String imagePath;
}

const List<_WishlistItem> _mockItems = [
  _WishlistItem(
    id: '1',
    name: 'Banarasi Silk Saree',
    price: '₹4,999',
    imagePath: 'assets/images/wishlist_item_1.jpg',
  ),
  _WishlistItem(
    id: '2',
    name: 'Floral Printed Anarkali',
    price: '₹2,499',
    imagePath: 'assets/images/wishlist_item_2.jpg',
  ),
  _WishlistItem(
    id: '3',
    name: 'Chanderi Silk Kurta',
    price: '₹1,899',
    imagePath: 'assets/images/wishlist_item_3.jpg',
  ),
  _WishlistItem(
    id: '4',
    name: 'Embroidered Lehenga',
    price: '₹7,500',
    imagePath: 'assets/images/wishlist_item_4.jpg',
  ),
];

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------
class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  static const Color _bgLight = Color(0xFFF8F5F7);

  @override
  Widget build(BuildContext context) {
    // TODO: replace _mockItems with state from bloc/provider
    final items = _mockItems;

    return Scaffold(
      backgroundColor: _bgLight,
      appBar: _WishlistAppBar(itemCount: items.length),
      body: items.isEmpty
          ? const _EmptyWishlist()
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.58,
                ),
                itemBuilder: (context, index) =>
                    _WishlistCard(item: items[index]),
              ),
            ),
      bottomNavigationBar: const _BottomNavBar(activeIndex: 2),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar
// ---------------------------------------------------------------------------
class _WishlistAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _WishlistAppBar({required this.itemCount});

  final int itemCount;

  static const Color _primary = Color(0xFFCF0269);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xF2F8F5F7), // ~background-light/80
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _primary),
        onPressed: () => Navigator.maybePop(context),
        style: IconButton.styleFrom(shape: const CircleBorder()),
      ),
      title: const Text(
        'My Wishlist',
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Chip(
            label: Text(
              '$itemCount Items',
              style: const TextStyle(
                color: _primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: _primary.withValues(alpha: 0.10),
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 4),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: _primary.withValues(alpha: 0.10),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Wishlist card
// ---------------------------------------------------------------------------
class _WishlistCard extends StatelessWidget {
  const _WishlistCard({required this.item});

  final _WishlistItem item;

  static const Color _primary = Color(0xFFCF0269);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primary.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Product image ────────────────────────────────────────────
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(item.imagePath, fit: BoxFit.cover),
                // Remove from wishlist button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: dispatch remove-from-wishlist event
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.90),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: _primary,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Info + CTA ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.price,
                  style: const TextStyle(
                    color: _primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      // TODO: dispatch add-to-cart event
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: _primary,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(Icons.shopping_bag_outlined, size: 15),
                    label: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty state
// ---------------------------------------------------------------------------
class _EmptyWishlist extends StatelessWidget {
  const _EmptyWishlist();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: const Color(0xFFCF0269).withValues(alpha: 0.30),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your wishlist is empty',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom navigation bar
// ---------------------------------------------------------------------------
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.activeIndex});

  final int activeIndex;

  static const Color _primary = Color(0xFFCF0269);
  static const Color _bgLight = Color(0xFFF8F5F7);

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    (icon: Icons.search_outlined, activeIcon: Icons.search, label: 'Shop'),
    (
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
      label: 'Wishlist',
    ),
    (
      icon: Icons.local_mall_outlined,
      activeIcon: Icons.local_mall,
      label: 'Orders',
    ),
    (icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _bgLight,
        border: Border(
          top: BorderSide(color: _primary.withValues(alpha: 0.10)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final active = i == activeIndex;
              final item = _items[i];
              return InkWell(
                onTap: () {
                  // TODO: navigate to tab i
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? item.activeIcon : item.icon,
                        color: active ? _primary : const Color(0xFF64748B),
                        size: 24,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.label.toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: active
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: active ? _primary : const Color(0xFF64748B),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
