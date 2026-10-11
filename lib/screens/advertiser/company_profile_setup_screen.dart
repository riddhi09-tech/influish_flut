import 'package:flutter/material.dart';

import 'advertiser_home_screen.dart';

class CompanyProfileSetupScreen extends StatefulWidget {
  final bool isEditMode;

  const CompanyProfileSetupScreen({super.key, this.isEditMode = false});

  @override
  State<CompanyProfileSetupScreen> createState() =>
      _CompanyProfileSetupScreenState();
}

class _CompanyProfileSetupScreenState extends State<CompanyProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _selectedIndustry;

  final List<String> _industries = [
    'Fashion',
    'Beauty',
    'Fitness',
    'Lifestyle',
    'Technology',
    'Food',
  ];

  @override
  void initState() {
    super.initState();
    _companyNameController.text = advertiserCompanyName;
    _websiteController.text = 'https://glowandco.com';
    _instagramController.text = '@glowandco';
    _descriptionController.text =
        'Premium lifestyle brand for beauty and wellness campaigns.';
    _contactNameController.text = 'Nisha Kapoor';
    _mobileController.text = '+91 98765 43210';
    _emailController.text = 'hello@glowandco.com';
    _selectedIndustry = 'Fashion';
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _websiteController.dispose();
    _instagramController.dispose();
    _descriptionController.dispose();
    _contactNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Influish',
          style: TextStyle(
            color: Color(0xFF7C3AED),
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9D5FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.business,
                      size: 42,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Image upload is not connected in this demo.',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload Image'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C3AED),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Company Name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _companyNameController,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter a company name'
                      : null,
                  decoration: _inputDecoration('Enter your company name'),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Industry',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedIndustry,
                  decoration: _inputDecoration('Select industry'),
                  items: _industries
                      .map(
                        (industry) => DropdownMenuItem<String>(
                          value: industry,
                          child: Text(industry),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedIndustry = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please choose an industry' : null,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Website',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _websiteController,
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the website';
                    }
                    return null;
                  },
                  decoration: _inputDecoration('https://example.com'),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Instagram Link',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _instagramController,
                  decoration: _inputDecoration('@yourbrand'),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Company Description',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  validator: (value) =>
                      value == null || value.trim().length < 20
                      ? 'Please add a short company description'
                      : null,
                  decoration: _inputDecoration(
                    'Tell creators about your brand and goals',
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Primary Contact',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Contact Person Name',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _contactNameController,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Please enter the contact person name'
                      : null,
                  decoration: _inputDecoration('Enter name'),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Mobile Number',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value == null || value.trim().length < 10
                      ? 'Please enter a valid mobile number'
                      : null,
                  decoration: _inputDecoration('Enter mobile number'),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: _inputDecoration('Enter email address'),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        advertiserCompanyName = _companyNameController.text
                            .trim();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Company profile saved successfully.',
                            ),
                          ),
                        );

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const AdvertiserHomeScreen(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C3AED),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
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
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF7C3AED)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}
