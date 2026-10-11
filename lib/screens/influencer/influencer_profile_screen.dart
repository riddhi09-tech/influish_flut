import 'package:flutter/material.dart';

import 'influencer_edit_profile_screen.dart';
import 'influencer_support_screen.dart';

class InfluencerProfileScreen extends StatefulWidget {
  const InfluencerProfileScreen({super.key});

  @override
  State<InfluencerProfileScreen> createState() =>
      _InfluencerProfileScreenState();
}

class _InfluencerProfileScreenState extends State<InfluencerProfileScreen> {
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color background = Color(0xFFF8F9FB);
  static const Color borderColor = Color(0xFFE5E7EB);

  String _name = 'arvi antala';
  String _instagram = '@arviantala';
  String _followers = '251K';
  String _age = '20';
  String _category = 'Fashion';
  String _bio =
      'Fashion is designed to be a good quality and dear quality of living.';
  final String _email = 'arviantala@gmail.com';
  final String _location = 'Mumbai, India';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Influiish',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryPurple,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.help_outline_rounded,
              color: Color(0xFF667085),
              size: 22,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InfluencerSupportScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            children: [
              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        color: primaryPurple,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          'AA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Name
                    Text(
                      _name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF182230),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _instagram,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF667085),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Stats row: Category | Followers | Age
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem('Category', _category),
                        Container(
                          width: 1,
                          height: 28,
                          color: borderColor,
                        ),
                        _buildStatItem('Followers', _followers),
                        Container(
                          width: 1,
                          height: 28,
                          color: borderColor,
                        ),
                        _buildStatItem('Age', _age),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Bio
                    Text(
                      _bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF475467),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Edit Profile button
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryPurple,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => InfluencerEditProfileScreen(
                                name: _name,
                                instagram: _instagram,
                                followers: _followers,
                                age: _age,
                                category: _category,
                                bio: _bio,
                              ),
                            ),
                          );

                          if (result is Map<String, dynamic>) {
                            setState(() {
                              _name = result['name'] ?? _name;
                              _instagram = result['instagram'] ?? _instagram;
                              _followers = result['followers'] ?? _followers;
                              _age = result['age'] ?? _age;
                              _category = result['category'] ?? _category;
                              _bio = result['bio'] ?? _bio;
                            });
                          }
                        },
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Contact Details Card
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
                    const Text(
                      'Contact Details',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF182230),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.email_outlined,
                          size: 16,
                          color: Color(0xFF667085),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _email,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Color(0xFF667085),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Recent Content Section
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
                    const Text(
                      'Recent Content',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF182230),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildContentThumbnail(
                            icon: Icons.camera_alt_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildContentThumbnail(
                            icon: Icons.play_circle_outline_rounded,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.bold,
            color: Color(0xFF182230),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF667085),
          ),
        ),
      ],
    );
  }

  Widget _buildContentThumbnail({required IconData icon}) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9FE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          icon,
          color: primaryPurple,
          size: 26,
        ),
      ),
    );
  }
}
