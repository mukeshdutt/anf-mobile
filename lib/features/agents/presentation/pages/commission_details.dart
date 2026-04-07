import 'package:flutter/material.dart';

class CommissionDetailsPage extends StatelessWidget {
  const CommissionDetailsPage({super.key});

  static const _primary = Color(0xFFCF0269);
  static const _bgLight = Color(0xFFF8F5F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: _CommissionDetailsAppBar(primary: _primary, bgLight: _bgLight),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OrderSummaryCard(primary: _primary),
                  const SizedBox(height: 8),
                  _SectionLabel(label: 'Order Information'),
                  _OrderInfoCard(primary: _primary),
                  const SizedBox(height: 16),
                  _SectionLabel(label: 'Commission Breakdown'),
                  _CommissionCard(primary: _primary),
                  const SizedBox(height: 16),
                  _SectionLabel(label: 'Earning Timeline'),
                  const SizedBox(height: 8),
                  _EarningTimeline(primary: _primary),
                ],
              ),
            ),
          ),
          _BottomNavBar(primary: _primary),
        ],
      ),
    );
  }
}

// ── AppBar ────────────────────────────────────────────────────────────────────

class _CommissionDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _CommissionDetailsAppBar({
    required this.primary,
    required this.bgLight,
  });

  final Color primary;
  final Color bgLight;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgLight.withValues(alpha: 0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.maybePop(context),
        borderRadius: BorderRadius.circular(20),
        child: Icon(Icons.arrow_back, color: primary),
      ),
      title: const Text(
        'Commission Details',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: primary.withValues(alpha: 0.1),
        ),
      ),
    );
  }
}

// ── Order summary card ────────────────────────────────────────────────────────

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(14),
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/commission_detail_product.jpg',
                width: 76,
                height: 76,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '10 MARCH 2026',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Chikankari Suit',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Order ID: #54821',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 16, 10),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
          color: Colors.black87,
        ),
      ),
    );
  }
}

// ── Order information card ────────────────────────────────────────────────────

class _OrderInfoCard extends StatelessWidget {
  const _OrderInfoCard({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: primary.withValues(alpha: 0.06)),
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
            _InfoRow(label: 'Order Value', value: '₹1,299'),
            _Divider(primary: primary),
            _InfoRow(label: 'Customer Name', value: 'Sneha Sharma'),
            _Divider(primary: primary),
            _InfoRowWithBadge(
              label: 'Order Status',
              badgeLabel: 'Delivered',
              badgeBg: const Color(0xFFDCFCE7),
              badgeFg: const Color(0xFF15803D),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRowWithBadge extends StatelessWidget {
  const _InfoRowWithBadge({
    required this.label,
    required this.badgeLabel,
    required this.badgeBg,
    required this.badgeFg,
  });

  final String label;
  final String badgeLabel;
  final Color badgeBg;
  final Color badgeFg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeLabel.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: badgeFg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: primary.withValues(alpha: 0.06),
    );
  }
}

// ── Commission breakdown card ─────────────────────────────────────────────────

class _CommissionCard extends StatelessWidget {
  const _CommissionCard({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: primary.withValues(alpha: 0.18)),
        ),
        child: Column(
          children: [
            _CommissionRow(
              label: 'Commission Rate',
              child: Text(
                '10%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: primary.withValues(alpha: 0.1),
            ),
            _CommissionRow(
              label: 'Commission Earned',
              child: Text(
                '₹129',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: primary,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: primary.withValues(alpha: 0.1),
            ),
            _CommissionRow(
              label: 'Settlement Status',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_rounded, color: primary, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    'Settled',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: primary,
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

class _CommissionRow extends StatelessWidget {
  const _CommissionRow({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

// ── Earning Timeline ──────────────────────────────────────────────────────────

class _EarningTimeline extends StatelessWidget {
  const _EarningTimeline({required this.primary});
  final Color primary;

  static const _steps = [
    ('Order Placed', '08 March 2026'),
    ('Order Delivered', '10 March 2026'),
    ('Commission Credited', '12 March 2026'),
    ('Settlement Completed', '15 March 2026'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          // vertical connector line
          Positioned(
            left: 11,
            top: 12,
            bottom: 12,
            width: 2,
            child: Container(color: primary.withValues(alpha: 0.2)),
          ),
          Column(
            children: [
              for (int i = 0; i < _steps.length; i++) ...[
                if (i > 0) const SizedBox(height: 28),
                _TimelineStep(
                  label: _steps[i].$1,
                  date: _steps[i].$2,
                  primary: primary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.label,
    required this.date,
    required this.primary,
  });

  final String label;
  final String date;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              date,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Bottom Nav Bar ────────────────────────────────────────────────────────────

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        border: Border(top: BorderSide(color: primary.withValues(alpha: 0.1))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                filledIcon: Icons.home_rounded,
                label: 'HOME',
                active: false,
                primary: primary,
                showDot: false,
              ),
              _NavItem(
                icon: Icons.shopping_bag_outlined,
                filledIcon: Icons.shopping_bag_rounded,
                label: 'ORDERS',
                active: false,
                primary: primary,
                showDot: false,
              ),
              _NavItem(
                icon: Icons.account_balance_wallet_outlined,
                filledIcon: Icons.account_balance_wallet_rounded,
                label: 'EARNINGS',
                active: true,
                primary: primary,
                showDot: true,
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                filledIcon: Icons.person_rounded,
                label: 'PROFILE',
                active: false,
                primary: primary,
                showDot: false,
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
    required this.showDot,
  });

  final IconData icon;
  final IconData filledIcon;
  final String label;
  final bool active;
  final Color primary;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {}, // TODO: nav
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  active ? filledIcon : icon,
                  color: active ? primary : Colors.grey.shade400,
                  size: 24,
                ),
                if (showDot)
                  Positioned(
                    top: -2,
                    right: -4,
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
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: active ? primary : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
