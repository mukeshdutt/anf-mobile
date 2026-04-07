import 'package:flutter/material.dart';

class AgentDashboardPage extends StatelessWidget {
  const AgentDashboardPage({super.key});

  static const _primary = Color(0xFFCF0269);
  static const _bgLight = Color(0xFFF8F5F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: Column(
        children: [
          _AgentAppBar(primary: _primary, bgLight: _bgLight),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _WelcomeSection(primary: _primary),
                  _StatsGrid(primary: _primary),
                  const SizedBox(height: 32),
                  _PerformanceSection(primary: _primary),
                  const SizedBox(height: 32),
                  _QuickActionsSection(primary: _primary),
                  const SizedBox(height: 32),
                  _RecentOrdersSection(primary: _primary),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _BottomNavBar(primary: _primary, bgLight: _bgLight),
        ],
      ),
    );
  }
}

// ── AppBar ────────────────────────────────────────────────────────────────────

class _AgentAppBar extends StatelessWidget {
  const _AgentAppBar({required this.primary, required this.bgLight});
  final Color primary;
  final Color bgLight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bgLight.withValues(alpha: 0.9),
          border: Border(
            bottom: BorderSide(color: primary.withValues(alpha: 0.1)),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anekriti',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: primary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    'Agent Dashboard',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: primary.withValues(alpha: 0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: primary,
                      size: 20,
                    ),
                    onPressed: () {}, // TODO: nav
                    padding: EdgeInsets.zero,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primary.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/agent_avatar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Welcome Section ───────────────────────────────────────────────────────────

class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Namaste,',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Welcome back, Mukesh',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'AGENT ID: ANK9921',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stats Grid ────────────────────────────────────────────────────────────────

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3,
        children: [
          _StatCard(
            icon: Icons.payments_outlined,
            iconColor: primary,
            bgColor: primary.withValues(alpha: 0.07),
            borderColor: primary.withValues(alpha: 0.12),
            label: 'Total Commission',
            value: '₹12,450',
          ),
          const _StatCard(
            icon: Icons.account_balance_wallet_outlined,
            iconColor: Color(0xFF059669),
            bgColor: Color(0xFFECFDF5),
            borderColor: Color(0xFFD1FAE5),
            label: 'Available Balance',
            value: '₹3,200',
          ),
          const _StatCard(
            icon: Icons.pending_actions_outlined,
            iconColor: Color(0xFFD97706),
            bgColor: Color(0xFFFFFBEB),
            borderColor: Color(0xFFFDE68A),
            label: 'Pending Commission',
            value: '₹2,800',
          ),
          const _StatCard(
            icon: Icons.shopping_cart_outlined,
            iconColor: Color(0xFF4F46E5),
            bgColor: Color(0xFFEEF2FF),
            borderColor: Color(0xFFE0E7FF),
            label: 'Orders Generated',
            value: '86',
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.borderColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Color borderColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
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
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const Spacer(),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Performance Overview ──────────────────────────────────────────────────────

class _PerformanceSection extends StatelessWidget {
  const _PerformanceSection({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Performance Overview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Text(
                'LAST 30 DAYS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: primary.withValues(alpha: 0.06)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _ProgressRow(
                  label: 'This Month Earnings',
                  value: '₹4,850',
                  fraction: 0.75,
                  valueColor: primary,
                  barColor: primary,
                ),
                const SizedBox(height: 16),
                _ProgressRow(
                  label: 'Last Month Earnings',
                  value: '₹3,200',
                  fraction: 0.55,
                  valueColor: Colors.grey.shade600,
                  barColor: primary.withValues(alpha: 0.4),
                ),
                const SizedBox(height: 16),
                _ProgressRow(
                  label: 'Total Sales Target',
                  value: '₹82,400 / ₹1L',
                  fraction: 0.82,
                  valueColor: Colors.grey.shade600,
                  barColor: primary.withValues(alpha: 0.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  const _ProgressRow({
    required this.label,
    required this.value,
    required this.fraction,
    required this.valueColor,
    required this.barColor,
  });

  final String label;
  final String value;
  final double fraction;
  final Color valueColor;
  final Color barColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: valueColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 7,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
          ),
        ),
      ],
    );
  }
}

// ── Quick Actions ─────────────────────────────────────────────────────────────

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _QuickActionButton(
                icon: Icons.share_rounded,
                label: 'Share Agent\nCode',
                filled: true,
                primary: primary,
                onTap: () {}, // TODO: share agent code
              ),
              const SizedBox(width: 16),
              _QuickActionButton(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Commission\nWallet',
                filled: false,
                primary: primary,
                onTap: () {}, // TODO: nav to commission wallet
              ),
              const SizedBox(width: 16),
              _QuickActionButton(
                icon: Icons.redeem_outlined,
                label: 'Redeem\nRewards',
                filled: false,
                primary: primary,
                onTap: () {}, // TODO: nav to redeem rewards
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.filled,
    required this.primary,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool filled;
  final Color primary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: filled ? primary : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: filled
                  ? null
                  : Border.all(color: primary.withValues(alpha: 0.12)),
              boxShadow: [
                BoxShadow(
                  color: filled
                      ? primary.withValues(alpha: 0.25)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: filled ? 12 : 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: filled ? Colors.white : primary, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Recent Orders ─────────────────────────────────────────────────────────────

class _RecentOrdersSection extends StatelessWidget {
  const _RecentOrdersSection({required this.primary});
  final Color primary;

  static const _orders = [
    _OrderData(
      orderId: '#ORD-99821',
      title: 'Banarasi Silk Saree - Pink',
      value: '₹4,500',
      commission: '+₹450',
      status: 'Delivered',
      statusColor: Color(0xFF10B981),
      imagePath: 'assets/images/agent_order_saree.jpg',
    ),
    _OrderData(
      orderId: '#ORD-99745',
      title: 'Floral Embroidered Kurti Set',
      value: '₹2,800',
      commission: '+₹280',
      status: 'Shipped',
      statusColor: Color(0xFFF59E0B),
      imagePath: 'assets/images/agent_order_kurti.jpg',
    ),
    _OrderData(
      orderId: '#ORD-99612',
      title: 'Temple Gold Jhumka Set',
      value: '₹1,200',
      commission: '+₹120',
      status: 'Processing',
      statusColor: Color(0xFF94A3B8),
      imagePath: 'assets/images/agent_order_jhumka.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Orders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {}, // TODO: nav to orders
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(48, 32),
                ),
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _orders.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) =>
                _OrderCard(order: _orders[index], primary: primary),
          ),
        ),
      ],
    );
  }
}

class _OrderData {
  const _OrderData({
    required this.orderId,
    required this.title,
    required this.value,
    required this.commission,
    required this.status,
    required this.statusColor,
    required this.imagePath,
  });

  final String orderId;
  final String title;
  final String value;
  final String commission;
  final String status;
  final Color statusColor;
  final String imagePath;
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order, required this.primary});
  final _OrderData order;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primary.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.asset(order.imagePath, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: order.statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.orderId,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Text(
                      order.commission,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  order.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    children: [
                      const TextSpan(text: 'Value: '),
                      TextSpan(
                        text: order.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
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

// ── Bottom Nav Bar ────────────────────────────────────────────────────────────

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.primary, required this.bgLight});
  final Color primary;
  final Color bgLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        border: Border(top: BorderSide(color: primary.withValues(alpha: 0.1))),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                icon: Icons.dashboard_outlined,
                filledIcon: Icons.dashboard_rounded,
                label: 'HOME',
                active: true,
                primary: primary,
              ),
              _NavItem(
                icon: Icons.inventory_2_outlined,
                filledIcon: Icons.inventory_2_rounded,
                label: 'ORDERS',
                active: false,
                primary: primary,
              ),
              _NavItem(
                icon: Icons.group_outlined,
                filledIcon: Icons.group_rounded,
                label: 'NETWORK',
                active: false,
                primary: primary,
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                filledIcon: Icons.person_rounded,
                label: 'PROFILE',
                active: false,
                primary: primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.filledIcon,
    required this.label,
    required this.active,
    required this.primary,
  });

  final IconData icon;
  final IconData filledIcon;
  final String label;
  final bool active;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // TODO: nav
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active ? filledIcon : icon,
            color: active ? primary : Colors.grey.shade400,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
              color: active ? primary : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
