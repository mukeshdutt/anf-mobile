import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  // Brand colours (local constants — wire up to app theme when ready)
  static const Color _primary = Color(0xFFCF0269);
  static const Color _bgLight = Color(0xFFF8F5F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background texture ──────────────────────────────────────────
          Opacity(
            opacity: 0.20,
            child: Image.asset(
              'assets/images/splash_bg_texture.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ── Gradient overlay ────────────────────────────────────────────
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xCCF8F5F7), // ~80 % opaque
                  _bgLight,
                  _bgLight,
                ],
              ),
            ),
          ),

          // ── Decorative corner icons ─────────────────────────────────────
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Icon(
                Icons.auto_awesome,
                size: 80,
                color: _primary.withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Icon(
                Icons.filter_vintage,
                size: 80,
                color: _primary.withValues(alpha: 0.10),
              ),
            ),
          ),

          // ── Main content ────────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                children: [
                  const Spacer(),

                  // Brand identity
                  const _BrandSection(),

                  const Spacer(),

                  // Loading / footer section
                  const _LoadingSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Brand identity ─────────────────────────────────────────────────────────────

class _BrandSection extends StatelessWidget {
  const _BrandSection();

  static const Color _primary = Color(0xFFCF0269);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Diamond icon in a soft circle
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.diamond, color: _primary, size: 48),
        ),

        const SizedBox(height: 32),

        // Brand name
        Text(
          'ANEKRITI',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: const Color(0xFF0F172A), // slate-900
            fontWeight: FontWeight.w300,
            letterSpacing: 12,
          ),
        ),

        const SizedBox(height: 24),

        // Thin divider
        Container(width: 48, height: 1, color: _primary),

        const SizedBox(height: 24),

        // Tagline
        Text(
          'WHERE TRADITION MEETS MODERNITY',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _primary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
      ],
    );
  }
}

// ── Loading / footer section ────────────────────────────────────────────────────

class _LoadingSection extends StatelessWidget {
  const _LoadingSection();

  // TODO: replace with animated progress driven by splash logic
  static const double _progress = 0.45;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Text(
          'CRAFTING ELEGANCE',
          style: TextStyle(
            color: Colors.blueGrey.shade400,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 3,
          ),
        ),

        const SizedBox(height: 12),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 4,
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: const Color(0xFFCF0269).withValues(alpha: 0.10),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFCF0269),
              ),
            ),
          ),
        ),

        const SizedBox(height: 48),

        // Footer
        Text(
          'Premium Ethnic Wear  •  Since 2024',
          style: TextStyle(
            color: Colors.blueGrey.shade300,
            fontSize: 9,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
