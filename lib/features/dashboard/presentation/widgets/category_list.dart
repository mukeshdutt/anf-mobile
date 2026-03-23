import 'package:flutter/material.dart';
import '../dashboard_colors.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  final List<Map<String, String>> categories = const [
    {
      'name': 'Saree',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBxnj71LPqtNw9SkJL-S9KRtCGpzk0tf9cWOeGQ-EIwWwmeIhsrA5wfMvHi0fp8nsznMfl9SSOwxkBIXo7Gj2iQz5cLtBFaVMo6Uo3eQr-QRE4KkV3b9oofBDMH_JYOSx9ypN3FRmJ9Q82K39gFvqUlDD2vmxTGDkrg2u2xNx7tbEsaaYYSaKVIWZ5Zf2WbyyoVXdLAqItpmtOc9KIKAzbqu2y1vujYRVZizfyXE5C6nx6pkZQNFUNl3BI5x7z_f56zWDLGWPxQA_I',
    },
    {
      'name': 'Suits',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAJzIVgiww0hlEt8RT1q-vf87xKKzp9rtShGDlPwz2QBBCuDuIRm4Rg6pABxsGNrba9twsJ11FwP3s-iSikh2JD9H-vFby3Ids1CXIGR2_DGCctlri_5VvH2XIpv0dD71cxzPB82miw0OPR1koTGWT1a0KZjOW3cjBxwXXuWQZPJ2GnRWHpiOPXhdgWcJazAGlPiXIPms1bDe_7oZx9caX2VKGuL3FAJKe8Vc9r3uIJELtSpBaAAnqMGQcoervgHVfICi4vy1DCZao',
    },
    {
      'name': 'Bed Sheets',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAIrSL2w_BZbIJvuoPbpxGKV4R-UTh8o5TpM6j_xXcuky1qllsXXzBcCViBRdrkDbFRNlm-c8fAo5nHpSXBOx1lxDpC3UO-iSKZMZsZ5jF5JQL5VXfjPyfzgZ3BeYE0YnKyCFzmTD0qLErvimMq-Sx5dg5t8yGCkpveoXkhXGV-xfB-kXqatx_vp1f8mr1pv21cjQmUiBTOixmiNVnat1GtBU8WJNiqm6wFhMQFaslRwO2nE3IferimJq0soMiAmLIOzCQK3pKIMAE',
    },
    {
      'name': 'Chikankari',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBK1hYqNvZ4dqla5kijcOKKHnt3CFIwSDOdfDVAWdmhiiKhXpqyPyenReCWEpBzcWQiTWo_sPZbqGJ4L8nl4zmzaYchdeNTfVSHJq61hSAfgs2OIMbFaR2_y4WJFWH1EphKBqr2lwb0CjilMY6et_DOjFHXiOuxwQCXyOUdg8D4NXL-RQHmSyGIzi-Phwbjqwqp-2MnKuJYZKefjI7oSGxGnqmv0FIefoIKwvB58LdM98xU-RA7CQ2rq-gG-B-Yeml2tj43uSavKxQ',
    },
    {
      'name': 'Zari Work',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBaZhVdNuKFUlWRrR-VswWtx2wRmELVopcTN9h2LTathMrUAZ2bfhGAoY24yK-G6zzxeCIp8yvQNTrpVAkxt479qUd0tUux2d3h_rdwz8XlZQ8AYyJjWk4PcwW4FYndMab__qruk_7i3wC_ZC42ma-pwF1DWFoUCYKrUv_gBBx-1QJ-26_Ah7gaOUYjxqxlJdwgYFwEZkaRPq4lrCidC0ArWtoAjVx4js_J3t1lRuW1Y1BQybN-0mTES3XLIDCAnmC0Mgs-vF9LlaE',
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
                  'Categories',
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
          SizedBox(
            height: 96,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final category = categories[index];
                return Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: isDark ? DashboardColors.slate800 : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: DashboardColors.primary.withOpacity(0.05),
                        ),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        category['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name']!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? DashboardColors.slate300
                            : DashboardColors.slate700,
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
