import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color _primary = Color(0xFFCF0269);
  static const Color _bgLight = Color(0xFFF8F5F7);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top navigation bar ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(shape: const CircleBorder()),
                  ),
                  Expanded(
                    child: Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF0F172A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // Counterbalance the back button so the title stays centred
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // ── Scrollable body ───────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),

                    // Hero image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/signin_hero.jpg',
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Welcome heading
                    Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: const Color(0xFF0F172A),
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Sign in to explore the latest in premium ethnic fashion and designer collections',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blueGrey.shade600,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Email field
                    _FieldLabel('Email Address'),
                    const SizedBox(height: 8),
                    _AuthTextField(
                      controller: _emailController,
                      hint: 'yourname@example.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.mail_outline,
                    ),

                    const SizedBox(height: 20),

                    // Password field with inline "Forgot Password?" link
                    Row(
                      children: [
                        const _FieldLabel('Password'),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // TODO: navigate to forgot-password
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: _primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _AuthTextField(
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

                    const SizedBox(height: 32),

                    // Sign In CTA
                    SizedBox(
                      height: 56,
                      child: FilledButton(
                        onPressed: () {
                          // TODO: dispatch sign-in action
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: _primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: _primary.withValues(alpha: 0.20),
                          elevation: 6,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // OR divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: _primary.withValues(alpha: 0.12),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey.shade400,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: _primary.withValues(alpha: 0.12),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Social buttons
                    Row(
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
                            label: 'Facebook',
                            logo: const Icon(
                              Icons.facebook,
                              size: 22,
                              color: Color(0xFF1877F2),
                            ),
                            onTap: () {
                              // TODO: Facebook sign-in
                            },
                          ),
                        ),
                      ],
                    ),

                    // Sign Up link
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
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Sign Up',
                                style: const TextStyle(
                                  color: _primary,
                                  fontWeight: FontWeight.w800,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: navigate to register
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
            ),
          ],
        ),
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
      text,
      style: const TextStyle(
        color: Color(0xFF1E293B),
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  const _AuthTextField({
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
        prefixIcon: Icon(
          prefixIcon,
          color: _primary.withValues(alpha: 0.60),
          size: 20,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primary.withValues(alpha: 0.20)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: _primary.withValues(alpha: 0.20)),
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
        side: BorderSide(
          color: const Color(0xFFCF0269).withValues(alpha: 0.12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          logo,
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }
}
