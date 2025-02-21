import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_rental_app/core/constants/color_constants.dart';

class PropertyFeatures extends StatelessWidget {
  final String propertyType;

  const PropertyFeatures({
    super.key,
    required this.propertyType,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFeatureItem(Icons.home_outlined, propertyType),
          SizedBox(width: 12.w),
          _buildFeatureItem(Icons.king_bed_outlined, '3 Beds'),
          SizedBox(width: 12.w),
          _buildFeatureItem(Icons.bathtub_outlined, '2 Baths'),
          SizedBox(width: 12.w),
          _buildFeatureItem(Icons.square_foot, '1,200 ft²'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
