import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Brand tokens (screen-local)
// ---------------------------------------------------------------------------
const _primary = Color(0xFFCF0269);
const _bgLight = Color(0xFFF8F5F7);
const _emerald = Color(0xFF059669);
const _slate500 = Color(0xFF64748B);

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

enum _OrderStatus { delivered, inTransit, cancelled }

class _OrderItem {
  const _OrderItem({
    required this.orderNumber,
    required this.status,
    required this.dateLabel,
    required this.dateLine,
    required this.price,
    required this.imageAsset,
  });

  final String orderNumber;
  final _OrderStatus status;
  final String dateLabel; // e.g. "Ordered on", "Expected by", "Cancelled on"
  final String dateLine;
  final String price;
  final String imageAsset;
}

const _orders = <_OrderItem>[
  _OrderItem(
    orderNumber: 'Order #AK98721',
    status: _OrderStatus.delivered,
    dateLabel: 'Ordered on',
    dateLine: 'Oct 12, 2023',
    price: '₹4,250.00',
    imageAsset: 'assets/images/order_saree_1.jpg',
  ),
  _OrderItem(
    orderNumber: 'Order #AK98554',
    status: _OrderStatus.inTransit,
    dateLabel: 'Expected by',
    dateLine: 'Oct 20, 2023',
    price: '₹1,890.00',
    imageAsset: 'assets/images/order_jewellery_1.jpg',
  ),
  _OrderItem(
    orderNumber: 'Order #AK98102',
    status: _OrderStatus.cancelled,
    dateLabel: 'Cancelled on',
    dateLine: 'Oct 05, 2023',
    price: '₹3,100.00',
    imageAsset: 'assets/images/order_kurta_1.jpg',
  ),
];

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: Column(
        children: [
          _OrdersAppBar(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _OrdersList(orders: _orders),
                _OrdersList(
                  orders: _orders
                      .where((o) => o.status == _OrderStatus.inTransit)
                      .toList(),
                ),
                _OrdersList(
                  orders: _orders
                      .where((o) => o.status == _OrderStatus.delivered)
                      .toList(),
                ),
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
// App bar + tab bar
// ---------------------------------------------------------------------------

class _OrdersAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _OrdersAppBar({required this.tabController});

  final TabController tabController;

  @override
  Size get preferredSize => const Size.fromHeight(112);

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Material(
      color: _bgLight.withValues(alpha: 0.92),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: top),
          // Row: back, title, search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                _IconBtn(
                  icon: Icons.arrow_back,
                  onTap: () {
                    // TODO: pop navigation
                  },
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'My Orders',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                _IconBtn(
                  icon: Icons.search,
                  onTap: () {
                    // TODO: open search
                  },
                ),
              ],
            ),
          ),
          // Tab bar
          TabBar(
            controller: tabController,
            labelColor: _primary,
            unselectedLabelColor: _slate500,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
            indicatorColor: _primary,
            indicatorWeight: 2,
            tabs: const [
              Tab(text: 'All Orders'),
              Tab(text: 'Ongoing'),
              Tab(text: 'Completed'),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Icon(icon, size: 24),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Orders list
// ---------------------------------------------------------------------------

class _OrdersList extends StatelessWidget {
  const _OrdersList({required this.orders});

  final List<_OrderItem> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'No orders here',
          style: TextStyle(color: _slate500, fontSize: 14),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _OrderCard(order: orders[i]),
    );
  }
}

// ---------------------------------------------------------------------------
// Order card
// ---------------------------------------------------------------------------

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final _OrderItem order;

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
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail + info row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: _primary.withValues(alpha: 0.1)),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(order.imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Info column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StatusBadge(status: order.status),
                    const SizedBox(height: 4),
                    Text(
                      order.orderNumber,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${order.dateLabel} ${order.dateLine}',
                      style: const TextStyle(fontSize: 11, color: _slate500),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      order.price,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Action buttons
          _OrderActions(status: order.status),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Status badge
// ---------------------------------------------------------------------------

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final _OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(_icon, size: 14, color: _color),
        const SizedBox(width: 4),
        Text(
          _label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
            color: _color,
          ),
        ),
      ],
    );
  }

  String get _label {
    switch (status) {
      case _OrderStatus.delivered:
        return 'DELIVERED';
      case _OrderStatus.inTransit:
        return 'IN TRANSIT';
      case _OrderStatus.cancelled:
        return 'CANCELLED';
    }
  }

  IconData get _icon {
    switch (status) {
      case _OrderStatus.delivered:
        return Icons.check_circle_outline;
      case _OrderStatus.inTransit:
        return Icons.local_shipping_outlined;
      case _OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  Color get _color {
    switch (status) {
      case _OrderStatus.delivered:
        return _emerald;
      case _OrderStatus.inTransit:
        return _primary;
      case _OrderStatus.cancelled:
        return _slate500;
    }
  }
}

// ---------------------------------------------------------------------------
// Action buttons per status
// ---------------------------------------------------------------------------

class _OrderActions extends StatelessWidget {
  const _OrderActions({required this.status});

  final _OrderStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _OrderStatus.delivered:
        return Row(
          children: [
            Expanded(
              child: _OutlineBtn(
                label: 'View Details',
                onTap: () {
                  /* TODO: navigate to order detail */
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FilledBtn(
                label: 'Reorder',
                onTap: () {
                  /* TODO: reorder */
                },
              ),
            ),
          ],
        );
      case _OrderStatus.inTransit:
        return Row(
          children: [
            Expanded(
              child: _OutlineBtn(
                label: 'View Details',
                onTap: () {
                  /* TODO: navigate to order detail */
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FilledBtn(
                label: 'Track',
                icon: Icons.location_on_rounded,
                onTap: () {
                  /* TODO: track order */
                },
              ),
            ),
          ],
        );
      case _OrderStatus.cancelled:
        return SizedBox(
          width: double.infinity,
          height: 40,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: _primary.withValues(alpha: 0.05),
              foregroundColor: const Color(0xFF475569),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              /* TODO: view refund */
            },
            child: const Text(
              'View Refund Status',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
        );
    }
  }
}

class _OutlineBtn extends StatelessWidget {
  const _OutlineBtn({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: _primary.withValues(alpha: 0.10),
          foregroundColor: _primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _FilledBtn extends StatelessWidget {
  const _FilledBtn({required this.label, this.icon, this.onTap});

  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom nav bar — 4 tabs: Home / Shop / Orders (active) / Profile
// ---------------------------------------------------------------------------

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Container(
      decoration: const BoxDecoration(
        color: _bgLight,
        border: Border(top: BorderSide(color: Color(0x1ACF0269))),
      ),
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: bottom + 8),
      child: Row(
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            isActive: false,
            onTap: () {
              /* TODO: navigate home */
            },
          ),
          _NavItem(
            icon: Icons.shopping_bag_outlined,
            label: 'Shop',
            isActive: false,
            onTap: () {
              /* TODO: navigate shop */
            },
          ),
          _NavItem(
            icon: Icons.receipt_long,
            label: 'Orders',
            isActive: true,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
            onTap: () {
              /* TODO: navigate profile */
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
    final color = isActive ? _primary : _slate500;
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
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
