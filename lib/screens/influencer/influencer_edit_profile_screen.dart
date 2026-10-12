import 'package:flutter/material.dart';

class InfluencerEditProfileScreen extends StatefulWidget {
  final String name;
  final String instagram;
  final String followers;
  final String age;
  final String category;
  final String bio;

  const InfluencerEditProfileScreen({
    super.key,
    this.name = 'arvi antala',
    this.instagram = '@arviantala',
    this.followers = '251K',
    this.age = '20',
    this.category = 'Fashion',
    this.bio =
        'Fashion is designed to be a good quality and dear quality of living.',
  });

  @override
  State<InfluencerEditProfileScreen> createState() =>
      _InfluencerEditProfileScreenState();
}

class _InfluencerEditProfileScreenState
    extends State<InfluencerEditProfileScreen> {
  static const Color primaryPurple = Color(0xFF7C3AED);
  static const Color background = Color(0xFFF8F9FB);
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color labelColor = Color(0xFF344054);

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _instagramController;
  late TextEditingController _followersController;
  late TextEditingController _ageController;
  late TextEditingController _bioController;

  late String _category;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _instagramController = TextEditingController(text: widget.instagram);
    _followersController = TextEditingController(text: widget.followers);
    _ageController = TextEditingController(text: widget.age);
    _bioController = TextEditingController(text: widget.bio);
    _category = widget.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _instagramController.dispose();
    _followersController.dispose();
    _ageController.dispose();
    _bioController.dispose();
    super.dispose();
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
          'Complete your profile',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF182230),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
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
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: borderColor),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 14,
                              color: primaryPurple,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildField('Full Name', _nameController),
                  const SizedBox(height: 12),
                  _buildField('Instagram Link', _instagramController),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildField('Followers', _followersController),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildField('Age', _ageController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: labelColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 11,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: primaryPurple,
                          width: 1.2,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF182230),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Fashion',
                        child: Text('Fashion'),
                      ),
                      DropdownMenuItem(
                        value: 'Beauty',
                        child: Text('Beauty'),
                      ),
                      DropdownMenuItem(
                        value: 'Technology',
                        child: Text('Technology'),
                      ),
                      DropdownMenuItem(
                        value: 'Travel',
                        child: Text('Travel'),
                      ),
                      DropdownMenuItem(
                        value: 'Food',
                        child: Text('Food'),
                      ),
                      DropdownMenuItem(
                        value: 'Fitness',
                        child: Text('Fitness'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _category = val);
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  _buildField('Bio', _bioController, maxLines: 3),
                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPurple,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;
                        Navigator.pop(context, {
                          'name': _nameController.text,
                          'instagram': _instagramController.text,
                          'followers': _followersController.text,
                          'age': _ageController.text,
                          'category': _category,
                          'bio': _bioController.text,
                        });
                      },
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
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

  Widget _buildField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 12.5),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: primaryPurple,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
