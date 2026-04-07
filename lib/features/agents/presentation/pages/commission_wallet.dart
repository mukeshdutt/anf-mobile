import 'package:flutter/material.dart';

class CommissionWalletPage extends StatefulWidget {
  const CommissionWalletPage({super.key});

  @override
  State<CommissionWalletPage> createState() => _CommissionWalletPageState();
}

class _CommissionWalletPageState extends State<CommissionWalletPage>
    with SingleTickerProviderStateMixin {
  static const _primary = Color(0xFFCF0269);
  static const _bgLight = Color(0xFFF8F5F7);

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
      appBar: _WalletAppBar(primary: _primary, bgLight: _bgLight),
      body: Column(
        children: [
          _WalletSummaryCard(primary: _primary),
          _TransactionTabBar(
            tabController: _tabController,
            primary: _primary,
            bgLight: _bgLight,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _TransactionList(
                  transactions: _allTransactions,
                  primary: _primary,
                ),
                _TransactionList(
                  transactions: _allTransactions
                      .where((t) => t.status == _TxnStatus.pending)
                      .toList(),
                  primary: _primary,
                ),
                _TransactionList(
                  transactions: _allTransactions
                      .where((t) => t.status == _TxnStatus.settled)
                      .toList(),
                  primary: _primary,
                ),
                _TransactionList(
                  transactions: _allTransactions
                      .where((t) => t.status == _TxnStatus.redeemed)
                      .toList(),
                  primary: _primary,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _RedeemBar(primary: _primary, bgLight: _bgLight),
    );
  }
}

// ── Sample data ───────────────────────────────────────────────────────────────

enum _TxnStatus { settled, pending, redeemed }

class _TxnData {
  const _TxnData({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    required this.imagePath,
    required this.isDebit,
  });

  final String title;
  final String subtitle;
  final String amount;
  final _TxnStatus status;
  final String imagePath;
  final bool isDebit;
}

const _allTransactions = [
  _TxnData(
    title: 'Order #54821',
    subtitle: 'Order Value: ₹1,299 | 12 Oct',
    amount: '+₹129',
    status: _TxnStatus.settled,
    imagePath: 'assets/images/wallet_txn_saree_pink.jpg',
    isDebit: false,
  ),
  _TxnData(
    title: 'Order #54910',
    subtitle: 'Order Value: ₹3,450 | 14 Oct',
    amount: '+₹345',
    status: _TxnStatus.pending,
    imagePath: 'assets/images/wallet_txn_saree_blue.jpg',
    isDebit: false,
  ),
  _TxnData(
    title: 'Order #55002',
    subtitle: 'Order Value: ₹4,200 | 15 Oct',
    amount: '+₹420',
    status: _TxnStatus.pending,
    imagePath: 'assets/images/wallet_txn_lehenga_yellow.jpg',
    isDebit: false,
  ),
  _TxnData(
    title: 'Redemption Request',
    subtitle: 'To Bank A/C ...4521 | 10 Oct',
    amount: '-₹2,500',
    status: _TxnStatus.redeemed,
    imagePath: 'assets/images/wallet_txn_anarkali_red.jpg',
    isDebit: true,
  ),
];

// ── AppBar ────────────────────────────────────────────────────────────────────

class _WalletAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _WalletAppBar({required this.primary, required this.bgLight});

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
      centerTitle: false,
      leadingWidth: 56,
      leading: InkWell(
        onTap: () => Navigator.maybePop(context),
        borderRadius: BorderRadius.circular(20),
        child: Icon(Icons.arrow_back, color: Colors.grey.shade900),
      ),
      title: const Text(
        'Commission Wallet',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.help_outline_rounded, color: Colors.grey.shade900),
          onPressed: () {}, // TODO: show help
        ),
      ],
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

// ── Gradient wallet card ──────────────────────────────────────────────────────

class _WalletSummaryCard extends StatelessWidget {
  const _WalletSummaryCard({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFCF0269), Color(0xFFFF4D9D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // decorative blobs
            Positioned(
              right: -24,
              top: -24,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              left: -24,
              bottom: -24,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.08),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '₹3,200',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _WalletSubStat(
                          label: 'Pending',
                          value: '₹2,800',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _WalletSubStat(
                          label: 'Redeemed',
                          value: '₹6,450',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.2),
                    height: 1,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Lifetime Earnings',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                      const Text(
                        '₹12,450',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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

class _WalletSubStat extends StatelessWidget {
  const _WalletSubStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tab bar ───────────────────────────────────────────────────────────────────

class _TransactionTabBar extends StatelessWidget {
  const _TransactionTabBar({
    required this.tabController,
    required this.primary,
    required this.bgLight,
  });

  final TabController tabController;
  final Color primary;
  final Color bgLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: primary,
            unselectedLabelColor: Colors.grey.shade500,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            indicatorColor: primary,
            indicatorWeight: 3,
            dividerColor: primary.withValues(alpha: 0.08),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            tabs: const [
              Tab(text: 'All Transactions'),
              Tab(text: 'Pending'),
              Tab(text: 'Settled'),
              Tab(text: 'Redeemed'),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Transaction list ──────────────────────────────────────────────────────────

class _TransactionList extends StatelessWidget {
  const _TransactionList({required this.transactions, required this.primary});

  final List<_TxnData> transactions;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          'No transactions',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      itemCount: transactions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          _TransactionCard(txn: transactions[index], primary: primary),
    );
  }
}

// ── Transaction card ──────────────────────────────────────────────────────────

class _TransactionCard extends StatelessWidget {
  const _TransactionCard({required this.txn, required this.primary});
  final _TxnData txn;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(txn.imagePath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  txn.subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                txn.amount,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: txn.isDebit ? Colors.black87 : primary,
                ),
              ),
              const SizedBox(height: 6),
              _StatusBadge(status: txn.status),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final _TxnStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      _TxnStatus.settled => (
        'SETTLED',
        const Color(0xFFD1FAE5),
        const Color(0xFF065F46),
      ),
      _TxnStatus.pending => (
        'PENDING',
        const Color(0xFFFFEDD5),
        const Color(0xFF9A3412),
      ),
      _TxnStatus.redeemed => (
        'REDEEMED',
        const Color(0xFFF1F5F9),
        const Color(0xFF475569),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}

// ── Sticky Redeem button ──────────────────────────────────────────────────────

class _RedeemBar extends StatelessWidget {
  const _RedeemBar({required this.primary, required this.bgLight});
  final Color primary;
  final Color bgLight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: bgLight.withValues(alpha: 0.92),
        border: Border(top: BorderSide(color: primary.withValues(alpha: 0.1))),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
            onPressed: () {}, // TODO: nav to redeem commission
            icon: const Icon(Icons.account_balance_wallet_outlined, size: 20),
            label: const Text(
              'Redeem Commission',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: primary.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
