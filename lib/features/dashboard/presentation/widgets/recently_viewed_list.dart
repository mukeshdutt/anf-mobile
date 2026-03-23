import 'package:flutter/material.dart';
import '../dashboard_colors.dart';

class RecentlyViewedList extends StatelessWidget {
  const RecentlyViewedList({super.key});

  final List<Map<String, String>> items = const [
    {
      'title': 'Chikankari Teal Suit',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCgbSTvMoVbb3cLK4h3YlgyZfstyyElsOnL4sOJb-0nzAJTHEr6Iiy4ZoWmwxcbIcS1HsUNkerEUP3DxMwrh0yYGGzbJjsZ0UNXFUh5ShCoj_VRfkMOVI3GOBFFDaxLG-0AqypB0zOyP7pdb2bRIQfi2n0qmRgwjbGJUAfZvM7jIgGirMHb6YkSYwGqUoJAkvAG3Jv6nxiML_VxyF-aVkkCwoUv6NjhI5as9OOevKSKU_eqrGtpbTNXp-XZ7pGqJgxruCKs2ZUZnLk',
    },
    {
      'title': 'Red Banarasi Saree',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAK46VfZ6LSYAztUiilwx0Pr1BeLpEQRwg5VyzP6dyaxvPtzLlNU9oLkY732L5nJB_J_zRGk82MSksl9dcfvwaDGXKRhqWeTsBYSH0TRMajZc3kD5zf2FLdKg5Oi6rZyDQLO5L7gXClV1fIDzddZgzaTOkhOEl1F6ZJDtxeuxeqhV0O36r3basObNWllxxB_9GcQNqmrRWY8YFRuNq5OrsQkr3qw7guflTIlV2wgfYlsnyJ6U2I9GoT4KUSx63yvEsXPE9Sm7YG3XA',
    },
    {
      'title': 'Floral Block Print',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD6eHfeTPX9Lbd559wAT8kJh_Mb3veEnpO_tRDo4WizJJWLOcn14Sn9AP6tkClK318e6OswMcILyfV2BhmGn7ToEfIJRH9SU7d5Ul-x9zebO-z0cwBbVtkOjkOZTwBbr_sVTwpp8PiOjXOQfPCulAAFCHCR7cxidZdmPyvD7FXy2fMJ__Gd_Nc1BRkkXJViIypITfVk7EbyKrWvEO784Q0vb3bE58gkUr6mVOXMtzksvm4iHf5mqyi6SDBpYL7tFBypY-IopJ40ioA',
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
              'Recently Viewed',
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
            height: 150,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final item = items[index];
                return SizedBox(
                  width: 128,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 128,
                        decoration: BoxDecoration(
                          color: isDark
                              ? DashboardColors.slate800
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
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
                          image: DecorationImage(
                            image: NetworkImage(item['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['title']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? DashboardColors.slate300
                              : DashboardColors.slate700,
                        ),
                      ),
                    ],
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
