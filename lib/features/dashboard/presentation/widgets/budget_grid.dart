import 'package:flutter/material.dart';
import '../dashboard_colors.dart';

class BudgetGrid extends StatelessWidget {
  const BudgetGrid({super.key});

  final List<Map<String, String>> items = const [
    {
      'label': 'Under ₹299',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDdtmvKc-ic85UQXUdNbd4-6BBSnMnCvFHgjdtwmkVnRLARs6Jy5-Sg48pBtwZxXchXqQsTAtWseKJVq7cseAgPqo39HVLpT7NGZHMFYsJgn-4F5x6Pb54DPcJbTc27ukGKY65H_En5RzJ2bsBQ2_p_8IQlkIGUm-686RVvVB3n8E2xfpeTY865DlG3Mt2XRiGS-vlJg582t3DXiqcHKakUyowRmvffjMSWXiF3hECIb0JwsT-fX0Ij0YDCJrs-c1GOzViVBQMTU_s',
    },
    {
      'label': 'Under ₹499',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAkoMOrw76JkTxu57BVN7sbl6k-vMgsMo43Hb7e2yfalMiTyfvadGKd8hhhgHczPgf-kTbtuYnXriGE8hSWx5NKoz5rIDPq3-p9yQWfMn4RFyOskdXKog16raeVfkRGwaosKkEdXYMXbJ5PkGXfW3Z5Dume5Vix_CchaLY0oFgokHO0r98enXRma2pSRtJLaXKbrRqBlxHvesZfV5GllRbY9upUZBdLiJzdEdx_2nNVUiLIr21Lpml_8DlDfP_8UuXXY_KiXUBVECw',
    },
    {
      'label': 'Under ₹799',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDJug3I8CGzxPcAQ12aKC6p12Ih_nEuk5h6hUi3Qc5lvNA1hd_sRiispTJKgP4vH14zyDB2TkUwSWOChvRg2c8lxxHIJksAXKQotpoPK4ptzlo337SzaD24IrnPWeF4ADO40GJJjRYA79I39cGUuC2uEYA3UytqVRsSM_7lT95Y7QZYGozFyy10L0RD7QXj60HsPN0GFgtrLT_RCIGeqdkLarXSXLHCbqkg8dzhoONbOJXKROUl5OT_qOuNtobCCbAkvPiytrL_38k',
    },
    {
      'label': 'Under ₹999',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCPn0-ufnwdoO-wda96J0w2CMfLo38INWx2XLIQEeAUa9wzkNX6R6SZLg-bQ1qCEGtQqSF9fxai6dMdfG1NxpkMNHynWBVeJW0TpIbE8EZnLy6XepvPKtn9GdL2OX638jj3zilB2LMBuIf9_igLOPbqehDnrhJFG7wd3eXfVTjVVMAD2Oongm0YDNDQ00aoYL0cFftr5GTsgBmYSxqk_4vsXmIdl8prCYFBTlAP4SBCXv0ku8fMi4yA--zdogvP-_TToIDd2teNwlE',
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
              'Shop Under Budget',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? DashboardColors.slate100
                    : DashboardColors.slate900,
              ),
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
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(item['image']!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        item['label']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
