import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/color_constants.dart';
import 'option_item.dart';

class CardOptionsBottomSheet extends StatelessWidget {
  final String cardType;
  final String lastDigits;
  final bool isDefault;
  final Function(BuildContext, String, String) onDeleteCard;

  const CardOptionsBottomSheet({
    super.key,
    required this.cardType,
    required this.lastDigits,
    required this.isDefault,
    required this.onDeleteCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: 16.h,
        bottom: MediaQuery.of(context).padding.bottom + 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Card info header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.credit_card,
                    color: AppColors.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$cardType •••• $lastDigits',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (isDefault)
                      Container(
                        margin: EdgeInsets.only(top: 4.h),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'Default',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),
          Divider(height: 1, thickness: 1, color: Colors.grey.withOpacity(0.1)),

          // Options
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                if (!isDefault)
                  OptionItem(
                    icon: Icons.check_circle_outline,
                    title: 'Set as Default',
                    subtitle: 'Use this card for all payments',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '$cardType •••• $lastDigits set as default payment method'),
                          backgroundColor: AppColors.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    },
                  ),
                OptionItem(
                  icon: Icons.edit_outlined,
                  title: 'Edit Card',
                  subtitle: 'Update card information',
                  onTap: () {
                    Navigator.pop(context);
                    final isLandlord = context.canPop() &&
                        GoRouterState.of(context)
                            .uri
                            .toString()
                            .contains('/landlord');

                    context.push(
                      isLandlord
                          ? '/landlord/profile/payment-methods/edit'
                          : '/profile/payment-methods/edit',
                      extra: {
                        'cardType': cardType,
                        'lastDigits': lastDigits,
                      },
                    );
                  },
                ),
                Divider(
                    height: 1,
                    indent: 56.w,
                    endIndent: 24.w,
                    color: Colors.grey.withOpacity(0.1)),
                OptionItem(
                  icon: Icons.delete_outline,
                  title: 'Remove Card',
                  subtitle: 'Delete this payment method',
                  onTap: () {
                    Navigator.pop(context);
                    onDeleteCard(context, cardType, lastDigits);
                  },
                  isDestructive: true,
                ),
              ],
            ),
          ),

          // Cancel button
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 8.h),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.withOpacity(0.1),
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showCardOptions({
  required BuildContext context,
  required String cardType,
  required String lastDigits,
  required bool isDefault,
  required Function(BuildContext, String, String) onDeleteCard,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CardOptionsBottomSheet(
      cardType: cardType,
      lastDigits: lastDigits,
      isDefault: isDefault,
      onDeleteCard: onDeleteCard,
    ),
  );
}