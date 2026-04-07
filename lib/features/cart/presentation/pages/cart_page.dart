import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Mock models – replace with real domain entities when ready
// ---------------------------------------------------------------------------
class _CartItem {
  _CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.variant,
    required this.imagePath,
  });

  final String id;
  final String name;
  final double price;
  final String variant;
  final String imagePath;
  int quantity = 1;
}

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const Color _bgLight = Color(0xFFF8F5F7);

  final _promoController = TextEditingController();

  // TODO: replace with cart state from bloc/provider
  final List<_CartItem> _items = [
    _CartItem(
      id: '1',
      name: 'Embroidered Silk Saree',
      price: 120.00,
      variant: 'Size: FS | Color: Royal Blue',
      imagePath: 'assets/images/cart_item_1.jpg',
    ),
    _CartItem(
      id: '2',
      name: 'Floral Print Kurta Set',
      price: 85.00,
      variant: 'Size: M | Color: Blush Pink',
      imagePath: 'assets/images/cart_item_2.jpg',
    ),
  ];

  // Discount applied by promo code
  double _discount = 20.00;

  double get _bagTotal =>
      _items.fold(0, (sum, i) => sum + i.price * i.quantity);
  double get _totalAmount => _bagTotal - _discount;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _decrementQty(_CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        _items.remove(item);
      }
    });
  }

  void _incrementQty(_CartItem item) {
    setState(() => item.quantity++);
  }

  void _removeItem(_CartItem item) {
    setState(() => _items.remove(item));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: _CartAppBar(itemCount: _items.length),
      body: _items.isEmpty
          ? const _EmptyCart()
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                // ── Cart items ──────────────────────────────────────────
                ..._items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _CartItemCard(
                      item: item,
                      onDecrement: () => _decrementQty(item),
                      onIncrement: () => _incrementQty(item),
                      onRemove: () => _removeItem(item),
                      onSaveLater: () {
                        // TODO: move to wishlist
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // ── Coupons & Offers ────────────────────────────────────
                _CouponSection(
                  controller: _promoController,
                  onApply: () {
                    // TODO: validate promo code
                  },
                ),

                const SizedBox(height: 16),

                // ── Order Summary ───────────────────────────────────────
                _OrderSummary(
                  bagTotal: _bagTotal,
                  discount: _discount,
                  totalAmount: _totalAmount,
                ),

                const SizedBox(height: 16),

                // ── Trust badges ────────────────────────────────────────
                const _TrustBadges(),
              ],
            ),
      bottomNavigationBar: _CartBottomBar(
        onCheckout: () {
          // TODO: navigate to checkout
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// AppBar
// ---------------------------------------------------------------------------
class _CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CartAppBar({required this.itemCount});

  final int itemCount;

  static const Color _primary = Color(0xFFCF0269);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xF2F8F5F7),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.maybePop(context),
        style: IconButton.styleFrom(shape: const CircleBorder()),
      ),
      title: Text(
        'Shopping Cart ($itemCount ${itemCount == 1 ? 'item' : 'items'})',
        style: const TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 17,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: _primary),
          onPressed: () {
            // TODO: navigate to wishlist
          },
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
// Cart item card
// ---------------------------------------------------------------------------
class _CartItemCard extends StatelessWidget {
  const _CartItemCard({
    required this.item,
    required this.onDecrement,
    required this.onIncrement,
    required this.onRemove,
    required this.onSaveLater,
  });

  final _CartItem item;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final VoidCallback onRemove;
  final VoidCallback onSaveLater;

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
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item.imagePath,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onRemove,
                        icon: const Icon(Icons.delete_outline, size: 20),
                        color: const Color(0xFF94A3B8),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(24, 24),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: _primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.variant,
                    style: TextStyle(
                      color: Colors.blueGrey.shade400,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // Quantity stepper
                      _QuantityStepper(
                        quantity: item.quantity,
                        onDecrement: onDecrement,
                        onIncrement: onIncrement,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: onSaveLater,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Save for later',
                          style: TextStyle(
                            color: _primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
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
// Quantity stepper
// ---------------------------------------------------------------------------
class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  static const Color _bgLight = Color(0xFFF8F5F7);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _bgLight,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _StepperButton(icon: Icons.remove, onTap: onDecrement),
            SizedBox(
              width: 28,
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            _StepperButton(icon: Icons.add, onTap: onIncrement),
          ],
        ),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  static const Color _primary = Color(0xFFCF0269);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, size: 14, color: _primary),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Coupons section
// ---------------------------------------------------------------------------
class _CouponSection extends StatelessWidget {
  const _CouponSection({required this.controller, required this.onApply});

  final TextEditingController controller;
  final VoidCallback onApply;

  static const Color _primary = Color(0xFFCF0269);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.sell_outlined, color: _primary, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Coupons & Offers',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.blueGrey.shade300,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F5F7),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: onApply,
                style: TextButton.styleFrom(
                  backgroundColor: _primary.withValues(alpha: 0.10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: _primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SAVE20',
                  style: TextStyle(
                    color: _primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Apply to get 20% off on your first order',
                style: TextStyle(fontSize: 11, color: Colors.blueGrey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Order summary
// ---------------------------------------------------------------------------
class _OrderSummary extends StatelessWidget {
  const _OrderSummary({
    required this.bagTotal,
    required this.discount,
    required this.totalAmount,
  });

  final double bagTotal;
  final double discount;
  final double totalAmount;

  static const Color _primary = Color(0xFFCF0269);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          _SummaryRow(
            label: 'Bag Total',
            value: '\$${bagTotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'Bag Discount',
            value: '-\$${discount.toStringAsFixed(2)}',
            valueColor: const Color(0xFF16A34A),
          ),
          const SizedBox(height: 10),
          _SummaryRow(label: 'Delivery Charges', value: 'FREE'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          ),
          Row(
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                '\$${totalAmount.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: _primary,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.blueGrey.shade500),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: valueColor ?? const Color(0xFF0F172A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Trust badges
// ---------------------------------------------------------------------------
class _TrustBadges extends StatelessWidget {
  const _TrustBadges();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user_outlined, size: 14),
          const SizedBox(width: 4),
          const Text(
            'SECURE PAYMENT',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 24),
          const Icon(Icons.local_shipping_outlined, size: 14),
          const SizedBox(width: 4),
          const Text(
            'EASY RETURNS',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty cart
// ---------------------------------------------------------------------------
class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: const Color(0xFFCF0269).withValues(alpha: 0.30),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
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
// Bottom bar: Checkout CTA + nav tabs
// ---------------------------------------------------------------------------
class _CartBottomBar extends StatelessWidget {
  const _CartBottomBar({required this.onCheckout});

  final VoidCallback onCheckout;

  static const Color _primary = Color(0xFFCF0269);

  static const _navItems = [
    (icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    (
      icon: Icons.shopping_bag_outlined,
      activeIcon: Icons.shopping_bag,
      label: 'Shop',
    ),
    (
      icon: Icons.shopping_cart_outlined,
      activeIcon: Icons.shopping_cart,
      label: 'Cart',
    ),
    (icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  static const int _activeIndex = 2;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0x1ACF0269))),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkout button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: onCheckout,
                  style: FilledButton.styleFrom(
                    backgroundColor: _primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadowColor: _primary.withValues(alpha: 0.20),
                    elevation: 4,
                  ),
                  icon: const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  label: const Icon(Icons.arrow_forward, size: 18),
                ),
              ),
            ),

            // Nav tabs
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_navItems.length, (i) {
                  final active = i == _activeIndex;
                  final item = _navItems[i];
                  return InkWell(
                    onTap: () {
                      // TODO: navigate to tab i
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            active ? item.activeIcon : item.icon,
                            color: active ? _primary : const Color(0xFF94A3B8),
                            size: 22,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.label.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: active
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: active
                                  ? _primary
                                  : const Color(0xFF94A3B8),
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
          ],
        ),
      ),
    );
  }
}
