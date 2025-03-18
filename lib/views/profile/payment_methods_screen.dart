import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

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
        centerTitle: false,
        title: Text(
          'Payment Methods',
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
              Text(
                'Your Payment Methods',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Manage your saved payment methods',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              _buildPaymentMethodCard(
                context: context,
                icon: Icons.credit_card,
                cardType: 'Visa',
                lastDigits: '4567',
                expiryDate: '12/24',
                isDefault: true,
              ),
              SizedBox(height: 16.h),
              _buildPaymentMethodCard(
                context: context,
                icon: Icons.credit_card,
                cardType: 'Mastercard',
                lastDigits: '8901',
                expiryDate: '09/25',
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: () {
                  final isLandlord = context.canPop() && 
                      GoRouterState.of(context).uri.toString().contains('/landlord');
                  
                  context.push(isLandlord 
                      ? '/landlord/profile/payment-methods/add'
                      : '/profile/payment-methods/add');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 2,
                  shadowColor: AppColors.primary.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: AppColors.surface,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Add New Card',
                      style: TextStyle(
                        color: AppColors.surface,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required BuildContext context,
    required IconData icon,
    required String cardType,
    required String lastDigits,
    required String expiryDate,
    bool isDefault = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$cardType •••• $lastDigits',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (isDefault) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
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
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Expires $expiryDate',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            onPressed: () {
              _showCardOptions(context, cardType, lastDigits, isDefault);
            },
          ),
        ],
      ),
    );
  }

void _showCardOptions(BuildContext context, String cardType, String lastDigits, bool isDefault) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) => Container(
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
                  _buildOptionItem(
                    context,
                    icon: Icons.check_circle_outline,
                    title: 'Set as Default',
                    subtitle: 'Use this card for all payments',
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$cardType •••• $lastDigits set as default payment method'),
                          backgroundColor: AppColors.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          margin: EdgeInsets.all(16),
                        ),
                      );
                    },
                  ),
                _buildOptionItem(
                  context,
                  icon: Icons.edit_outlined,
                  title: 'Edit Card',
                  subtitle: 'Update card information',
                  onTap: () {
                    Navigator.pop(context);
                    final isLandlord = context.canPop() && 
                        GoRouterState.of(context).uri.toString().contains('/landlord');
                    
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
                Divider(height: 1, indent: 56.w, endIndent: 24.w, color: Colors.grey.withOpacity(0.1)),
                _buildOptionItem(
                  context,
                  icon: Icons.delete_outline,
                  title: 'Remove Card',
                  subtitle: 'Delete this payment method',
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteConfirmation(context, cardType, lastDigits);
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
    ),
  );
}

Widget _buildOptionItem(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  bool isDestructive = false,
  bool isDisabled = false,
}) {
  final Color textColor = isDestructive
      ? AppColors.error
      : isDisabled
          ? AppColors.textSecondary
          : AppColors.textPrimary;

  return InkWell(
    onTap: isDisabled ? null : onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isDestructive
                  ? AppColors.error.withOpacity(0.1)
                  : isDisabled
                      ? Colors.grey.withOpacity(0.1)
                      : AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: isDestructive
                  ? AppColors.error
                  : isDisabled
                      ? Colors.grey
                      : AppColors.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: isDestructive
                ? AppColors.error.withOpacity(0.5)
                : isDisabled
                    ? Colors.grey.withOpacity(0.3)
                    : AppColors.textSecondary,
            size: 20.sp,
          ),
        ],
      ),
    ),
  );
}

void _showDeleteConfirmation(BuildContext context, String cardType, String lastDigits) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Remove Card'),
      content: Text('Are you sure you want to remove $cardType •••• $lastDigits?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$cardType •••• $lastDigits has been removed'),
                backgroundColor: AppColors.error,
              ),
            );
          },
          child: Text(
            'Remove',
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
}
