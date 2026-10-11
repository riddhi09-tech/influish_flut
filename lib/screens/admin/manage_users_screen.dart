import 'package:flutter/material.dart';

import '../../models/admin_store.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedRole = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<AdminUser> get _filteredUsers {
    final query = _searchController.text.trim().toLowerCase();
    return AdminStore.users.where((user) {
      final matchesRole = _selectedRole == 'All' || user.role == _selectedRole;
      final haystack = '${user.name} ${user.username}'.toLowerCase();
      final matchesQuery = query.isEmpty || haystack.contains(query);
      return matchesRole && matchesQuery;
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
                'Users',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Manage Influencers and Advertisers.',
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
                    hintText: 'Search users...',
                    prefixIcon: Icon(Icons.search, color: Color(0xFF8B5CF6)),
                    hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Influencer', 'Advertiser'].map((role) {
                    final selected = _selectedRole == role;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(role),
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
                          setState(() => _selectedRole = role);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  itemCount: _filteredUsers.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final user = _filteredUsers[index];
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xFFE9D5FF),
                            child: Text(
                              user.initials,
                              style: const TextStyle(
                                color: Color(0xFF7C3AED),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.username,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEDE9FE),
                                        borderRadius: BorderRadius.circular(
                                          999,
                                        ),
                                      ),
                                      child: Text(
                                        user.role,
                                        style: const TextStyle(
                                          color: Color(0xFF7C3AED),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      user.isActive ? 'Active' : 'Inactive',
                                      style: TextStyle(
                                        color: user.isActive
                                            ? const Color(0xFF15803D)
                                            : const Color(0xFFB91C1C),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Viewing ${user.name}')),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF8B5CF6),
                            ),
                            child: const Text('View'),
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
