import 'package:flutter/material.dart';
import '../dashboard_colors.dart';

class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDark ? DashboardColors.slate800 : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        child: TextField(
          style: TextStyle(
            color: isDark ? DashboardColors.slate100 : DashboardColors.slate900,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: 'Search for sarees, suits, bedsheets...',
            hintStyle: const TextStyle(
              color: DashboardColors.slate400,
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: DashboardColors.slate400,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
