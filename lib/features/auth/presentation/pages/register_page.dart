import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const Color _primary = Color(0xFFCF0269);
  static const Color _bgLight = Color(0xFFF8F5F7);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _termsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: Stack(
        children: [
          // ── Decorative blurred circles ──────────────────────────────────
          Positioned(
            top: -48,
            left: -48,
            child: _DecorativeCircle(
              size: 192,
              color: _primary.withValues(alpha: 0.05),
            ),
          ),
          Positioned(
            bottom: -96,
            right: -96,
            child: _DecorativeCircle(
              size: 256,
              color: _primary.withValues(alpha: 0.05),
            ),
          ),

          // ── Main scrollable content ─────────────────────────────────────
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                        child: IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back),
                          style: IconButton.styleFrom(
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),

                      // Title & subtitle
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create Account',
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    color: const Color(0xFF0F172A),
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Join our community of ethnic fashion lovers today.',
                              style: TextStyle(
                                color: Colors.blueGrey.shade600,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Form fields
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _FieldLabel('Full Name'),
                            const SizedBox(height: 8),
                            _SignUpTextField(
                              controller: _nameController,
                              hint: 'Sarah Jenkins',
                              keyboardType: TextInputType.name,
                              prefixIcon: Icons.person_outline,
                            ),
                            const SizedBox(height: 20),

                            _FieldLabel('Email Address'),
                            const SizedBox(height: 8),
                            _SignUpTextField(
                              controller: _emailController,
                              hint: 'sarah@example.com',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.mail_outline,
                            ),
                            const SizedBox(height: 20),

                            _FieldLabel('Password'),
                            const SizedBox(height: 8),
                            _SignUpTextField(
                              controller: _passwordController,
                              hint: '••••••••',
                              obscureText: !_passwordVisible,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20,
                                  color: Colors.blueGrey.shade400,
                                ),
                                onPressed: () => setState(
                                  () => _passwordVisible = !_passwordVisible,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Terms checkbox
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Checkbox(
                                    value: _termsAccepted,
                                    activeColor: _primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    onChanged: (v) => setState(
                                      () => _termsAccepted = v ?? false,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blueGrey.shade600,
                                        height: 1.5,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text:
                                              'By signing up, you agree to our ',
                                        ),
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: const TextStyle(
                                            color: _primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // TODO: open Terms of Service
                                            },
                                        ),
                                        const TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: const TextStyle(
                                            color: _primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // TODO: open Privacy Policy
                                            },
                                        ),
                                        const TextSpan(text: '.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Create Account CTA
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () {
                                  // TODO: dispatch sign-up action
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: _primary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  shadowColor: _primary.withValues(alpha: 0.25),
                                  elevation: 6,
                                ),
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // OR JOIN WITH divider
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                'OR JOIN WITH',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueGrey.shade400,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Social buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: _SocialButton(
                                label: 'Google',
                                logo: Image.asset(
                                  'assets/images/logo_google.png',
                                  width: 20,
                                  height: 20,
                                ),
                                onTap: () {
                                  // TODO: Google sign-in
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _SocialButton(
                                label: 'Apple',
                                logo: const Icon(Icons.apple, size: 22),
                                onTap: () {
                                  // TODO: Apple sign-in
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Sign In link
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                color: Colors.blueGrey.shade600,
                                fontSize: 14,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Already have an account? ',
                                ),
                                TextSpan(
                                  text: 'Sign In',
                                  style: const TextStyle(
                                    color: _primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // TODO: navigate to login
                                      Navigator.maybePop(context);
                                    },
                                ),
                              ],
                            ),
                          ),
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

// ── Private widgets ─────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: Color(0xFF1E293B), // slate-800
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _SignUpTextField extends StatelessWidget {
  const _SignUpTextField({
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  static const Color _primary = Color(0xFFCF0269);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.blueGrey.shade300, fontSize: 15),
        prefixIcon: Icon(prefixIcon, color: Colors.blueGrey.shade400, size: 20),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _primary, width: 1.5),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.logo,
    required this.onTap,
  });

  final String label;
  final Widget logo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFE2E8F0)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo,
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF334155), // slate-700
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
