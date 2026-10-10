import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String _selectedRole = 'Influencer';

  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color backgroundColor = Color(0xFFF8F9FB);
  static const Color textColor = Color(0xFF182230);
  static const Color subtitleColor = Color(0xFF667085);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E7EB)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'How will you use\nInfluish?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Choose the option that fits you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: subtitleColor),
                  ),
                  const SizedBox(height: 26),

                  // Influencer option
                  _buildRoleCard(
                    title: "I'm an Influencer",
                    description:
                        'Discover campaigns and\ncollaborate with brands.',
                    role: 'Influencer',
                    icon: Icons.person_outline_rounded,
                  ),

                  const SizedBox(height: 12),

                  // Advertiser option
                  _buildRoleCard(
                    title: "I'm an Advertiser",
                    description: 'Find influencers and promote\nyour brand.',
                    role: 'Advertiser',
                    icon: Icons.storefront_outlined,
                  ),

                  const SizedBox(height: 24),

                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPurple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String description,
    required String role,
    required IconData icon,
  }) {
    final bool isSelected = _selectedRole == role;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEDE0FF) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? primaryPurple : const Color(0xFFE5E7EB),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFFE7EEFF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? primaryPurple : const Color(0xFF667085),
                size: 21,
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
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 10.5,
                      height: 1.4,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? primaryPurple : Colors.white,
                border: Border.all(
                  color: isSelected ? primaryPurple : const Color(0xFFE5E7EB),
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 13, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _continue() {
    // Navigation to the login screen will be added next.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected role: $_selectedRole'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
