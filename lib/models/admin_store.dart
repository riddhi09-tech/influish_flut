class AdminCampaignSummary {
  final String id;
  final String title;
  final String advertiser;
  String status;
  final String budget;
  final int applicants;

  AdminCampaignSummary({
    required this.id,
    required this.title,
    required this.advertiser,
    required this.status,
    required this.budget,
    required this.applicants,
  });
}

class AdminUser {
  final String name;
  final String username;
  final String role;
  final bool isActive;

  AdminUser({
    required this.name,
    required this.username,
    required this.role,
    this.isActive = true,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.isEmpty || parts[0].isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

class AdminReport {
  final String id;
  final String status;
  final String reporterName;
  final String reportedUser;
  final String reason;

  AdminReport({
    required this.id,
    required this.status,
    required this.reporterName,
    required this.reportedUser,
    required this.reason,
  });
}

class AdminContactMessage {
  final String subject;
  final String status;
  final String senderName;
  final String senderRole;
  final String category;
  final String message;

  AdminContactMessage({
    required this.subject,
    required this.status,
    required this.senderName,
    required this.senderRole,
    required this.category,
    required this.message,
  });
}

class AdminStore {
  static final List<AdminCampaignSummary> campaigns = [
    AdminCampaignSummary(
      id: '1',
      title: 'Summer Fashion Promo',
      advertiser: 'Zara Official',
      status: 'Open',
      budget: '\$1,200',
      applicants: 14,
    ),
    AdminCampaignSummary(
      id: '2',
      title: 'Tech Gadget Launch',
      advertiser: 'Apex Electronics',
      status: 'Open',
      budget: '\$2,500',
      applicants: 28,
    ),
    AdminCampaignSummary(
      id: '3',
      title: 'Fitness Supplement Campaign',
      advertiser: 'GlowFit Life',
      status: 'Closed',
      budget: '\$800',
      applicants: 9,
    ),
  ];

  static void deactivateCampaign(String id) {
    final idx = campaigns.indexWhere((c) => c.id == id);
    if (idx != -1) {
      campaigns[idx].status = 'Closed';
    }
  }

  static final List<AdminUser> users = [
    AdminUser(
      name: 'Sarah Jenkins',
      username: '@sarahj_style',
      role: 'Influencer',
      isActive: true,
    ),
    AdminUser(
      name: 'Alex Rivera',
      username: '@alex_tech',
      role: 'Influencer',
      isActive: true,
    ),
    AdminUser(
      name: 'Nova Media Group',
      username: '@novamedia',
      role: 'Advertiser',
      isActive: true,
    ),
  ];

  static final List<AdminReport> reports = [
    AdminReport(
      id: '101',
      status: 'Pending',
      reporterName: 'John Doe',
      reportedUser: '@fake_brand_co',
      reason: 'Spam / scam campaign posting',
    ),
  ];

  static final List<AdminContactMessage> contactMessages = [
    AdminContactMessage(
      subject: 'Payment verification inquiry',
      status: 'Open',
      senderName: 'Sarah Jenkins',
      senderRole: 'Influencer',
      category: 'Billing',
      message: 'Hello, when will the payment for the last completed campaign be disbursed to my wallet?',
    ),
  ];
}
