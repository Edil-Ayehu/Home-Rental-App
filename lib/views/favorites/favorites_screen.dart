import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';
import '../../models/property_model.dart';
import '../../widgets/property/property_card.dart';
import '../../widgets/common/page_layout.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Favorites',
      body: Property.dummyProperties.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 64.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Start saving your favorite properties',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 0.7,
              ),
              itemCount: Property.dummyProperties.length,
              itemBuilder: (context, index) {
                final property = Property.dummyProperties[index];
                return PropertyCard(
                  onTap: () => context.push(
                    '/home/property/${property.id}',
                    extra: property,
                  ),
                  property: property,
                );
              },
            ),
    );
  }
}
