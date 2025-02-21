import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_rental_app/core/services/storage_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/color_constants.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    {

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

void _navigateToNextScreen() async {
  try {
    // Wait for animations to complete
    // Add delay after animation
    await Future.delayed(AppConstants.splashDuration);
    
    if (!mounted) return;

    final isFirstTime = await StorageService.isFirstTimeUser();
    if (!mounted) return;

    if (isFirstTime) {
      await StorageService.setFirstTimeUser(false);
      if (!mounted) return;
      if (context.mounted) {
        context.pushReplacement('/onboarding');
      }
    } else {
      if (context.mounted) {
        context.pushReplacement('/auth');
      }
    }
  } catch (e) {
    debugPrint('Navigation error: $e');
    if (mounted) {
      context.pushReplacement('/onboarding');
    }
  }
}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo container
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1500),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.home_rounded,
                      size: 72.w,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
            
            SizedBox(height: 32.h),
            
            // Animated text
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1500),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Column(
                children: [
                  Text(
                    'HomeRental',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Find Your Dream Home',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 48.h),
            
            // Loading indicator
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1500),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: SizedBox(
                    width: 40.w,
                    height: 40.w,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      strokeWidth: 3,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
