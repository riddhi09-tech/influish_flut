import 'package:flutter/material.dart';

import 'advertiser_alerts_screen.dart';
import 'applicants_screen.dart';
import 'company_profile_setup_screen.dart';
import 'create_campaign_screen.dart';

String advertiserCompanyName = 'Glow & Co.';

final List<Map<String, dynamic>> demoCampaigns = [
  {
    'title': 'Summer Style Campaign',
    'budget': '₹75,000',
    'status': 'Open',
    'category': 'Fashion',
    'description':
        'Promote the Summer collection for premium fashion creators.',
    'applications': [
      {'name': 'Riya Malhotra', 'status': 'Pending'},
      {'name': 'Isha Verma', 'status': 'Accepted'},
      {'name': 'Nisha Kapoor', 'status': 'Pending'},
    ],
  },
  {
    'title': 'Urban Activewear Launch',
    'budget': '₹90,000',
    'status': 'Open',
    'category': 'Fitness',
    'description':
        'Launch a fresh collection with fitness and lifestyle creators.',
    'applications': [
      {'name': 'Ananya Shah', 'status': 'Accepted'},
      {'name': 'Meher Singh', 'status': 'Pending'},
      {'name': 'Kavya Sen', 'status': 'Rejected'},
      {'name': 'Aman Goyal', 'status': 'Pending'},
    ],
  },
  {
    'title': 'Spring Essentials',
    'budget': '₹55,000',
    'status': 'Draft',
    'category': 'Lifestyle',
    'description': 'Budget-friendly campaign for spring and wellness creators.',
    'applications': [
      {'name': 'Tanya Reddy', 'status': 'Pending'},
    ],
  },
];

class AdvertiserHomeScreen extends StatefulWidget {
  const AdvertiserHomeScreen({super.key});

  @override
  State<AdvertiserHomeScreen> createState() => _AdvertiserHomeScreenState();
}

class _AdvertiserHomeScreenState extends State<AdvertiserHomeScreen> {
  int _selectedTab = 0;
  final List<Map<String, dynamic>> _campaigns = List.from(demoCampaigns);

  Future<void> _openCreateCampaign() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const CreateCampaignScreen()));

    if (result is Map<String, dynamic> && mounted) {
      setState(() {
        _campaigns.add(result);
      });
    }
  }

  Future<void> _editCampaign(Map<String, dynamic> campaign) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CreateCampaignScreen(campaignToEdit: campaign),
      ),
    );

    if (result is Map<String, dynamic> && mounted) {
      final index = _campaigns.indexWhere((item) => identical(item, campaign));
      if (index != -1) {
        setState(() {
          _campaigns[index] = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeCampaigns = _campaigns
        .where((campaign) => campaign['status'] == 'Open')
        .length;
    final applications = _campaigns.fold<int>(
      0,
      (sum, campaign) => sum + (campaign['applications'] as List).length,
    );
    final pendingReviews = _campaigns.fold<int>(
      0,
      (sum, campaign) =>
          sum +
          (campaign['applications'] as List)
              .where((app) => app['status'] == 'Pending')
              .length,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F2F9),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedTab,
          children: [
            _HomeTab(
              activeCampaigns: activeCampaigns,
              applications: applications,
              pendingReviews: pendingReviews,
              companyName: advertiserCompanyName,
              campaigns: _campaigns,
              onCreateCampaign: _openCreateCampaign,
              onEditCampaign: _editCampaign,
            ),
            _CampaignsTab(campaigns: _campaigns, onEditCampaign: _editCampaign),
            const AdvertiserAlertsScreen(),
            CompanyProfileSetupScreen(isEditMode: true),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => setState(() => _selectedTab = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF7C3AED),
        unselectedItemColor: const Color(0xFF6B7280),
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_outlined),
            label: 'Campaigns',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  final int activeCampaigns;
  final int applications;
  final int pendingReviews;
  final String companyName;
  final List<Map<String, dynamic>> campaigns;
  final Future<void> Function() onCreateCampaign;
  final Future<void> Function(Map<String, dynamic>) onEditCampaign;

  const _HomeTab({
    required this.activeCampaigns,
    required this.applications,
    required this.pendingReviews,
    required this.companyName,
    required this.campaigns,
    required this.onCreateCampaign,
    required this.onEditCampaign,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Influish',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF8B5CF6),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          CompanyProfileSetupScreen(isEditMode: true),
                    ),
                  );
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE9D5FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: Color(0xFF7C3AED)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Welcome back,',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            companyName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () async {
                await onCreateCampaign();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                '+ Create Campaign',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Active Campaigns',
                  value: activeCampaigns.toString(),
                  trend: '',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Applications',
                  value: applications.toString(),
                  trend: '+5 this week',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Pending Reviews',
                  value: pendingReviews.toString(),
                  trend: 'Need action',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Your Campaigns',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 14),
          ...campaigns.map(
            (campaign) => _CampaignCard(
              campaign: campaign,
              onEditCampaign: onEditCampaign,
            ),
          ),
        ],
      ),
    );
  }
}

class _CampaignsTab extends StatelessWidget {
  final List<Map<String, dynamic>> campaigns;
  final Future<void> Function(Map<String, dynamic>) onEditCampaign;

  const _CampaignsTab({required this.campaigns, required this.onEditCampaign});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Campaigns',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView(
              children: campaigns
                  .map(
                    (campaign) => _CampaignCard(
                      campaign: campaign,
                      onEditCampaign: onEditCampaign,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String trend;

  const _StatCard({
    required this.label,
    required this.value,
    required this.trend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 6),
          if (trend.isNotEmpty)
            Text(
              trend,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF10B981),
                fontWeight: FontWeight.w700,
              ),
            ),
        ],
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final Map<String, dynamic> campaign;
  final Future<void> Function(Map<String, dynamic>) onEditCampaign;

  const _CampaignCard({required this.campaign, required this.onEditCampaign});

  @override
  Widget build(BuildContext context) {
    final isDraft = campaign['status'] == 'Draft';
    final title = campaign['title'] as String;
    final budget = campaign['budget'] as String;
    final applications = campaign['applications'] as List;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9D5FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF7C3AED),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      budget,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isDraft
                      ? const Color(0xFFFEF3C7)
                      : const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isDraft ? 'DRAFT' : 'OPEN',
                  style: TextStyle(
                    color: isDraft
                        ? const Color(0xFF92400E)
                        : const Color(0xFF7C3AED),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.people, size: 14, color: Color(0xFF8B5CF6)),
              const SizedBox(width: 6),
              Text(
                '${applications.length} Applicants',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (isDraft) {
                  onEditCampaign(campaign);
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ApplicantsScreen(campaign: campaign),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF3E8FF),
                foregroundColor: const Color(0xFF7C3AED),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(isDraft ? 'Edit Draft' : 'View Applicants'),
            ),
          ),
        ],
      ),
    );
  }
}
