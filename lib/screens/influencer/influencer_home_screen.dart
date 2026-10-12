import 'package:flutter/material.dart';

import 'campaign_details_screen.dart';

class InfluencerHomeScreen extends StatefulWidget {
  final void Function(int index)? onNavigateTab;

  const InfluencerHomeScreen({super.key, this.onNavigateTab});

  @override
  State<InfluencerHomeScreen> createState() => _InfluencerHomeScreenState();
}

class _InfluencerHomeScreenState extends State<InfluencerHomeScreen> {
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color background = Color(0xFFF8F9FB);
  static const Color borderColor = Color(0xFFE5E7EB);

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allCampaigns = [
    {
      'title': 'Summer Style Campaign',
      'category': 'Fashion',
      'budget': '₹10,000',
      'minFollowers': '5,000',
      'ageRange': '18-30',
      'brand': 'UrbanWear Co.',
    },
    {
      'title': 'Natural Glow Collection',
      'category': 'Beauty',
      'budget': '₹7,500',
      'minFollowers': '3,000',
      'ageRange': '18-35',
      'brand': 'Bloom Essentials',
    },
    {
      'title': 'Weekend Escape Story',
      'category': 'Travel',
      'budget': '₹12,000',
      'minFollowers': '10,000',
      'ageRange': '20-35',
      'brand': 'Nomad Stays',
    },
  ];

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCampaigns = _allCampaigns.where((c) {
      final title = (c['title'] as String).toLowerCase();
      final cat = (c['category'] as String).toLowerCase();
      final q = _searchQuery.toLowerCase();
      return title.contains(q) || cat.contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Influiish',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryPurple,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Good morning, arvi antala',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF182230),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Find campaigns that match your niche',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF667085),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.onNavigateTab != null) {
                        widget.onNavigateTab!(2); // Switch to Alerts tab
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: Color(0xFF344054),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                        style: const TextStyle(fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Search campaigns',
                          hintStyle: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF98A2B3),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 19,
                            color: Color(0xFF98A2B3),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: borderColor),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      size: 20,
                      color: Color(0xFF344054),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Section Header
              const Text(
                'Recommended for you',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF182230),
                ),
              ),
              const SizedBox(height: 14),

              // Campaign Cards List
              ListView.separated(
                itemCount: filteredCampaigns.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, i) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = filteredCampaigns[index];
                  return _buildCampaignCard(context, item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Media Thumbnail
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.image_outlined,
              color: primaryPurple,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),

          // Information
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
                const SizedBox(height: 3),
                Text(
                  item['category'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF667085),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['budget'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF182230),
                  ),
                ),
              ],
            ),
          ),

          // View Details Button
          SizedBox(
            height: 34,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CampaignDetailsScreen(
                      title: item['title'] as String,
                      category: item['category'] as String,
                      budget: item['budget'] as String,
                      minFollowers: item['minFollowers'] as String,
                      ageRange: item['ageRange'] as String,
                    ),
                  ),
                );
              },
              child: const Text(
                'View Details',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
