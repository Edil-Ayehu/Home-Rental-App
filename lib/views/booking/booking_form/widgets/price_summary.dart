import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/color_constants.dart';

class PriceSummary extends StatelessWidget {
  final double pricePerNight;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final double totalPrice;

  const PriceSummary({
    super.key,
    required this.pricePerNight,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
  });

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.w600,
            color: isTotal ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildPriceRow(
            'Price per night',
            '\$${pricePerNight.toStringAsFixed(2)}',
          ),
          if (checkInDate != null && checkOutDate != null) ...[
            SizedBox(height: 12.h),
            _buildPriceRow(
              'Number of nights',
              checkOutDate!.difference(checkInDate!).inDays.toString(),
            ),
            SizedBox(height: 16.h),
            Divider(height: 1, color: AppColors.primary.withOpacity(0.1)),
            SizedBox(height: 16.h),
            _buildPriceRow(
              'Total',
              '\$${totalPrice.toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ],
      ),
    );
  }
}
