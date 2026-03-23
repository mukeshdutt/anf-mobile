import 'package:flutter/material.dart';
import '../dashboard_colors.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: DashboardColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sentiment_satisfied_rounded,
                  color: DashboardColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Hi, Mukesh 👋',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: isDark
                      ? DashboardColors.slate100
                      : DashboardColors.slate900,
                ),
              ),
            ],
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? DashboardColors.slate800 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                  ],
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: isDark
                      ? DashboardColors.slate200
                      : DashboardColors.slate700,
                  size: 20,
                ),
              ),
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: DashboardColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDark
                          ? DashboardColors.backgroundDark
                          : DashboardColors.backgroundLight,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '0',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
