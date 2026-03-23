import 'package:flutter/material.dart';
import '../dashboard_colors.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_search_bar.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/category_list.dart';
import '../widgets/price_range_list.dart';
import '../widgets/budget_grid.dart';
import '../widgets/featured_products_grid.dart';
import '../widgets/recently_viewed_list.dart';
import '../widgets/dashboard_bottom_nav.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? DashboardColors.backgroundDark
          : DashboardColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                bottom: 100,
              ), // padding for bottom nav
              child: Column(
                children: const [
                  DashboardHeader(),
                  DashboardSearchBar(),
                  HeroCarousel(),
                  CategoryList(),
                  PriceRangeList(),
                  BudgetGrid(),
                  FeaturedProductsGrid(),
                  RecentlyViewedList(),
                ],
              ),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: DashboardBottomNav(),
            ),
          ],
        ),
      ),
    );
  }
}
