import 'package:flutter/material.dart';
import '../dashboard_colors.dart';

class FeaturedProductsGrid extends StatelessWidget {
  const FeaturedProductsGrid({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      'brand': 'Ethnic Grace',
      'title': 'Pure Cotton Saree',
      'price': '₹1,299',
      'originalPrice': '₹1,599',
      'discount': '20% OFF',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDqmCuI1_3wK6L09ODG_xjwDwCnDeALCFY3qOIzxHCylEnt77hVpsDy31XNeOKEULfPBIHwLFnMYlsAHFHd-rYLDyucwRQ8lzo_p8Nrp_FY3DXQm0tiyQ2XRCXVLnt7553z4lhLComQTaixydGr6AiUBqb5sSsN4Kh9Yo7GwVxIUdZ3gDqMBngOv1FgLVhR-EopSHi-roWseJkNT48ycN1x6hc9VyrRTGhfZTk3ZNneT2-RnUF-8YRfUHXpLbZfmPl-xBJA_JbIi2k',
      'isFavorite': true,
    },
    {
      'brand': 'Lucknowi Special',
      'title': 'Chikankari Suit',
      'price': '₹2,499',
      'originalPrice': '₹2,999',
      'discount': '15% OFF',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCTxOgxSPHiBb6R7VPg7aJUofhas8CKNLxfDjC9PsiB6wiAvUIOtGSZBrBK4cIN9JUGlCJrvo6IzzcsPJf9AexSSHL2JbSXlOatmPY1mBQdwir0xGT_xfNpeFgFNGq36fHYh2wSqiUcD99XZCL2RGlTXXzz8e7Koc-rP3p3rkvgpFBLnlhd9lEqIUnZBHLnpExsV6KPMg8jhT5DWfhw6nLerDb89zLw0IVofmhNk1mXkfwE3mdIB3hK4GAzU_nBHrVcmlt-jHiUDiw',
      'isFavorite': false,
    },
    {
      'brand': 'Premium Picks',
      'title': 'Zari Work Dupatta',
      'price': '₹899',
      'originalPrice': null,
      'discount': null,
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuC-8q_kN0H2Ea-nEH8boozgfM_cTUOzDCyqd8v11wIKDz95AYRlzyH5D-jqMNBroItGXQWCFz_bSdH4NG30NQW7R0iXXFa5dRfeBae1Lj1IK0Ti4LjsiDoKCgTLONwVOs9V4aqCmmHJQUrt9Zf0fJqwL6naEgw4pwddpNDvdDRve7p0XuKxDg_CoJt9ZSWCXhul7uCrYwA6Fg90WxscuU9iA0IM461mXCwzkqRLEttE5UsgkOjGy5e_e5QrpCYt4iYlbD7K3bpamiA',
      'isFavorite': false,
    },
    {
      'brand': 'Home Living',
      'title': 'Designer Bedsheet',
      'price': '₹999',
      'originalPrice': '₹1,699',
      'discount': '40% OFF',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB-u395vbIQ-Fa4F5RMAKMA0bv9R13p5LBl8s7T7dGsvxj_Rn0vWxUWqSAnVk6pipSNvoHglTOx1yzvrkug1i_xTsA0QsfbycCDXPuTfxEcFBeNR3WiiWwdgGTb4gCeOEyTyhqcfEJeDCrd3hIB0-SLa9aayC_eLL-_O8iGSb-qYM2J-PAzlUmBzdGROEAipZKqX6kSUGVRJ2vrsKLSjUo9Xdsor6b3NBmJXLI4kP8vbGinwpIggkPndgSgnESqZnRkeHIfPls0wYk',
      'isFavorite': false,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Products',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? DashboardColors.slate100
                        : DashboardColors.slate900,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: DashboardColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.6,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isDark
                                  ? DashboardColors.slate800
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                if (!isDark)
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(product['image'] as String),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          if (product['discount'] != null)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  product['discount'] as String,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? DashboardColors.slate800.withOpacity(0.8)
                                    : Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.favorite_rounded,
                                color: (product['isFavorite'] as bool)
                                    ? DashboardColors.primary
                                    : DashboardColors.slate400,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product['brand'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: DashboardColors.slate500,
                      ),
                    ),
                    Text(
                      product['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? DashboardColors.slate100
                            : DashboardColors.slate900,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          product['price'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: DashboardColors.primary,
                          ),
                        ),
                        if (product['originalPrice'] != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            product['originalPrice'] as String,
                            style: const TextStyle(
                              fontSize: 10,
                              color: DashboardColors.slate400,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
