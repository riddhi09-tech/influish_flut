import 'package:flutter/material.dart';

import '../../models/admin_store.dart';

class ManageCampaignsScreen extends StatefulWidget {
  const ManageCampaignsScreen({super.key});

  @override
  State<ManageCampaignsScreen> createState() => _ManageCampaignsScreenState();
}

class _ManageCampaignsScreenState extends State<ManageCampaignsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedTab = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AdminCampaignSummary> get _filteredCampaigns {
    final query = _searchController.text.trim().toLowerCase();
    return AdminStore.campaigns.where((campaign) {
      final matchesTab =
          _selectedTab == 'All' || campaign.status == _selectedTab;
      final haystack = '${campaign.title} ${campaign.advertiser}'.toLowerCase();
      final matchesQuery = query.isEmpty || haystack.contains(query);
      return matchesTab && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Campaigns',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Review campaigns published on Infl uish.',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search campaigns...',
                    prefixIcon: Icon(Icons.search, color: Color(0xFF8B5CF6)),
                    hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: ['All', 'Open', 'Closed'].map((filter) {
                  final selected = _selectedTab == filter;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: selected,
                        selectedColor: const Color(0xFFEDE9FE),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: selected
                              ? const Color(0xFF7C3AED)
                              : const Color(0xFF6B7280),
                          fontWeight: FontWeight.w700,
                        ),
                        onSelected: (_) {
                          setState(() => _selectedTab = filter);
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  itemCount: _filteredCampaigns.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final campaign = _filteredCampaigns[index];
                    return Container(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      campaign.advertiser,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: campaign.status == 'Open'
                                      ? const Color(0xFFDCFCE7)
                                      : const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  campaign.status,
                                  style: TextStyle(
                                    color: campaign.status == 'Open'
                                        ? const Color(0xFF15803D)
                                        : const Color(0xFF374151),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _SummaryChip(
                                label: 'Budget',
                                value: campaign.budget,
                              ),
                              const SizedBox(width: 8),
                              _SummaryChip(
                                label: 'Applicants',
                                value: campaign.applicants.toString(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Viewing ${campaign.title}',
                                      ),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF8B5CF6),
                                ),
                                child: const Text('View'),
                              ),
                              const Spacer(),
                              if (campaign.status == 'Open')
                                ElevatedButton(
                                  onPressed: () {
                                    AdminStore.deactivateCampaign(campaign.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Campaign deactivated.'),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF8B5CF6),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Deactivate'),
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
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Color(0xFF7C3AED),
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}
