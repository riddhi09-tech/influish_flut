class AuthService {
  static const String _demoAdminEmail = 'arviantala18@gmail.com';
  static const String _demoAdminPassword = 'Abc@1234';
  static const String adminRole = 'ADMIN';
  static const String advertiserRole = 'ADVERTISER';
  static const String influencerRole = 'INFLUENCER';

  static String? currentRole;

  static final Map<String, String> _demoUsers = {
    'influencer@influish.com': 'demo123',
    'advertiser@influish.com': 'demo123',
    _demoAdminEmail: _demoAdminPassword,
  };

  bool isDemoAdminLogin(String email, String password) {
    return email.trim().toLowerCase() == _demoAdminEmail &&
        password == _demoAdminPassword;
  }

  bool isLocalUserLogin(String email, String password, {String? role}) {
    final normalizedEmail = email.trim().toLowerCase();
    final validPassword = _demoUsers[normalizedEmail];
    if (validPassword == null) {
      return false;
    }

    if (password != validPassword) {
      return false;
    }

    if (role == null) {
      return true;
    }

    switch (role.toUpperCase()) {
      case advertiserRole:
        return normalizedEmail == 'advertiser@influish.com';
      case influencerRole:
        return normalizedEmail == 'influencer@influish.com';
      case adminRole:
        return normalizedEmail == _demoAdminEmail;
      default:
        return true;
    }
  }

  void signOut() {
    currentRole = null;
  }

  Future<Map<String, dynamic>> login(
    String email,
    String password, {
    String? role,
  }) async {
    final normalizedEmail = email.trim();
    final isAdminLogin = isDemoAdminLogin(normalizedEmail, password);
    if (isAdminLogin) {
      currentRole = adminRole;
      return {
        'success': true,
        'role': adminRole,
        'message': 'Login successful.',
      };
    }

    final isValidLocalUser = isLocalUserLogin(
      normalizedEmail,
      password,
      role: role,
    );
    if (!isValidLocalUser) {
      throw StateError('Invalid email or password.');
    }

    currentRole =
        role ??
        (normalizedEmail == 'advertiser@influish.com'
            ? advertiserRole
            : influencerRole);
    return {
      'success': true,
      'role': currentRole,
      'message': 'Login successful.',
    };
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String role,
  ) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty || password.length < 8) {
      throw StateError('Please provide valid account details.');
    }

    _demoUsers[normalizedEmail] = password;
    currentRole = role.toUpperCase();
    return {
      'success': true,
      'role': currentRole,
      'message': 'Account created successfully.',
      'name': name,
    };
  }
}
