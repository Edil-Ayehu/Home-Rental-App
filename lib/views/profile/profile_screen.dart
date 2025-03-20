import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/views/profile/widgets/profile_app_bar.dart';
import 'package:home_rental_app/views/profile/widgets/profile_card.dart';
import 'package:home_rental_app/views/profile/widgets/profile_menu_item.dart';
import '../../core/constants/color_constants.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/logout_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          const ProfileAppBar(
            name: 'John Doe',
            email: 'john.doe@example.com',
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                 ProfileCard(
                    title: 'Account',
                    items: [
                      ProfileMenuItem(
                        icon: Icons.person_outline,
                        title: 'Personal Information',
                        onTap: () =>
                            context.push('/profile/personal-information'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.payment_outlined,
                        title: 'Payment Methods',
                        onTap: () => context.push('/profile/payment-methods'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        onTap: () => context.push('/notifications'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ProfileCard(
                    title: 'Support',
                    items: [
                      ProfileMenuItem(
                        icon: Icons.help_outline,
                        title: 'Help Center',
                        onTap: () => context.push('/profile/help-center'),
                      ),
                      ProfileMenuItem(
                        icon: Icons.policy_outlined,
                        title: 'Privacy Policy',
                        onTap: () => context.push('/profile/privacy-policy'),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  CustomButton(
                    text: 'Log Out',
                    onPressed: () => showLogoutDialog(context),
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    height: 56.h,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
