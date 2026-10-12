import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  static const Color background = Color(0xFFF8F9FB);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color primaryPurple = Color(0xFF7C3AED);

  final List<Map<String, dynamic>> _alerts = const [
    {
      'title': 'Application Accepted',
      'description':
          'Your application for Summer Style Campaign was accepted!',
      'time': '2h ago',
      'icon': Icons.check_circle_outline_rounded,
      'iconColor': Color(0xFF059669),
      'iconBg': Color(0xFFECFDF5),
    },
    {
      'title': 'Campaign Reminder',
      'description': 'Draft submission deadline is tomorrow at 5 PM.',
      'time': '1d ago',
      'icon': Icons.access_time_rounded,
      'iconColor': Color(0xFF7C3AED),
      'iconBg': Color(0xFFEDE9FE),
    },
    {
      'title': 'Brand Message',
      'description': 'Brand sent a message regarding creative direction.',
      'time': '3d ago',
      'icon': Icons.chat_bubble_outline_rounded,
      'iconColor': Color(0xFFD946EF),
      'iconBg': Color(0xFFFDF4FF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 18, 18, 14),
              child: Text(
                'Alerts',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF182230),
                  letterSpacing: -0.3,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: _alerts.length,
                separatorBuilder: (_, i) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final alert = _alerts[index];
                  return Container(
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
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: alert['iconBg'] as Color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            alert['icon'] as IconData,
                            color: alert['iconColor'] as Color,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert['title'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF182230),
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                alert['description'] as String,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF475467),
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          alert['time'] as String,
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF98A2B3),
                          ),
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
    );
  }
}
