import 'package:flutter/material.dart';

const _primary = Color(0xFFCF0269);
const _bgLight = Color(0xFFF8F5F7);

enum _DeliveryMethod { standard, express }

// ── Mock order items ──────────────────────────────────────────────────────────

class _CartItem {
  const _CartItem({required this.color, required this.qty});
  final Color color;
  final int qty;
}

const _mockCartItems = <_CartItem>[
  _CartItem(color: Color(0xFFD4A47A), qty: 1),
  _CartItem(color: Color(0xFF8B3A5A), qty: 1),
  _CartItem(color: Color(0xFFC8B5A0), qty: 1),
];

// ── Page ──────────────────────────────────────────────────────────────────────

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  _DeliveryMethod _selected = _DeliveryMethod.standard;

  double get _deliveryFee => _selected == _DeliveryMethod.express ? 100.0 : 0.0;
  double get _subtotal => 185.0;
  double get _total => _subtotal + _deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: const _CheckoutAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ReviewOrderSection(items: _mockCartItems),
                const SizedBox(height: 28),
                const _ShippingDestinationSection(),
                const SizedBox(height: 28),
                _DeliveryMethodSection(
                  selected: _selected,
                  onChanged: (m) => setState(() => _selected = m),
                ),
                const SizedBox(height: 28),
                _OrderSummarySection(
                  subtotal: _subtotal,
                  deliveryFee: _deliveryFee,
                  total: _total,
                ),
              ],
            ),
          ),
          const _ContinueButton(),
        ],
      ),
    );
  }
}

// ── App Bar ───────────────────────────────────────────────────────────────────

class _CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CheckoutAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _bgLight,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back_rounded, color: _primary),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Checkout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF151B2C),
              height: 1.1,
            ),
          ),
          Text(
            'STEP 1 OF 2',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF151B2C).withValues(alpha: 0.45),
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: _primary.withValues(alpha: 0.70),
            size: 24,
          ),
        ),
      ],
    );
  }
}

// ── Review Order ──────────────────────────────────────────────────────────────

class _ReviewOrderSection extends StatelessWidget {
  const _ReviewOrderSection({required this.items});

  final List<_CartItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'Review Your Order'),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) => _OrderItemThumbnail(item: items[i]),
          ),
        ),
      ],
    );
  }
}

class _OrderItemThumbnail extends StatelessWidget {
  const _OrderItemThumbnail({required this.item});

  final _CartItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 72,
          height: 96,
          decoration: BoxDecoration(
            color: item.color.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _primary.withValues(alpha: 0.08)),
          ),
          child: Icon(Icons.checkroom_rounded, color: item.color, size: 32),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${item.qty}',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Shipping Destination ───────────────────────────────────────────────────────

class _ShippingDestinationSection extends StatelessWidget {
  const _ShippingDestinationSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'Shipping Destination'),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _primary.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: _primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mukesh Sharma',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF151B2C),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Primary Residence',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: const Color(
                              0xFF151B2C,
                            ).withValues(alpha: 0.45),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: navigate to address selection
                    },
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'H-12, Heritage Apartments, 4th Floor\nConnaught Place, New Delhi, 110001\nIndia',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: const Color(0xFF151B2C).withValues(alpha: 0.60),
                ),
              ),
              const SizedBox(height: 14),
              Divider(color: _primary.withValues(alpha: 0.10), height: 1),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.phone_outlined,
                    size: 14,
                    color: _primary.withValues(alpha: 0.60),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+91 98765 43210',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF151B2C).withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Delivery Method ────────────────────────────────────────────────────────────

class _DeliveryMethodSection extends StatelessWidget {
  const _DeliveryMethodSection({
    required this.selected,
    required this.onChanged,
  });

  final _DeliveryMethod selected;
  final ValueChanged<_DeliveryMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'Delivery Method'),
        const SizedBox(height: 12),
        _DeliveryTile(
          icon: Icons.local_shipping_outlined,
          title: 'Standard Delivery',
          subtitle: '3-5 business days',
          priceLabel: 'Free',
          priceIsHighlighted: true,
          selected: selected == _DeliveryMethod.standard,
          onTap: () => onChanged(_DeliveryMethod.standard),
        ),
        const SizedBox(height: 10),
        _DeliveryTile(
          icon: Icons.bolt_rounded,
          title: 'Express Delivery',
          subtitle: 'Tomorrow by 10 AM',
          priceLabel: '₹100.00',
          priceIsHighlighted: false,
          selected: selected == _DeliveryMethod.express,
          onTap: () => onChanged(_DeliveryMethod.express),
        ),
      ],
    );
  }
}

class _DeliveryTile extends StatelessWidget {
  const _DeliveryTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.priceLabel,
    required this.priceIsHighlighted,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String priceLabel;
  final bool priceIsHighlighted;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: selected ? _primary.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? _primary : _primary.withValues(alpha: 0.10),
            width: selected ? 2 : 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E7FF),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: const Color(0xFF4A5568)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF151B2C),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF151B2C).withValues(alpha: 0.50),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              priceLabel,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: priceIsHighlighted ? _primary : const Color(0xFF151B2C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Order Summary ─────────────────────────────────────────────────────────────

class _OrderSummarySection extends StatelessWidget {
  const _OrderSummarySection({
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  final double subtotal;
  final double deliveryFee;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: 'Order Summary'),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _bgLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _primary.withValues(alpha: 0.10)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _SummaryRow(
                label: 'Subtotal',
                value: '₹${subtotal.toStringAsFixed(2)}',
                valueColor: const Color(0xFF151B2C),
              ),
              const SizedBox(height: 14),
              _SummaryRow(
                label: 'Delivery Fee',
                value: deliveryFee == 0
                    ? 'Free'
                    : '₹${deliveryFee.toStringAsFixed(2)}',
                valueColor: deliveryFee == 0
                    ? const Color(0xFF00677C)
                    : const Color(0xFF151B2C),
              ),
              const SizedBox(height: 14),
              Divider(color: _primary.withValues(alpha: 0.15), height: 1),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF151B2C),
                    ),
                  ),
                  Text(
                    '₹${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: const Color(0xFF151B2C).withValues(alpha: 0.55),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF151B2C).withValues(alpha: 0.45),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ── Continue Button ───────────────────────────────────────────────────────────

class _ContinueButton extends StatelessWidget {
  const _ContinueButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: _bgLight.withValues(alpha: 0.95),
          border: Border(
            top: BorderSide(color: _primary.withValues(alpha: 0.10)),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: navigate to payment step via router
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            shadowColor: _primary.withValues(alpha: 0.30),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Continue to Payment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
