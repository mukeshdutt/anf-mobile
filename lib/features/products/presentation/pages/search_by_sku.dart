import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const Color _primary = Color(0xFFCF0269);
const Color _bgLight = Color(0xFFF8F5F7);

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class SearchBySkuPage extends StatefulWidget {
  const SearchBySkuPage({super.key});

  @override
  State<SearchBySkuPage> createState() => _SearchBySkuPageState();
}

class _SearchBySkuPageState extends State<SearchBySkuPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _recentSearches = [
    'ANK-SR-101',
    'ANK-KT-502',
    'ANK-PL-099',
  ];

  void _removeRecent(String sku) {
    setState(() => _recentSearches.remove(sku));
  }

  void _clearAll() {
    setState(() => _recentSearches.clear());
  }

  void _onSearch() {
    // TODO: dispatch SKU search event
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                const _SkuAppBar(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 100),
                    children: [
                      _SearchSection(
                        controller: _controller,
                        onSearch: _onSearch,
                      ),
                      const _SearchTipsCard(),
                      if (_recentSearches.isNotEmpty)
                        _RecentSearchesSection(
                          searches: _recentSearches,
                          onRemove: _removeRecent,
                          onClearAll: _clearAll,
                        ),
                      const _EmptyState(),
                    ],
                  ),
                ),
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
// App Bar
// ---------------------------------------------------------------------------

class _SkuAppBar extends StatelessWidget {
  const _SkuAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: _bgLight,
        border: Border(
          bottom: BorderSide(color: _primary.withValues(alpha: 0.10)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: _primary),
            onPressed: () {}, // TODO: navigator.pop
          ),
          const SizedBox(width: 4),
          const Text(
            'Search by SKU',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Search Section
// ---------------------------------------------------------------------------

class _SearchSection extends StatelessWidget {
  const _SearchSection({required this.controller, required this.onSearch});

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          // Text field
          TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => onSearch(),
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: 'Enter SKU ID (e.g., ANK-SR-101)',
              hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.search,
                  color: _primary.withValues(alpha: 0.60),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 48),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _primary.withValues(alpha: 0.10),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _primary, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Search button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onSearch,
              icon: const Icon(Icons.qr_code_scanner_outlined, size: 20),
              label: const Text(
                'Search SKU',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                shadowColor: _primary.withValues(alpha: 0.25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Search Tips Card
// ---------------------------------------------------------------------------

class _SearchTipsCard extends StatelessWidget {
  const _SearchTipsCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.05),
          border: Border.all(color: _primary.withValues(alpha: 0.10)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.lightbulb_outline, color: _primary, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Search Tips',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _primary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Find the SKU ID printed on the physical product tags '
                    'or within the order details page.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recent Searches
// ---------------------------------------------------------------------------

class _RecentSearchesSection extends StatelessWidget {
  const _RecentSearchesSection({
    required this.searches,
    required this.onRemove,
    required this.onClearAll,
  });

  final List<String> searches;
  final ValueChanged<String> onRemove;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'RECENT SEARCHES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: Color(0xFF757575),
                ),
              ),
              TextButton(
                onPressed: onClearAll,
                style: TextButton.styleFrom(
                  foregroundColor: _primary,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Clear All',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: searches
                .map(
                  (sku) =>
                      _RecentChip(label: sku, onRemove: () => onRemove(sku)),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _RecentChip extends StatelessWidget {
  const _RecentChip({required this.label, required this.onRemove});

  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF4A4A4A)),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 14, color: Color(0xFF9E9E9E)),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty State
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
      child: Column(
        children: [
          // Pulsing circle with icon
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.find_in_page_outlined,
              size: 80,
              color: Color(0x4DCF0269),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No results yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter an SKU ID above to view product\navailability, pricing, and variant details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Color(0xFF757575),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: const [
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.inventory_2_outlined,
                  label: 'Check Stock',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _QuickActionCard(
                  icon: Icons.local_shipping_outlined,
                  label: 'Track Order',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // TODO: navigate to respective screen
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: _primary, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ],
        ),
      ),
    );
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
      padding: EdgeInsets.fromLTRB(
        16,
        8,
        16,
        8 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        border: const Border(top: BorderSide(color: Color(0xFFE2E8F0))),
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
            icon: Icons.search,
            label: 'Search',
            active: true,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.receipt_long_outlined,
            label: 'Orders',
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
    final color = active ? _primary : const Color(0xFF9E9E9E);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
