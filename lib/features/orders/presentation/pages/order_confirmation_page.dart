import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const Color _primary = Color(0xFFA10050);
const Color _primaryDeep = Color(0xFFCD0268);
const Color _bgSurface = Color(0xFFFAF8FF);
const Color _surfaceContainerLow = Color(0xFFF2F3FF);
const Color _onSurface = Color(0xFF151B2C);
const Color _onSurfaceVariant = Color(0xFF5A4046);
const Color _outlineVariant = Color(0xFFE2BDC5);
const Color _secondary = Color(0xFF00677C);
const Color _tertiary = Color(0xFF98195C);

// ---------------------------------------------------------------------------
// Mock data
// ---------------------------------------------------------------------------

class _OrderItem {
  const _OrderItem({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imagePath,
  });

  final String name;
  final String subtitle;
  final int price;
  final String imagePath;
}

const _kOrderItems = <_OrderItem>[
  _OrderItem(
    name: 'Banarasi Silk Saree',
    subtitle: 'Signature Collection • Rose Gold',
    price: 3450,
    imagePath: 'assets/images/order_item_saree.jpg',
  ),
  _OrderItem(
    name: 'Zari Work Dupatta',
    subtitle: 'Handcrafted • Crimson Red',
    price: 800,
    imagePath: 'assets/images/order_item_dupatta.jpg',
  ),
];

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgSurface,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const _ConfirmationAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                    child: Column(
                      children: [
                        const _SuccessSection(),
                        const SizedBox(height: 32),
                        const _DeliveryStatusCard(),
                        const SizedBox(height: 20),
                        const _OrderItemsCard(items: _kOrderItems),
                        const SizedBox(height: 20),
                        const _ShippingCard(),
                        const SizedBox(height: 32),
                        const _ActionButtons(),
                        // bottom nav clearance
                        const SizedBox(height: 100),
                      ],
                    ),
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

class _ConfirmationAppBar extends StatelessWidget {
  const _ConfirmationAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: _bgSurface,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: _primary),
              onPressed: () {}, // TODO: navigator.pop
            ),
            const Expanded(
              child: Text(
                'THE PRECISION ATELIER',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.4,
                  color: _onSurface,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, color: _primary),
              onPressed: () {}, // TODO: navigate to cart
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Success Section
// ---------------------------------------------------------------------------

class _SuccessSection extends StatelessWidget {
  const _SuccessSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Circle with check icon
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _surfaceContainerLow,
                ),
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      _primary.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const Icon(Icons.check_circle_rounded, color: _primary, size: 52),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Order Placed\nSuccessfully!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: -0.5,
            color: _onSurface,
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: _onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            children: const [
              TextSpan(
                text: 'Thank you for your purchase, Mukesh. Your order ',
              ),
              TextSpan(
                text: '#54821',
                style: TextStyle(color: _primary, fontWeight: FontWeight.w700),
              ),
              TextSpan(text: ' is being prepared by our artisans.'),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Delivery Status Card
// ---------------------------------------------------------------------------

class _DeliveryStatusCard extends StatelessWidget {
  const _DeliveryStatusCard();

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Row(
        children: [
          Expanded(
            child: _StatusTile(
              iconBgColor: const Color(0xFF97E5FE).withValues(alpha: 0.30),
              icon: Icons.local_shipping_outlined,
              iconColor: _secondary,
              label: 'Estimated Delivery',
              value: '22 March 2026',
            ),
          ),
          Container(
            width: 1,
            height: 48,
            color: _outlineVariant.withValues(alpha: 0.30),
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          Expanded(
            child: _StatusTile(
              iconBgColor: const Color(0xFFFFD9E4).withValues(alpha: 0.40),
              icon: Icons.inventory_2_outlined,
              iconColor: _tertiary,
              label: 'Order Total',
              value: '₹4,250',
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({
    required this.iconBgColor,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final Color iconBgColor;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: _onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Order Items Card
// ---------------------------------------------------------------------------

class _OrderItemsCard extends StatelessWidget {
  const _OrderItemsCard({required this.items});

  final List<_OrderItem> items;

  @override
  Widget build(BuildContext context) {
    return _SurfaceCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order Items',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _onSurface,
                ),
              ),
              Text(
                '${items.length} Articles',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: item == items.last ? 0 : 20),
              child: _OrderItemRow(item: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({required this.item});

  final _OrderItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 56,
            height: 70,
            child: Image.asset(item.imagePath, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                item.subtitle,
                style: const TextStyle(fontSize: 12, color: _onSurfaceVariant),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '₹${item.price}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _onSurface,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shipping Card
// ---------------------------------------------------------------------------

class _ShippingCard extends StatelessWidget {
  const _ShippingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _outlineVariant.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.location_on_outlined, color: _primary, size: 20),
              SizedBox(width: 10),
              Text(
                'Shipping',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Mukesh Sharma',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _onSurface,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '42, Heritage Enclave,\nPrithvi Raj Road, Jaipur,\nRajasthan – 302001',
            style: TextStyle(
              fontSize: 13,
              height: 1.8,
              color: _onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.60),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _outlineVariant.withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'CONTACT DETAILS',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    color: _onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '+91 98XXX X4211',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _onSurface,
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
// Action Buttons
// ---------------------------------------------------------------------------

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Track My Order — gradient primary
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_primary, _primaryDeep],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _primary.withValues(alpha: 0.25),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {}, // TODO: navigate to order tracking
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Track My Order',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Continue Shopping — outline
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {}, // TODO: navigate to home/shop
            style: OutlinedButton.styleFrom(
              foregroundColor: _onSurface,
              minimumSize: const Size(double.infinity, 56),
              side: BorderSide(color: _outlineVariant.withValues(alpha: 0.40)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Continue Shopping',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Shared Surface Card
// ---------------------------------------------------------------------------

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _outlineVariant.withValues(alpha: 0.15)),
      ),
      child: child,
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
        color: Colors.white.withValues(alpha: 0.75),
        border: Border(
          top: BorderSide(color: _outlineVariant.withValues(alpha: 0.20)),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: _onSurface.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.storefront_outlined,
            label: 'Atelier',
            active: false,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.receipt_long_outlined,
            label: 'Orders',
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
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: active
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: active
            ? BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_primary, _primaryDeep],
                ),
                borderRadius: BorderRadius.circular(24),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: active ? Colors.white : _onSurface),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: active ? Colors.white : _onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
