import 'package:flutter/material.dart';

const _primary = Color(0xFFCF0269);
const _bgLight = Color(0xFFF8F5F7);
const _textDark = Color(0xFF151B2C);

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: const _PaymentAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _AmountSection(),
                SizedBox(height: 32),
                _PaymentMethodSection(),
                SizedBox(height: 28),
                _OrderingInfoSection(),
                SizedBox(height: 24),
                _TrustIllustration(),
              ],
            ),
          ),
          const _PlaceOrderButton(),
        ],
      ),
    );
  }
}

// ── App Bar ───────────────────────────────────────────────────────────────────

class _PaymentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _PaymentAppBar();

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
              color: _primary,
              height: 1.1,
            ),
          ),
          Text(
            'FINAL STEP',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _textDark.withValues(alpha: 0.45),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(
            Icons.more_vert_rounded,
            color: _textDark.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}

// ── Amount Section ────────────────────────────────────────────────────────────

class _AmountSection extends StatelessWidget {
  const _AmountSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'TOTAL AMOUNT DUE',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _textDark.withValues(alpha: 0.50),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '₹185.00',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: _textDark,
              letterSpacing: -1.0,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_rounded,
                size: 16,
                color: const Color(0xFF00677C),
              ),
              const SizedBox(width: 6),
              const Text(
                'The Precision Atelier Guaranteed',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF00677C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Payment Method Section ────────────────────────────────────────────────────

class _PaymentMethodSection extends StatelessWidget {
  const _PaymentMethodSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'We currently support Cash on Delivery only for your convenience and security.',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: _textDark.withValues(alpha: 0.50),
          ),
        ),
        const SizedBox(height: 16),
        const _CodCard(),
      ],
    );
  }
}

class _CodCard extends StatelessWidget {
  const _CodCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: _primary.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.payments_rounded, color: _primary, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Cash on Delivery',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pay in cash when your order arrives',
                  style: TextStyle(
                    fontSize: 12,
                    color: _textDark.withValues(alpha: 0.50),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: _primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Ordering Info Section ─────────────────────────────────────────────────────

class _OrderingInfoSection extends StatelessWidget {
  const _OrderingInfoSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3FF),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ordering Information',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13,
                height: 1.65,
                color: _textDark.withValues(alpha: 0.55),
              ),
              children: const [
                TextSpan(
                  text:
                      'To ensure a seamless and personalized experience, we are currently exclusively accepting ',
                ),
                TextSpan(
                  text: 'Cash on Delivery',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                  ),
                ),
                TextSpan(
                  text:
                      '. Our courier partner will collect the exact amount at the time of delivery.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_user_rounded,
                  color: _primary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Secure Transaction',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Protected by The Precision Atelier protocols',
                      style: TextStyle(
                        fontSize: 10,
                        color: _textDark.withValues(alpha: 0.50),
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

// ── Trust Illustration ────────────────────────────────────────────────────────

class _TrustIllustration extends StatelessWidget {
  const _TrustIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E).withValues(alpha: 0.90),
            _primary.withValues(alpha: 0.60),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.18,
            child: Icon(Icons.shield_rounded, size: 120, color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_rounded, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              Text(
                'SECURE DELIVERY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.90),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Place Order Button ────────────────────────────────────────────────────────

class _PlaceOrderButton extends StatelessWidget {
  const _PlaceOrderButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: _bgLight.withValues(alpha: 0.92),
          border: Border(
            top: BorderSide(color: _primary.withValues(alpha: 0.10)),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: dispatch place order event via BLoC
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                shadowColor: _primary.withValues(alpha: 0.30),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place Order (₹185.00)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.local_shipping_rounded, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_rounded,
                  size: 11,
                  color: _textDark.withValues(alpha: 0.40),
                ),
                const SizedBox(width: 4),
                Text(
                  'SECURE ORDER PLACEMENT',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: _textDark.withValues(alpha: 0.40),
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
