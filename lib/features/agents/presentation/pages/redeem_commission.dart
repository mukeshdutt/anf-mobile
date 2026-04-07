import 'package:flutter/material.dart';

const _primary = Color(0xFFCF0269);
const _bgLight = Color(0xFFF8F5F7);

enum _PayoutMethod { upi, bankTransfer }

class RedeemCommissionPage extends StatefulWidget {
  const RedeemCommissionPage({super.key});

  @override
  State<RedeemCommissionPage> createState() => _RedeemCommissionPageState();
}

class _RedeemCommissionPageState extends State<RedeemCommissionPage> {
  _PayoutMethod _selectedMethod = _PayoutMethod.upi;

  final _amountController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _ifscController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: const _RedeemAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _BalanceCard(),
                const SizedBox(height: 24),
                _AmountInputSection(controller: _amountController),
                const SizedBox(height: 24),
                _PayoutMethodSection(
                  selected: _selectedMethod,
                  onChanged: (m) => setState(() => _selectedMethod = m),
                  bankNameController: _bankNameController,
                  accountNumberController: _accountNumberController,
                  ifscController: _ifscController,
                ),
                const SizedBox(height: 24),
                const _DecorationBlob(),
              ],
            ),
          ),
          const _RedeemButton(),
        ],
      ),
    );
  }
}

// ── App Bar ────────────────────────────────────────────────────────────────

class _RedeemAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _RedeemAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: _bgLight.withValues(alpha: 0.9),
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_rounded, color: _primary),
        ),
      ),
      title: const Text(
        'Redeem Commission',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A1A2E),
        ),
      ),
    );
  }
}

// ── Balance Card ───────────────────────────────────────────────────────────

class _BalanceCard extends StatelessWidget {
  const _BalanceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_primary, Color(0xFFFF4D9D)],
        ),
        boxShadow: [
          BoxShadow(
            color: _primary.withValues(alpha: 0.30),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Stack(
        children: [
          // decorative blob top-right
          Positioned(
            right: -24,
            top: -24,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // decorative wallet icon bottom-right
          Positioned(
            right: 12,
            bottom: 0,
            child: Icon(
              Icons.account_balance_wallet_rounded,
              size: 64,
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AVAILABLE BALANCE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.80),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '₹3,200',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.90),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'You can withdraw your commission anytime.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.90),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Amount Input ───────────────────────────────────────────────────────────

class _AmountInputSection extends StatelessWidget {
  const _AmountInputSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enter Amount',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _primary.withValues(alpha: 0.15),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  '₹',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: _primary,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter amount to redeem',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9CA3AF),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 14,
              color: _primary.withValues(alpha: 0.70),
            ),
            const SizedBox(width: 4),
            Text(
              'Minimum redeem amount: ₹500',
              style: TextStyle(
                fontSize: 12,
                color: _primary.withValues(alpha: 0.70),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Payout Method ──────────────────────────────────────────────────────────

class _PayoutMethodSection extends StatelessWidget {
  const _PayoutMethodSection({
    required this.selected,
    required this.onChanged,
    required this.bankNameController,
    required this.accountNumberController,
    required this.ifscController,
  });

  final _PayoutMethod selected;
  final ValueChanged<_PayoutMethod> onChanged;
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController ifscController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Payout Method',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _MethodTile(
                icon: Icons.payments_rounded,
                label: 'UPI',
                selected: selected == _PayoutMethod.upi,
                onTap: () => onChanged(_PayoutMethod.upi),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MethodTile(
                icon: Icons.account_balance_rounded,
                label: 'Bank Transfer',
                selected: selected == _PayoutMethod.bankTransfer,
                onTap: () => onChanged(_PayoutMethod.bankTransfer),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _BankDetailsForm(
          bankNameController: bankNameController,
          accountNumberController: accountNumberController,
          ifscController: ifscController,
        ),
      ],
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: selected ? _primary.withValues(alpha: 0.06) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? _primary : _primary.withValues(alpha: 0.10),
            width: selected ? 2 : 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: _primary),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BankDetailsForm extends StatelessWidget {
  const _BankDetailsForm({
    required this.bankNameController,
    required this.accountNumberController,
    required this.ifscController,
  });

  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController ifscController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primary.withValues(alpha: 0.10)),
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
          _BankField(
            label: 'BANK NAME',
            controller: bankNameController,
            placeholder: 'e.g. HDFC Bank',
            obscure: false,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          _BankField(
            label: 'ACCOUNT NUMBER',
            controller: accountNumberController,
            placeholder: '•••• •••• •••• 1234',
            obscure: true,
          ),
          const SizedBox(height: 16),
          _BankField(
            label: 'IFSC CODE',
            controller: ifscController,
            placeholder: 'HDFC0001234',
            obscure: false,
            textCapitalization: TextCapitalization.characters,
          ),
        ],
      ),
    );
  }
}

class _BankField extends StatelessWidget {
  const _BankField({
    required this.label,
    required this.controller,
    required this.placeholder,
    required this.obscure,
    this.textCapitalization = TextCapitalization.none,
  });

  final String label;
  final TextEditingController controller;
  final String placeholder;
  final bool obscure;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          textCapitalization: textCapitalization,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
            fillColor: _bgLight,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: _primary.withValues(alpha: 0.30),
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Decoration Blob ────────────────────────────────────────────────────────

class _DecorationBlob extends StatelessWidget {
  const _DecorationBlob();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Container(
          width: 200,
          height: 60,
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

// ── Redeem Now Button ──────────────────────────────────────────────────────

class _RedeemButton extends StatelessWidget {
  const _RedeemButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        decoration: BoxDecoration(
          color: _bgLight.withValues(alpha: 0.97),
          border: Border(
            top: BorderSide(color: _primary.withValues(alpha: 0.10)),
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: dispatch redeem commission event via BLoC
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            shadowColor: _primary.withValues(alpha: 0.35),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Redeem Now',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
