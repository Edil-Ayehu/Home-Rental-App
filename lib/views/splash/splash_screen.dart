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
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppConstants.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    _navigateToNextScreen();
  }

void _navigateToNextScreen() async {
  try {
    // Wait for animations to complete
    await _controller.forward();
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.8),
                  AppColors.accent.withOpacity(0.3),
                ],
              ),
            ),
          ),
          // Circular decoration elements
          Positioned(
            top: -100.r,
            right: -100.r,
            child: Container(
              width: 200.r,
              height: 200.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -50.r,
            left: -50.r,
            child: Container(
              width: 150.r,
              height: 150.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface.withOpacity(0.1),
              ),
            ),
          ),
          // Main content
          SafeArea(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(35.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.home_rounded,
                                    size: 70.w,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Positioned(
                                  right: 15.r,
                                  top: 15.r,
                                  child: Container(
                                    width: 12.r,
                                    height: 12.r,
                                    decoration: BoxDecoration(
                                      color: AppColors.accent,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'HomeRental',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      color: AppColors.surface,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                              ),
                              SizedBox(height: 12.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surface.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  'Find Your Dream Home',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppColors.surface,
                                        letterSpacing: 0.5,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
