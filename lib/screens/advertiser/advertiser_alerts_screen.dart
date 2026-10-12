import 'package:flutter/material.dart';

class AdvertiserAlertsScreen extends StatelessWidget {
  const AdvertiserAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 22),
      children: const [
        Text(
          'Alerts',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 18),
        _AlertCard(
          icon: Icons.check_circle_outline,
          iconColor: Color(0xFF10B981),
          iconBackground: Color(0xFFD1FAE5),
          title: 'Application Accepted',
          message: 'Your application for Summer Style Campaign was accepted!',
          time: '2h ago',
        ),
        SizedBox(height: 12),
        _AlertCard(
          icon: Icons.access_time,
          iconColor: Color(0xFF7C3AED),
          iconBackground: Color(0xFFEDE9FE),
          title: 'Campaign Reminder',
          message: 'Draft submission deadline is tomorrow at 5 PM.',
          time: '1d ago',
        ),
        SizedBox(height: 12),
        _AlertCard(
          icon: Icons.chat_bubble_outline,
          iconColor: Color(0xFFDB2777),
          iconBackground: Color(0xFFFCE7F3),
          title: 'Brand Message',
          message: 'Brand sent a message regarding creative direction.',
          time: '3d ago',
        ),
      ],
    );
  }
}

class _AlertCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String message;
  final String time;

  const _AlertCard({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 23),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
