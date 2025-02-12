import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';
import '../../models/user_model.dart';
import '../../widgets/common/page_layout.dart';

class LandlordProfileScreen extends StatelessWidget {
  const LandlordProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = User.dummyUsers.firstWhere((u) => u.id == '2');

    return PageLayout(
      title: 'Profile',
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildProfileHeader(user),
            SizedBox(height: 24.h),
            _buildMenuSection(),
            SizedBox(height: 24.h),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(User user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 48.r,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Text(
            user.fullName[0].toUpperCase(),
            style: TextStyle(
              fontSize: 32.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          user.fullName,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          user.email,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Column(
      children: [
        _MenuItem(
          icon: Icons.person_outline,
          title: 'Personal Information',
          onTap: (context) => context.push('/landlord/profile/personal-information'),
        ),
        _MenuItem(
          icon: Icons.payment_outlined,
          title: 'Payment Methods',
          onTap: (context) => context.push('/landlord/profile/payment-methods'),
        ),
        _MenuItem(
          icon: Icons.help_outline,
          title: 'Help Center',
          onTap: (context) => context.push('/landlord/profile/help-center'),
        ),
        _MenuItem(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          onTap: (context) => context.push('/landlord/profile/privacy-policy'),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.go('/auth'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
          foregroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
        child: const Text('Logout'),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function(BuildContext) onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => onTap(context),
    );
  }
}
