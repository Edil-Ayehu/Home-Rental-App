import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/views/payment_method/widgets/card_options_bottom_sheet.dart';
import 'package:home_rental_app/views/payment_method/widgets/delete_confirmation_dialog.dart';
import 'package:home_rental_app/views/payment_method/widgets/payment_method_card.dart';
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
              PaymentMethodCard(
                icon: Icons.credit_card,
                cardType: 'Visa',
                lastDigits: '4567',
                expiryDate: '12/24',
                isDefault: true,
                onOptionsPressed: () {
                  showCardOptions(
                    context: context,
                    cardType: 'Visa',
                    lastDigits: '4567',
                    isDefault: true,
                    onDeleteCard: (context, cardType, lastDigits) {
                      showDeleteConfirmation(
                        context: context,
                        cardType: cardType,
                        lastDigits: lastDigits,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 16.h),
              PaymentMethodCard(
                icon: Icons.credit_card,
                cardType: 'Mastercard',
                lastDigits: '8901',
                expiryDate: '09/25',
                onOptionsPressed: () {
                  showCardOptions(
                    context: context,
                    cardType: 'Mastercard',
                    lastDigits: '8901',
                    isDefault: false,
                    onDeleteCard: (context, cardType, lastDigits) {
                      showDeleteConfirmation(
                        context: context,
                        cardType: cardType,
                        lastDigits: lastDigits,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: () {
                  final isLandlord = context.canPop() &&
                      GoRouterState.of(context)
                          .uri
                          .toString()
                          .contains('/landlord');

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
}
