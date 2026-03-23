import 'package:flutter/material.dart';
import '../dashboard_colors.dart';

class PriceRangeList extends StatelessWidget {
  const PriceRangeList({super.key});

  final List<Map<String, dynamic>> items = const [
    {
      'price': '₹299',
      'colors': [DashboardColors.primary, Color(0xFFF472B6)],
    },
    {
      'price': '₹399',
      'colors': [Color(0xFF6366F1), DashboardColors.primary],
    },
    {
      'price': '₹499',
      'colors': [DashboardColors.primary, Color(0xFFFB923C)],
    },
    {
      'price': '₹599',
      'colors': [Color(0xFF9333EA), DashboardColors.primary],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Shop by Price Range',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? DashboardColors.slate100
                    : DashboardColors.slate900,
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: item['colors'] as List<Color>,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    item['price'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
