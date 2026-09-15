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
    required String labelText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: AppColors.primaryColor),
      cursorColor: AppColors.primaryColor, // Primary text color
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ), // Primary focus border
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
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
                  labelText: 'Your Password',
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
