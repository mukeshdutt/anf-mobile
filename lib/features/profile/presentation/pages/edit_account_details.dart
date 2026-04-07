import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Brand tokens (screen-local)
// ---------------------------------------------------------------------------
const _primary = Color(0xFFCF0269);
const _bgLight = Color(0xFFF8F5F7);
const _slate600 = Color(0xFF475569);
const _slate400 = Color(0xFF94A3B8);
const _slate900 = Color(0xFF0F172A);

// ---------------------------------------------------------------------------
// Page
// ---------------------------------------------------------------------------

class EditAccountDetailsPage extends StatefulWidget {
  const EditAccountDetailsPage({super.key});

  @override
  State<EditAccountDetailsPage> createState() => _EditAccountDetailsPageState();
}

class _EditAccountDetailsPageState extends State<EditAccountDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController(text: 'Jane Doe');
  final _emailCtrl = TextEditingController(text: 'jane.doe@example.com');
  final _phoneCtrl = TextEditingController(text: '+1 (555) 000-1234');
  final _locationCtrl = TextEditingController(text: 'New York, USA');

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: Column(
        children: [
          const _AccountAppBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Avatar section
                    const _AvatarSection(),
                    const SizedBox(height: 32),

                    // Form fields
                    _IconTextField(
                      label: 'Full Name',
                      controller: _nameCtrl,
                      icon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 16),
                    _IconTextField(
                      label: 'Email Address',
                      controller: _emailCtrl,
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _IconTextField(
                      label: 'Phone Number',
                      controller: _phoneCtrl,
                      icon: Icons.call_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _IconTextField(
                      label: 'Location',
                      controller: _locationCtrl,
                      icon: Icons.location_on_outlined,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: 32),

                    // Save Changes
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          shadowColor: _primary.withValues(alpha: 0.25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // TODO: dispatch save account details event
                          }
                        },
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    // Deactivate Account
                    TextButton(
                      onPressed: () {
                        // TODO: confirm and deactivate account
                      },
                      child: const Text(
                        'Deactivate Account',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _slate400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const _BottomNavBar(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// App bar — back (primary), centered title
// ---------------------------------------------------------------------------

class _AccountAppBar extends StatelessWidget {
  const _AccountAppBar();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Material(
      color: _bgLight.withValues(alpha: 0.92),
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
                GestureDetector(
                  onTap: () {
                    /* TODO: pop */
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back,
                      color: _primary,
                      size: 24,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Account Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _slate900,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // balance
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Avatar section — circular photo + edit button + name + badge
// ---------------------------------------------------------------------------

class _AvatarSection extends StatelessWidget {
  const _AvatarSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Outer ring
            Container(
              width: 128,
              height: 128,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _primary.withValues(alpha: 0.25),
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/profile_avatar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Edit button
            Positioned(
              bottom: 2,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  /* TODO: pick image */
                },
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: _primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: _bgLight, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: _primary.withValues(alpha: 0.35),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Jane Doe',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: _slate900,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Premium Member',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _primary,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Icon-prefixed text field with label
// ---------------------------------------------------------------------------

class _IconTextField extends StatelessWidget {
  const _IconTextField({
    required this.label,
    required this.controller,
    required this.icon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
  });

  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

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
              color: _slate600,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          style: const TextStyle(fontSize: 15, color: _slate900),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: _primary.withValues(alpha: 0.60),
              size: 20,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _primary.withValues(alpha: 0.12)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _primary.withValues(alpha: 0.12)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom nav — Home / Search / Orders / Profile (active)
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
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottom + 16),
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
            icon: Icons.search,
            label: 'Search',
            isActive: false,
            onTap: () {
              /* TODO */
            },
          ),
          _NavItem(
            icon: Icons.receipt_long_outlined,
            label: 'Orders',
            isActive: false,
            onTap: () {
              /* TODO */
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
    final color = isActive ? _primary : _slate400;
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
                fontWeight: FontWeight.w700,
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
