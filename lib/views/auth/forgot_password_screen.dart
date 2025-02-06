import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  iconSize: 36.sp,
                ),
                SizedBox(height: 40.h),
                Center(
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Icons.lock_reset_rounded,
                      size: 40.w,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Enter your email address to reset your password',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 40.h),
                _buildTextField(
                  label: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 40.h),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle password reset
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: AppColors.surface,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remember your password? ',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/auth'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData prefixIcon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14.sp,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.textSecondary,
          size: 20.sp,
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        // Add email validation
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }
}
