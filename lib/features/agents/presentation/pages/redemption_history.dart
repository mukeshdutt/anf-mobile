import 'package:flutter/material.dart';

const _primary = Color(0xFFCF0269);
const _bgLight = Color(0xFFF8F5F7);

// ── Data models ──────────────────────────────────────────────────────────────

enum _RedemptionStatus { paid, processing, rejected }

class _RedemptionItem {
  const _RedemptionItem({
    required this.id,
    required this.status,
    required this.date,
    required this.method,
    required this.amount,
    this.subLabel,
    this.archived = false,
  });

  final String id;
  final _RedemptionStatus status;
  final String date;
  final String method;
  final String amount;
  final String? subLabel;
  final bool archived;
}

const _marchItems = <_RedemptionItem>[
  _RedemptionItem(
    id: 'RD12452',
    status: _RedemptionStatus.paid,
    date: '12 March 2026',
    method: 'Bank Transfer',
    amount: '₹2,000',
    subLabel: 'Completed',
  ),
  _RedemptionItem(
    id: 'RD12458',
    status: _RedemptionStatus.processing,
    date: '14 March 2026',
    method: 'UPI',
    amount: '₹5,500',
    subLabel: 'In Progress',
  ),
  _RedemptionItem(
    id: 'RD12441',
    status: _RedemptionStatus.rejected,
    date: '08 March 2026',
    method: 'UPI',
    amount: '₹1,200',
    subLabel: 'Details Needed',
  ),
  _RedemptionItem(
    id: 'RD12430',
    status: _RedemptionStatus.paid,
    date: '05 March 2026',
    method: 'Bank Transfer',
    amount: '₹12,000',
    subLabel: 'Completed',
  ),
  _RedemptionItem(
    id: 'RD12422',
    status: _RedemptionStatus.paid,
    date: '01 March 2026',
    method: 'UPI',
    amount: '₹3,500',
    subLabel: 'Completed',
  ),
];

const _februaryItems = <_RedemptionItem>[
  _RedemptionItem(
    id: 'RD12401',
    status: _RedemptionStatus.paid,
    date: '25 Feb 2026',
    method: 'Bank Transfer',
    amount: '₹8,000',
    archived: true,
  ),
];

// ── Page ─────────────────────────────────────────────────────────────────────

class RedemptionHistoryPage extends StatefulWidget {
  const RedemptionHistoryPage({super.key});

  @override
  State<RedemptionHistoryPage> createState() => _RedemptionHistoryPageState();
}

class _RedemptionHistoryPageState extends State<RedemptionHistoryPage> {
  int _activeFilter = 0; // 0=All, 1=Pending, 2=Paid, 3=Rejected

  List<_RedemptionItem> _filtered(List<_RedemptionItem> items) {
    return switch (_activeFilter) {
      1 =>
        items.where((e) => e.status == _RedemptionStatus.processing).toList(),
      2 => items.where((e) => e.status == _RedemptionStatus.paid).toList(),
      3 => items.where((e) => e.status == _RedemptionStatus.rejected).toList(),
      _ => items,
    };
  }

  @override
  Widget build(BuildContext context) {
    final marchFiltered = _filtered(_marchItems);
    final febFiltered = _filtered(_februaryItems);

    return Scaffold(
      backgroundColor: _bgLight,
      appBar: const _HistoryAppBar(),
      body: Column(
        children: [
          const _SummaryCard(),
          const SizedBox(height: 16),
          _FilterBar(
            activeIndex: _activeFilter,
            onTap: (i) => setState(() => _activeFilter = i),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
              children: [
                if (marchFiltered.isNotEmpty) ...[
                  for (final item in marchFiltered) _RedemptionCard(item: item),
                ],
                if (febFiltered.isNotEmpty) ...[
                  const _SectionHeader(label: 'February 2026'),
                  for (final item in febFiltered) _RedemptionCard(item: item),
                ],
                if (marchFiltered.isEmpty && febFiltered.isEmpty)
                  const _EmptyState(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

// ── App Bar ───────────────────────────────────────────────────────────────────

class _HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HistoryAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _bgLight.withValues(alpha: 0.90),
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1A1A2E)),
        ),
      ),
      title: const Text(
        'Redemption History',
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A1A2E),
        ),
      ),
    );
  }
}

// ── Summary Card ─────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: _primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _primary.withValues(alpha: 0.25),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            // decorative blob bottom-right
            Positioned(
              right: -16,
              bottom: -16,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Redeemed',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.80),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '₹48,500',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _SummarySubStat(label: 'PENDING', value: '₹5,200'),
                    Container(
                      width: 1,
                      height: 28,
                      color: Colors.white.withValues(alpha: 0.25),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    _SummarySubStat(label: 'AVAILABLE', value: '₹12,400'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummarySubStat extends StatelessWidget {
  const _SummarySubStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.60),
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// ── Filter Bar ────────────────────────────────────────────────────────────────

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.activeIndex, required this.onTap});

  final int activeIndex;
  final ValueChanged<int> onTap;

  static const _labels = ['All', 'Pending', 'Paid', 'Rejected'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final active = i == activeIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: active ? _primary : _primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                _labels[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: active ? Colors.white : _primary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: _primary,
          letterSpacing: 1.4,
        ),
      ),
    );
  }
}

// ── Redemption Card ───────────────────────────────────────────────────────────

class _RedemptionCard extends StatelessWidget {
  const _RedemptionCard({required this.item});

  final _RedemptionItem item;

  @override
  Widget build(BuildContext context) {
    final cfg = _statusConfig(item.status, item.archived);

    return Opacity(
      opacity: item.archived ? 0.70 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _primary.withValues(alpha: 0.06)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // TODO: navigate to redemption detail
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // icon tile
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: cfg.iconBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(cfg.icon, size: 22, color: cfg.iconColor),
                  ),
                  const SizedBox(width: 14),
                  // id + date row
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item.id,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(width: 8),
                            _StatusBadge(
                              label: cfg.badgeLabel,
                              textColor: cfg.badgeText,
                              bgColor: cfg.badgeBg,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item.date} • ${item.method}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // amount + sub-label
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.amount,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      if (item.subLabel != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.subLabel!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: cfg.subLabelColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Status config ─────────────────────────────────────────────────────────────

class _StatusCfg {
  const _StatusCfg({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.badgeLabel,
    required this.badgeText,
    required this.badgeBg,
    required this.subLabelColor,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String badgeLabel;
  final Color badgeText;
  final Color badgeBg;
  final Color subLabelColor;
}

_StatusCfg _statusConfig(_RedemptionStatus status, bool archived) {
  if (archived) {
    return _StatusCfg(
      icon: Icons.check_circle_outline_rounded,
      iconColor: const Color(0xFF9CA3AF),
      iconBg: const Color(0xFFF1F5F9),
      badgeLabel: 'PAID',
      badgeText: const Color(0xFF6B7280),
      badgeBg: const Color(0xFFF1F5F9),
      subLabelColor: const Color(0xFF9CA3AF),
    );
  }
  return switch (status) {
    _RedemptionStatus.paid => _StatusCfg(
      icon: Icons.check_circle_outline_rounded,
      iconColor: const Color(0xFF16A34A),
      iconBg: const Color(0xFFDCFCE7),
      badgeLabel: 'PAID',
      badgeText: const Color(0xFF15803D),
      badgeBg: const Color(0xFFDCFCE7),
      subLabelColor: const Color(0xFF9CA3AF),
    ),
    _RedemptionStatus.processing => _StatusCfg(
      icon: Icons.schedule_rounded,
      iconColor: const Color(0xFFD97706),
      iconBg: const Color(0xFFFEF3C7),
      badgeLabel: 'PROCESSING',
      badgeText: const Color(0xFFB45309),
      badgeBg: const Color(0xFFFEF3C7),
      subLabelColor: const Color(0xFF9CA3AF),
    ),
    _RedemptionStatus.rejected => _StatusCfg(
      icon: Icons.error_outline_rounded,
      iconColor: const Color(0xFFE11D48),
      iconBg: const Color(0xFFFFE4E6),
      badgeLabel: 'REJECTED',
      badgeText: const Color(0xFFBE123C),
      badgeBg: const Color(0xFFFFE4E6),
      subLabelColor: const Color(0xFFE11D48),
    ),
  };
}

// ── Status Badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.textColor,
    required this.bgColor,
  });

  final String label;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 48,
            color: _primary.withValues(alpha: 0.30),
          ),
          const SizedBox(height: 12),
          Text(
            'No redemptions found',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF374151).withValues(alpha: 0.60),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom Nav Bar ────────────────────────────────────────────────────────────

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(color: _primary.withValues(alpha: 0.10)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _NavItem(icon: Icons.home_outlined, label: 'Home', active: false),
              _NavItem(
                icon: Icons.inventory_2_outlined,
                label: 'Orders',
                active: false,
              ),
              _NavItem(
                icon: Icons.account_balance_wallet_rounded,
                label: 'Earnings',
                active: true,
              ),
              _NavItem(
                icon: Icons.person_outline_rounded,
                label: 'Profile',
                active: false,
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
    required this.label,
    required this.active,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? _primary : const Color(0xFF9CA3AF);
    return GestureDetector(
      onTap: () {
        // TODO: navigate via BLoC / router
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
