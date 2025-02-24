import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/color_constants.dart';

class GuestCounter extends StatelessWidget {
  final int numberOfGuests;
  final ValueChanged<int> onChanged;
  final int minGuests;
  final int maxGuests;

  const GuestCounter({
    super.key,
    required this.numberOfGuests,
    required this.onChanged,
    this.minGuests = 1,
    this.maxGuests = 10,
  });

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Number of Guests',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: numberOfGuests > minGuests
                    ? () => onChanged(numberOfGuests - 1)
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: numberOfGuests > minGuests 
                    ? AppColors.primary 
                    : AppColors.textSecondary,
              ),
              Text(
                numberOfGuests.toString(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                onPressed: numberOfGuests < maxGuests
                    ? () => onChanged(numberOfGuests + 1)
                    : null,
                icon: const Icon(Icons.add_circle_outline),
                color: numberOfGuests < maxGuests 
                    ? AppColors.primary 
                    : AppColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
