import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/common_widgets/back_button.dart';
import 'package:bachaoo/common_widgets/custom_text_feild.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );
      Navigator.pop(context);
    }
  }

  // Reusable Text Form Field
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required String labelText,
    String? Function(String?)? validator,
  }) {
    return CustomTextFormField(
      controller: controller,
      isPassword: true,
      label: labelText,
      hintText: hintText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.headlineSmall('Change Password'),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(width: 26, height: 26, child: CustomBackButton()),
        ),
        backgroundColor: AppColors.appBackroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Your Password
                _buildPasswordField(
                  controller: _currentPassController,
                  labelText: ' Current Password',
                  hintText: 'Enter your current password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // 2. New Password
                _buildPasswordField(
                  controller: _newPassController,
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // 3. Confirm New Password
                _buildPasswordField(
                  controller: _confirmPassController,
                  labelText: 'Confirm New Password',
                  hintText: 'Confirm your new password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your new password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    } else if (value != _newPassController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // Submit Button
                // SizedBox(
                //   height: 55,
                //   child: ElevatedButton(
                //     onPressed: _submit,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //     ),
                //     child: const Text(
                //       'Update Password',
                //       style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
