```dart
import 'package:flutter/material.dart';

import '../auth/signup_screen.dart';

class InfluencerProfileSetupScreen extends StatefulWidget {
  const InfluencerProfileSetupScreen({super.key});

  @override
  State<InfluencerProfileSetupScreen> createState() =>
      _InfluencerProfileSetupScreenState();
}

class _InfluencerProfileSetupScreenState
    extends State<InfluencerProfileSetupScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(text: 'Mer Nensi');
  final instagramController = TextEditingController(text: '@mernensi');
  final followersController = TextEditingController(text: '12,500');
  final ageController = TextEditingController(text: '21');
  final bioController =
      TextEditingController(text: 'Fashion and lifestyle creator.');

  String category = 'Fashion';

  @override
  void dispose() {
    nameController.dispose();
    instagramController.dispose();
    followersController.dispose();
    ageController.dispose();
    bioController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
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
        borderSide: const BorderSide(color: purple),
      ),
    );
  }

  Widget labeledField(
    String label,
    TextEditingController controller, {
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: const TextStyle(fontSize: 12),
          decoration: inputDecoration(hint ?? ''),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 380),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Complete your profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF182230),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Center(
                      child: Text(
                        'Add a few details so brands can know you\nbetter.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF667085),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Center(
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: purple,
                        child: Text(
                          'MN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Add image-picker functionality to upload a photo.',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Upload Photo',
                          style: TextStyle(
                            fontSize: 11,
                            color: purple,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    labeledField(
                      'Full Name',
                      nameController,
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Enter your name'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    labeledField(
                      'Instagram Link *',
                      instagramController,
                      hint: '@username',
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Enter your Instagram username'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: labeledField(
                            'Followers',
                            followersController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: labeledField(
                            'Age',
                            ageController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Category',
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 5),
                    DropdownButtonFormField<String>(
                      value: category,
                      decoration: inputDecoration(''),
                      style: const TextStyle(
                        fontSize: 12,
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
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => category = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    labeledField(
                      'Bio',
                      bioController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: purple,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile details are ready.'),
                            ),
                          );
                        },
                        child: const Text(
                          'Complete Profile',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```