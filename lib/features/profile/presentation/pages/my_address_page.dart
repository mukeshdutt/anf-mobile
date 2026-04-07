import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Brand tokens (screen-local)
// ---------------------------------------------------------------------------
const _primary = Color(0xFFCF0269);
const _bgLight = Color(0xFFF8F5F7);
const _slate500 = Color(0xFF64748B);
const _slate600 = Color(0xFF475569);
const _slate900 = Color(0xFF0F172A);

// ---------------------------------------------------------------------------
// Data model
// ---------------------------------------------------------------------------

enum _AddressType { home, office, other }

class _Address {
  const _Address({
    required this.type,
    required this.label,
    required this.line,
    required this.contact,
    this.isDefault = false,
  });

  final _AddressType type;
  final String label;
  final String line;
  final String contact;
  final bool isDefault;
}

const _addresses = <_Address>[
  _Address(
    type: _AddressType.home,
    label: 'Home',
    line: '123 Elegant Avenue, Suite 456, Minimal City, 90001, India',
    contact: 'John Doe  •  +1 234 567 8900',
    isDefault: true,
  ),
  _Address(
    type: _AddressType.office,
    label: 'Office',
    line: '789 Corporate Blvd, Floor 12, Tech District, 90002, India',
    contact: 'John Doe  •  +1 234 567 8900',
  ),
  _Address(
    type: _AddressType.other,
    label: "Parent's Place",
    line: '42 Harmony Heights, Sector 15, Green Valley, 560001, India',
    contact: 'Jane Doe  •  +1 987 654 3210',
  ),
];

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class MyAddressPage extends StatelessWidget {
  const MyAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: Column(
        children: [
          const _AddressAppBar(),
          Expanded(
            child: Stack(
              children: [
                // Scrollable list
                ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                  children: [
                    ..._addresses.map(
                      (a) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _AddressCard(address: a),
                      ),
                    ),
                    const _TipCard(),
                  ],
                ),
                // Sticky "Add New Address" button
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: _bgLight,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor: _primary.withValues(alpha: 0.30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.add, size: 20),
                        label: const Text(
                          'Add New Address',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          // TODO: navigate to add address
                        },
                      ),
                    ),
                  ),
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
// App bar — centered title
// ---------------------------------------------------------------------------

class _AddressAppBar extends StatelessWidget {
  const _AddressAppBar();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Material(
      color: _bgLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: top),
          Container(
            height: 56,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x1ACF0269))),
            ),
            child: Row(
              children: [
                // Back button
                GestureDetector(
                  onTap: () {
                    // TODO: pop navigation
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: const Icon(Icons.arrow_back, size: 24),
                  ),
                ),
                // Centered title
                const Expanded(
                  child: Text(
                    'My Addresses',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
                // Spacer to visually balance the back button
                const SizedBox(width: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Address card
// ---------------------------------------------------------------------------

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address});

  final _Address address;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon tile
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(_iconFor(address.type), color: _primary, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label + optional DEFAULT badge
                    Row(
                      children: [
                        Text(
                          address.label,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: _slate900,
                          ),
                        ),
                        if (address.isDefault) ...[
                          const SizedBox(width: 8),
                          const _DefaultBadge(),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address.line,
                      style: const TextStyle(
                        fontSize: 13,
                        color: _slate600,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      address.contact,
                      style: const TextStyle(
                        fontSize: 11,
                        color: _slate500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Divider
          Divider(height: 1, color: _primary.withValues(alpha: 0.07)),
          const SizedBox(height: 10),
          // Edit / Delete row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ActionBtn(
                icon: Icons.edit_outlined,
                label: 'Edit',
                color: _slate600,
                onTap: () {
                  // TODO: navigate to edit address
                },
              ),
              Container(
                width: 1,
                height: 14,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                color: _primary.withValues(alpha: 0.15),
              ),
              _ActionBtn(
                icon: Icons.delete_outline,
                label: 'Delete',
                color: _slate600,
                onTap: () {
                  // TODO: confirm and delete address
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _iconFor(_AddressType type) {
    switch (type) {
      case _AddressType.home:
        return Icons.home_outlined;
      case _AddressType.office:
        return Icons.work_outline;
      case _AddressType.other:
        return Icons.location_on_outlined;
    }
  }
}

// ---------------------------------------------------------------------------
// DEFAULT badge
// ---------------------------------------------------------------------------

class _DefaultBadge extends StatelessWidget {
  const _DefaultBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(99),
      ),
      child: const Text(
        'DEFAULT',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: _primary,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Action button (Edit / Delete)
// ---------------------------------------------------------------------------

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Tip info card
// ---------------------------------------------------------------------------

class _TipCard extends StatelessWidget {
  const _TipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _primary.withValues(alpha: 0.10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_outline, color: _primary, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Save your frequent locations to speed up your checkout process next time.',
              style: TextStyle(
                fontSize: 12,
                color: _primary,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom nav — 4 tabs: Shop / Saved / Cart / Profile (active)
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
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottom + 8),
      child: Row(
        children: [
          _NavItem(
            icon: Icons.storefront_outlined,
            label: 'Shop',
            isActive: false,
            onTap: () {
              /* TODO: navigate */
            },
          ),
          _NavItem(
            icon: Icons.favorite_border,
            label: 'Saved',
            isActive: false,
            onTap: () {
              /* TODO: navigate */
            },
          ),
          _NavItem(
            icon: Icons.shopping_bag_outlined,
            label: 'Cart',
            isActive: false,
            onTap: () {
              /* TODO: navigate */
            },
          ),
          _NavItem(
            icon: Icons.person,
            label: 'Profile',
            isActive: true,
            onTap: () {},
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
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
