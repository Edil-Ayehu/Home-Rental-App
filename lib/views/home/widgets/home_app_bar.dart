import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/core/constants/color_constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: AppColors.background,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                'San Francisco, CA',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ],
      ),
      actions: [
        CircleAvatar(
          backgroundColor: AppColors.surface,
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: AppColors.textPrimary,
            onPressed: () => context.push('/notifications'),
          ),
        ),
        SizedBox(width: 16.w),
      ],
    );
  }
}
