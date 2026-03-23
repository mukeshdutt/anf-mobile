import 'package:flutter/material.dart';
import '../dashboard_colors.dart';

class DashboardBottomNav extends StatelessWidget {
  const DashboardBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: isDark
            ? DashboardColors.slate900.withOpacity(0.9)
            : Colors.white.withOpacity(0.8),
        border: Border(
          top: BorderSide(
            color: DashboardColors.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_rounded, 'Home', true, isDark),
            _buildNavItem(Icons.explore_outlined, 'Browse', false, isDark),
            _buildNavItem(Icons.shopping_cart_outlined, 'Cart', false, isDark),
            _buildNavItem(
              Icons.favorite_outline_rounded,
              'Wishlist',
              false,
              isDark,
            ),
            _buildNavItem(
              Icons.person_outline_rounded,
              'Profile',
              false,
              isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    bool isDark,
  ) {
    final color = isActive
        ? DashboardColors.primary
        : (isDark ? DashboardColors.slate400 : DashboardColors.slate400);

    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
