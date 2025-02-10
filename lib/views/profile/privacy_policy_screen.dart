import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 16.sp,
              color: AppColors.textPrimary,
            ),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLastUpdated(),
              SizedBox(height: 24.h),
              _buildSection(
                'Introduction',
                'Welcome to our Privacy Policy. This document explains how we collect, use, and protect your personal information when you use our services.',
              ),
              _buildSection(
                'Information We Collect',
                'We collect information that you provide directly to us, including but not limited to:\n\n'
                '• Personal identification information\n'
                '• Contact information\n'
                '• Payment details\n'
                '• Usage data and preferences',
              ),
              _buildSection(
                'How We Use Your Information',
                'We use the collected information to:\n\n'
                '• Provide and maintain our services\n'
                '• Process your transactions\n'
                '• Send you important updates\n'
                '• Improve our services\n'
                '• Comply with legal obligations',
              ),
              _buildSection(
                'Data Security',
                'We implement appropriate security measures to protect your personal information from unauthorized access, alteration, or disclosure.',
              ),
              _buildSection(
                'Your Rights',
                'You have the right to:\n\n'
                '• Access your personal data\n'
                '• Request corrections\n'
                '• Delete your account\n'
                '• Opt-out of marketing communications',
              ),
              SizedBox(height: 24.h),
              _buildContactInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastUpdated() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.access_time,
            size: 20.sp,
            color: AppColors.primary,
          ),
          SizedBox(width: 8.w),
          Text(
            'Last Updated: March 15, 2024',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Questions or Concerns?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'If you have any questions about our Privacy Policy, please contact us:',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 16.h),
          _buildContactItem(Icons.email_outlined, 'privacy@example.com'),
          SizedBox(height: 8.h),
          _buildContactItem(Icons.phone_outlined, '+1 (555) 123-4567'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: AppColors.primary,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
