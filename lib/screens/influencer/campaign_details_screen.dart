import 'package:flutter/material.dart';

class CampaignDetailsScreen extends StatefulWidget {
  final String title;
  final String category;
  final String budget;
  final String minFollowers;
  final String ageRange;
  final bool initialApplied;

  const CampaignDetailsScreen({
    super.key,
    this.title = 'Summer Style Campaign',
    this.category = 'Fashion',
    this.budget = '₹10,000',
    this.minFollowers = '5,000',
    this.ageRange = '18-30',
    this.initialApplied = false,
  });

  @override
  State<CampaignDetailsScreen> createState() => _CampaignDetailsScreenState();
}

class _CampaignDetailsScreenState extends State<CampaignDetailsScreen> {
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color background = Color(0xFFF8F9FB);
  static const Color borderColor = Color(0xFFE5E7EB);

  late bool _hasApplied;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _hasApplied = widget.initialApplied;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Color(0xFF182230),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Campaign Details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF182230),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: _isSaved ? primaryPurple : const Color(0xFF667085),
              size: 22,
            ),
            onPressed: () {
              setState(() {
                _isSaved = !_isSaved;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isSaved ? 'Campaign bookmarked' : 'Bookmark removed',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campaign Banner / Media Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 48,
                          color: Color(0xFF8B5CF6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Category Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E8FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.category,
                        style: const TextStyle(
                          color: primaryPurple,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF182230),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2x2 Specs Grid
              Row(
                children: [
                  Expanded(
                    child: _buildSpecBox('Budget', widget.budget),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSpecBox('Category', widget.category),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildSpecBox('Min. Followers', widget.minFollowers),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSpecBox('Age Range', widget.ageRange),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campaign Description',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF182230),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Inviting creators to showcase summer styles with authentic and high quality visual content. Focus on creative aesthetics that highlight breezy streetwear and vibrant fashion trends.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF475467),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Requirements Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Requirements',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF182230),
                      ),
                    ),
                    SizedBox(height: 10),
                    _RequirementItem(text: 'Deliver 1 Instagram Reel and 1 Story'),
                    _RequirementItem(
                      text: 'Tag @summerbrand and use hashtag #SummerStyle',
                    ),
                    _RequirementItem(
                      text: 'High-resolution video format (1080p, 60fps)',
                    ),
                    _RequirementItem(
                      text: 'Submit draft 48 hours before publishing',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Eligibility Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xFF059669),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'You are eligible to apply',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF065F46),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Apply / Applied Button (Screen 9 vs Screen 11 alternate view)
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _hasApplied ? const Color(0xFFE5E7EB) : primaryPurple,
                    foregroundColor:
                        _hasApplied ? const Color(0xFF6B7280) : Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _hasApplied ? null : _applyToCampaign,
                  child: Text(
                    _hasApplied ? 'Applied' : 'Apply Now',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color:
                          _hasApplied ? const Color(0xFF6B7280) : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10.5, color: Color(0xFF667085)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF182230),
            ),
          ),
        ],
      ),
    );
  }

  void _applyToCampaign() {
    setState(() {
      _hasApplied = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Application submitted successfully!'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;

  const _RequirementItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: Color(0xFF7C3AED),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF344054),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
