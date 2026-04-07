import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Brand tokens (screen-local — luxury palette)
// ---------------------------------------------------------------------------
const _primary = Color(0xFFA10050);
const _primaryDeep = Color(0xFFCD0268);
const _bgSurface = Color(0xFFFAF8FF);
const _bgContainerLow = Color(0xFFF2F3FF);
const _outlineVariant = Color(0xFFE2BDC5);
const _onSurfaceVariant = Color(0xFF5A4046);
const _secondaryTeal = Color(0xFF00677C);
const _errorRed = Color(0xFFBA1A1A);
const _onSurface = Color(0xFF151B2C);

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

enum _StepState { completed, active, pending }

class _TrackStep {
  const _TrackStep({
    required this.label,
    required this.time,
    required this.state,
    required this.icon,
  });
  final String label;
  final String time;
  final _StepState state;
  final IconData icon;
}

class _OrderLineItem {
  const _OrderLineItem({
    required this.name,
    required this.variant,
    required this.price,
    required this.qty,
    required this.imageAsset,
  });
  final String name;
  final String variant;
  final String price;
  final int qty;
  final String imageAsset;
}

const _trackingSteps = <_TrackStep>[
  _TrackStep(
    label: 'Ordered',
    time: 'Oct 24, 10:30 AM',
    state: _StepState.completed,
    icon: Icons.check,
  ),
  _TrackStep(
    label: 'Packed',
    time: 'Oct 24, 04:15 PM',
    state: _StepState.completed,
    icon: Icons.check,
  ),
  _TrackStep(
    label: 'Shipped',
    time: 'Oct 25, 09:00 AM',
    state: _StepState.active,
    icon: Icons.local_shipping_outlined,
  ),
  _TrackStep(
    label: 'Out for Delivery',
    time: 'Pending',
    state: _StepState.pending,
    icon: Icons.map_outlined,
  ),
];

const _lineItems = <_OrderLineItem>[
  _OrderLineItem(
    name: 'Banarasi Silk Saree',
    variant: 'Midnight Blue / Standard Size',
    price: '₹14,999',
    qty: 1,
    imageAsset: 'assets/images/order_detail_saree.jpg',
  ),
  _OrderLineItem(
    name: 'Antique Gold Jhumkas',
    variant: 'Temple Design / One Size',
    price: '₹3,450',
    qty: 1,
    imageAsset: 'assets/images/order_detail_jhumkas.jpg',
  ),
];

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgSurface,
      body: Column(
        children: [
          const _DetailAppBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              children: const [
                _OrderIdentity(),
                SizedBox(height: 28),
                _TrackingTimeline(),
                SizedBox(height: 28),
                _ShipmentItems(),
                SizedBox(height: 28),
                _ShippingDestination(),
                SizedBox(height: 28),
                _FinancialSummary(),
                SizedBox(height: 28),
                _ActionButtons(),
              ],
            ),
          ),
          const _BottomNavBar(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App bar — title in primary, share icon
// ---------------------------------------------------------------------------

class _DetailAppBar extends StatelessWidget {
  const _DetailAppBar();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Material(
      color: _bgSurface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: top),
          SizedBox(
            height: 56,
            child: Row(
              children: [
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    /* TODO: pop */
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back,
                      color: _primary,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: _primary,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    /* TODO: share */
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.share_outlined,
                      color: _onSurface,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Order identity — ref + date
// ---------------------------------------------------------------------------

class _OrderIdentity extends StatelessWidget {
  const _OrderIdentity();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'TRANSACTION REFERENCE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: _onSurfaceVariant,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '#AK98721',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: _onSurface,
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Oct 24, 2023',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: _primary,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Tracking timeline
// ---------------------------------------------------------------------------

class _TrackingTimeline extends StatelessWidget {
  const _TrackingTimeline();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _bgContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ORDER STATUS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: _onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          ..._buildSteps(),
        ],
      ),
    );
  }

  List<Widget> _buildSteps() {
    final widgets = <Widget>[];
    for (int i = 0; i < _trackingSteps.length; i++) {
      final step = _trackingSteps[i];
      final isLast = i == _trackingSteps.length - 1;
      widgets.add(_TimelineStep(step: step, isLast: isLast));
    }
    return widgets;
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({required this.step, required this.isLast});

  final _TrackStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isPending = step.state == _StepState.pending;
    final isActive = step.state == _StepState.active;

    return Opacity(
      opacity: isPending ? 0.40 : 1.0,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column: dot + connector line
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  // Dot
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isPending ? _outlineVariant : _primary,
                      boxShadow: isPending
                          ? null
                          : [
                              BoxShadow(
                                color: _primary.withValues(alpha: 0.20),
                                blurRadius: 8,
                                spreadRadius: 3,
                              ),
                            ],
                    ),
                    child: Icon(step.icon, size: 13, color: Colors.white),
                  ),
                  // Connector line (except after last)
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: _outlineVariant.withValues(alpha: 0.40),
                      ),
                    ),
                  if (!isLast) const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 20),
            // Right column: label + time
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      step.label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isActive ? _primary : _onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      step.time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _onSurfaceVariant,
                      ),
                    ),
                  ],
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
// Shipment items list
// ---------------------------------------------------------------------------

class _ShipmentItems extends StatelessWidget {
  const _ShipmentItems();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipment Items (${_lineItems.length})',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: _onSurface,
          ),
        ),
        const SizedBox(height: 14),
        ..._lineItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ProductCard(item: item),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.item});

  final _OrderLineItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.imageAsset,
              width: 88,
              height: 116,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _onSurface,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.variant,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      item.price,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: _primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'QTY: ${item.qty.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: _onSurfaceVariant,
                      ),
                    ),
                  ],
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
// Shipping destination
// ---------------------------------------------------------------------------

class _ShippingDestination extends StatelessWidget {
  const _ShippingDestination();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _bgContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.route_outlined, color: _primary, size: 20),
              SizedBox(width: 10),
              Text(
                'Shipping Destination',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Riya Deshmukh',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _onSurface,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Apt 402, Sterling Heights, 24th Main Road,\n'
            'Jayanagar 4th Block, Bangalore, Karnataka\n'
            '560041',
            style: TextStyle(
              fontSize: 13,
              color: _onSurfaceVariant,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.call_outlined, color: _primary, size: 16),
              SizedBox(width: 6),
              Text(
                '+91 98765 43210',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Financial summary
// ---------------------------------------------------------------------------

class _FinancialSummary extends StatelessWidget {
  const _FinancialSummary();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Financial Summary',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: _onSurface,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _outlineVariant.withValues(alpha: 0.25)),
          ),
          child: Column(
            children: [
              _SummaryRow(label: 'Subtotal (2 Items)', value: '₹18,449.00'),
              const SizedBox(height: 12),
              _SummaryRow(
                label: 'Shipping Fee',
                value: 'FREE',
                valueColor: _secondaryTeal,
              ),
              const SizedBox(height: 12),
              _SummaryRow(
                label: 'Loyalty Discount',
                value: '-₹450.00',
                valueColor: _errorRed,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  height: 1,
                  color: _outlineVariant.withValues(alpha: 0.25),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _onSurface,
                    ),
                  ),
                  Text(
                    '₹17,999.00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Payment method chip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _bgContainerLow.withValues(alpha: 0.50),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color: _secondaryTeal,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'PAID VIA UPI  •  SBI BANK',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                        color: _onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
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
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: _onSurfaceVariant),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? _onSurface,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Action buttons — Invoice + Support
// ---------------------------------------------------------------------------

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF83D2E9),
                foregroundColor: const Color(0xFF001F27),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.download_outlined, size: 18),
              label: const Text(
                'Invoice',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                /* TODO: download invoice */
              },
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: _primary,
                side: BorderSide(
                  color: _outlineVariant.withValues(alpha: 0.50),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.help_outline, size: 18),
              label: const Text(
                'Support',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              onPressed: () {
                /* TODO: open support */
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom nav — Home / Shop / Orders (gradient pill, active) / Profile
// ---------------------------------------------------------------------------

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Container(
      decoration: BoxDecoration(
        color: _bgSurface.withValues(alpha: 0.85),
        border: Border(
          top: BorderSide(color: _outlineVariant.withValues(alpha: 0.20)),
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: _onSurface.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottom + 8),
      child: Row(
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: false,
            onTap: () {
              /* TODO */
            },
          ),
          _NavItem(
            icon: Icons.shopping_bag_outlined,
            label: 'Shop',
            isActive: false,
            onTap: () {
              /* TODO */
            },
          ),
          _GradientNavItem(
            icon: Icons.receipt_long,
            label: 'Orders',
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
            onTap: () {
              /* TODO */
            },
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
    required this.isActive,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? _primary : _onSurfaceVariant;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientNavItem extends StatelessWidget {
  const _GradientNavItem({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_primary, _primaryDeep],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 4),
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
