import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  static const _primary = Color(0xFFCF0269);
  static const _bgLight = Color(0xFFF8F5F7);

  final _currentCtrl = TextEditingController();
  final _newCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  // Strength: 0-4 bars filled
  int _strengthBars = 2;

  @override
  void initState() {
    super.initState();
    _newCtrl.addListener(_updateStrength);
  }

  void _updateStrength() {
    final pw = _newCtrl.text;
    int bars = 0;
    if (pw.length >= 8) bars++;
    if (pw.contains(RegExp(r'[A-Z]'))) bars++;
    if (pw.contains(RegExp(r'[0-9]'))) bars++;
    if (pw.contains(RegExp(r'[^A-Za-z0-9]'))) bars++;
    setState(() => _strengthBars = bars);
  }

  String get _strengthLabel {
    switch (_strengthBars) {
      case 0:
      case 1:
        return 'WEAK';
      case 2:
        return 'MEDIUM STRENGTH';
      case 3:
        return 'STRONG';
      case 4:
        return 'VERY STRONG';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _currentCtrl.dispose();
    _newCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: _ChangePasswordAppBar(primary: _primary, bgLight: _bgLight),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderSection(primary: _primary),
                  const SizedBox(height: 32),
                  _PasswordField(
                    label: 'Current Password',
                    controller: _currentCtrl,
                    placeholder: 'Enter current password',
                    obscure: !_showCurrent,
                    primary: _primary,
                    onToggle: () =>
                        setState(() => _showCurrent = !_showCurrent),
                  ),
                  const SizedBox(height: 24),
                  _NewPasswordField(
                    controller: _newCtrl,
                    obscure: !_showNew,
                    primary: _primary,
                    strengthBars: _strengthBars,
                    strengthLabel: _strengthLabel,
                    onToggle: () => setState(() => _showNew = !_showNew),
                  ),
                  const SizedBox(height: 24),
                  _PasswordField(
                    label: 'Confirm New Password',
                    controller: _confirmCtrl,
                    placeholder: 'Repeat new password',
                    obscure: !_showConfirm,
                    primary: _primary,
                    onToggle: () =>
                        setState(() => _showConfirm = !_showConfirm),
                  ),
                  const SizedBox(height: 32),
                  _UpdateButton(primary: _primary),
                  const SizedBox(height: 32),
                  _InfoCard(primary: _primary),
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

class _ChangePasswordAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _ChangePasswordAppBar({required this.primary, required this.bgLight});

  final Color primary;
  final Color bgLight;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.maybePop(context), // TODO: nav
        borderRadius: BorderRadius.circular(20),
        child: Icon(Icons.arrow_back, color: Colors.grey.shade900),
      ),
      title: const Text(
        'Change Password',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: const Color(0xFFCF0269).withValues(alpha: 0.1),
        ),
      ),
    );
  }
}

// ── Header Section ────────────────────────────────────────────────────────────

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security Update',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'To keep your Anekriti account safe, please choose a strong password that is at least 8 characters long.',
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

// ── Password Field ────────────────────────────────────────────────────────────

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.placeholder,
    required this.obscure,
    required this.primary,
    required this.onToggle,
  });

  final String label;
  final TextEditingController controller;
  final String placeholder;
  final bool obscure;
  final Color primary;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary.withValues(alpha: 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary.withValues(alpha: 0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary, width: 1.5),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: primary,
                size: 22,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }
}

// ── New Password + Strength Bar ───────────────────────────────────────────────

class _NewPasswordField extends StatelessWidget {
  const _NewPasswordField({
    required this.controller,
    required this.obscure,
    required this.primary,
    required this.strengthBars,
    required this.strengthLabel,
    required this.onToggle,
  });

  final TextEditingController controller;
  final bool obscure;
  final Color primary;
  final int strengthBars;
  final String strengthLabel;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'New Password',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(fontSize: 15),
          decoration: InputDecoration(
            hintText: 'Create new password',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary.withValues(alpha: 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary.withValues(alpha: 0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary, width: 1.5),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: primary,
                size: 22,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        _StrengthBar(
          primary: primary,
          filledBars: strengthBars,
          label: strengthLabel,
        ),
      ],
    );
  }
}

// ── Strength Bar ──────────────────────────────────────────────────────────────

class _StrengthBar extends StatelessWidget {
  const _StrengthBar({
    required this.primary,
    required this.filledBars,
    required this.label,
  });

  final Color primary;
  final int filledBars;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          for (int i = 0; i < 4; i++) ...[
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: i < filledBars
                      ? primary
                      : primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            if (i < 3) const SizedBox(width: 4),
          ],
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Update Button ─────────────────────────────────────────────────────────────

class _UpdateButton extends StatelessWidget {
  const _UpdateButton({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // TODO: bloc — dispatch ChangePasswordEvent
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Update Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

// ── Info Card ─────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.primary});
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Changing your password will sign you out of all your devices except the one you're using now.",
              style: TextStyle(
                fontSize: 12,
                height: 1.6,
                color: Colors.grey.shade600,
              ),
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
        color: bgLight.withValues(alpha: 0.92),
        border: Border(top: BorderSide(color: primary.withValues(alpha: 0.1))),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                filledIcon: Icons.home_rounded,
                label: 'HOME',
                active: false,
                primary: primary,
              ),
              _NavItem(
                icon: Icons.lock_outline_rounded,
                filledIcon: Icons.lock_rounded,
                label: 'SECURITY',
                active: true,
                primary: primary,
              ),
              _NavItem(
                icon: Icons.notifications_outlined,
                filledIcon: Icons.notifications_rounded,
                label: 'ACTIVITY',
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
    return Expanded(
      child: InkWell(
        onTap: () {}, // TODO: nav
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              active ? filledIcon : icon,
              color: active ? primary : Colors.grey.shade500,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: active ? primary : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
