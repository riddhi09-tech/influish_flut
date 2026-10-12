import 'package:flutter/material.dart';

import 'campaign_details_screen.dart';

class MyApplicationsScreen extends StatefulWidget {
  final String initialFilter;

  const MyApplicationsScreen({super.key, this.initialFilter = 'All'});

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color background = Color(0xFFF8F9FB);
  static const Color borderColor = Color(0xFFE5E7EB);

  late String _selectedFilter;

  final List<String> _filters = ['All', 'Pending', 'Accepted', 'Rejected'];

  final List<Map<String, dynamic>> _applications = [
    {
      'title': 'Summer Style Campaign',
      'category': 'Fashion',
      'appliedDate': '2026-03-01 | 10:45 AM (EST)',
      'status': 'Pending',
      'budget': '₹10,000',
    },
    {
      'title': 'Natural Glow Collection',
      'category': 'Beauty',
      'appliedDate': '2026-02-24 | 02:15 PM (EST)',
      'status': 'Accepted',
      'budget': '₹7,500',
    },
    {
      'title': 'Weekend Escape Story',
      'category': 'Travel',
      'appliedDate': '2026-02-18 | 11:30 AM (EST)',
      'status': 'Rejected',
      'budget': '₹12,000',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _applications.where((app) {
      if (_selectedFilter == 'All') return true;
      return app['status'] == _selectedFilter;
    }).toList();

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Header
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 18, 18, 12),
              child: Text(
                'My Applications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF182230),
                  letterSpacing: -0.3,
                ),
              ),
            ),

            // Filter Chips Bar (Screen 10 & Screen 12 filtered state)
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, i) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFEDE9FE) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? primaryPurple : borderColor,
                          width: isSelected ? 1.4 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected && filter != 'All') ...[
                            const Icon(
                              Icons.check,
                              size: 13,
                              color: primaryPurple,
                            ),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            filter,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  isSelected ? FontWeight.w700 : FontWeight.w500,
                              color:
                                  isSelected ? primaryPurple : const Color(0xFF344054),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),

            // Applications List
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.assignment_late_outlined,
                            size: 46,
                            color: const Color(0xFF98A2B3),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'No $_selectedFilter applications',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF667085),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
                      itemCount: filteredList.length,
                      separatorBuilder: (_, i) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return _buildApplicationCard(context, item);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationCard(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    final status = item['status'] as String;

    Color badgeBg;
    Color badgeText;

    if (status == 'Accepted') {
      badgeBg = const Color(0xFFECFDF5);
      badgeText = const Color(0xFF065F46);
    } else if (status == 'Rejected') {
      badgeBg = const Color(0xFFFEF2F2);
      badgeText = const Color(0xFF991B1B);
    } else {
      badgeBg = const Color(0xFFFFFBEB);
      badgeText = const Color(0xFFB45309);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CampaignDetailsScreen(
              title: item['title'] as String,
              category: item['category'] as String,
              budget: item['budget'] as String,
              initialApplied: true,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.image_outlined,
                color: primaryPurple,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF182230),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['category'] as String,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF667085),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['appliedDate'] as String,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                ],
              ),
            ),

            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: badgeText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
