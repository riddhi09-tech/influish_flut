import 'package:flutter/material.dart';

import '../../models/advertiser_campaign.dart';
import '../../models/advertiser_store.dart';
import '../../widgets/bottom_nav_bar.dart';
import 'applicants_screen.dart';
import 'company_profile_setup_screen.dart';
import 'create_campaign_screen.dart';

class AdvertiserHomeScreen extends StatefulWidget {
  const AdvertiserHomeScreen({super.key});

  @override
  State<AdvertiserHomeScreen> createState() => _AdvertiserHomeScreenState();
}

class _AdvertiserHomeScreenState extends State<AdvertiserHomeScreen> {
  int _selectedTab = 0;

  List<AdvertiserCampaign> get _campaigns => AdvertiserStore.campaigns;

  @override
  Widget build(BuildContext context) {
    AdvertiserStore.syncFromInfluencerApplications();

    final activeCampaigns = _campaigns
        .where((campaign) => campaign.status == 'Open')
        .length;
    final applications = _campaigns.fold<int>(
      0,
      (sum, campaign) => sum + campaign.applications.length,
    );
    final pendingReviews = _campaigns.fold<int>(
      0,
      (sum, campaign) =>
          sum +
          campaign.applications
              .where((applicant) => applicant.status == 'Pending')
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
            ),
            _CampaignsTab(campaigns: _campaigns),
            const _AlertsTab(),
            CompanyProfileSetupScreen(isEditMode: true),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() => _selectedTab = index);
        },
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  final int activeCampaigns;
  final int applications;
  final int pendingReviews;

  const _HomeTab({
    required this.activeCampaigns,
    required this.applications,
    required this.pendingReviews,
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
                          const CompanyProfileSetupScreen(isEditMode: true),
                    ),
                  );
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9D5FF),
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
            AdvertiserStore.profile.companyName,
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreateCampaignScreen(),
                  ),
                );
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
          ...AdvertiserStore.campaigns.map(
            (campaign) => _CampaignCard(campaign: campaign),
          ),
        ],
      ),
    );
  }
}

class _CampaignsTab extends StatelessWidget {
  final List<AdvertiserCampaign> campaigns;

  const _CampaignsTab({required this.campaigns});

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
                  .map((campaign) => _CampaignCard(campaign: campaign))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertsTab extends StatelessWidget {
  const _AlertsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Alerts coming soon.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
        ),
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
  final AdvertiserCampaign campaign;

  const _CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    final isDraft = campaign.status == 'Draft';

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
                      campaign.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${campaign.budget.replaceAll(RegExp(r'[^0-9]'), '')}',
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
                '${campaign.applications.length} Applicants',
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          CreateCampaignScreen(campaignToEdit: campaign),
                    ),
                  );
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
                elevation:
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
