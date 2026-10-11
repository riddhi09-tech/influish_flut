import 'package:flutter/material.dart';

import 'influencer_profile_review_screen.dart';

class ApplicantsScreen extends StatefulWidget {
  final Map<String, dynamic> campaign;

  const ApplicantsScreen({super.key, required this.campaign});

  @override
  State<ApplicantsScreen> createState() => _ApplicantsScreenState();
}

class _ApplicantsScreenState extends State<ApplicantsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _allApplicants = [
    {
      'name': 'Aanya Shah',
      'username': '@aanyashah',
      'category': 'Fashion',
      'followers': '28.4K',
      'engagement': '5.9%',
      'date': '12 Mar 2026',
      'status': 'Pending',
      'age': 24,
      'bio': 'Lifestyle creator focused on fashion styling, travel, and brand storytelling.',
      'instagram': '@aanyashah',
    },
    {
      'name': 'Riya Malhotra',
      'username': '@riya.style',
      'category': 'Beauty',
      'followers': '45.2K',
      'engagement': '6.7%',
      'date': '10 Mar 2026',
      'status': 'Pending',
      'age': 23,
      'bio': 'Beauty and skincare creator with strong audience trust and content quality.',
      'instagram': '@riya.style',
    },
    {
      'name': 'Karan Mehta',
      'username': '@thefitflow',
      'category': 'Fitness',
      'followers': '32.8K',
      'engagement': '4.8%',
      'date': '08 Mar 2026',
      'status': 'Accepted',
      'age': 27,
      'bio': 'Fitness coach sharing workout routines, mobility content, and healthy living.',
      'instagram': '@thefitflow',
    },
    {
      'name': 'Simran Sethi',
      'username': '@simranlive',
      'category': 'Lifestyle',
      'followers': '19.6K',
      'engagement': '5.3%',
      'date': '06 Mar 2026',
      'status': 'Rejected',
      'age': 22,
      'bio': 'Creator focused on everyday lifestyle, home styling, and candid reels.',
      'instagram': '@simranlive',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredApplicants {
    final query = _searchController.text.toLowerCase();

    return _allApplicants.where((applicant) {
      final matchesText =
          query.isEmpty ||
          applicant['name'].toString().toLowerCase().contains(query) ||
          applicant['username'].toString().toLowerCase().contains(query);
      final matchesFilter =
          _selectedFilter == 'All' || applicant['status'] == _selectedFilter;
      return matchesText && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Influish',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF7C3AED),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon.')),
              );
            },
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF1F2937)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Applicants',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Campaign: ${widget.campaign['title']}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search applicants',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF6B7280),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF7C3AED)),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Text(
                    'Filter:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _selectedFilter,
                    items: const ['All', 'Pending', 'Accepted', 'Rejected']
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFilter = value ?? 'All';
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredApplicants.length,
                  itemBuilder: (context, index) {
                    final applicant = _filteredApplicants[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9D5FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Color(0xFF7C3AED),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      applicant['name'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                    Text(
                                      applicant['username'],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: _statusColor(applicant['status']),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  applicant['status'],
                                  style: const TextStyle(
                                    color: Color(0xFF1F2937),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.label_outline,
                                size: 15,
                                color: Color(0xFF7C3AED),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                applicant['category'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(width: 18),
                              const Icon(
                                Icons.trending_up,
                                size: 15,
                                color: Color(0xFF7C3AED),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${applicant['followers']} followers',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.analytics_outlined,
                                size: 15,
                                color: Color(0xFF7C3AED),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Engagement ${applicant['engagement']}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                              const SizedBox(width: 18),
                              const Icon(
                                Icons.calendar_month,
                                size: 15,
                                color: Color(0xFF7C3AED),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                applicant['date'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            InfluencerProfileReviewScreen(
                                              influencer: applicant,
                                              campaign: widget.campaign,
                                            ),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFF7C3AED),
                                    ),
                                    foregroundColor: const Color(0xFF7C3AED),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('View Profile'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${applicant['name']} accepted.',
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF7C3AED),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Accept'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${applicant['name']} rejected.',
                                        ),
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFFEC4899),
                                    ),
                                    foregroundColor: const Color(0xFFEC4899),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text('Reject'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Accepted':
        return const Color(0xFFDCFCE7);
      case 'Rejected':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFF3E8FF);
    }
  }
}
