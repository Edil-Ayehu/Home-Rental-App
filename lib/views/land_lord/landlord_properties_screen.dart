import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';
import '../../controllers/property_controller.dart';
import '../../widgets/common/page_layout.dart';
import '../../widgets/property/property_card.dart';

class LandlordPropertiesScreen extends StatelessWidget {
  final _propertyController = PropertyController();

  LandlordPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final properties = _propertyController.getPropertiesByOwnerId('2');

    return PageLayout(
      title: 'My Properties',
      actions: [
        IconButton(
          onPressed: () => context.push('/landlord/properties/add'),
          icon: const Icon(Icons.add),
        ),
      ],
      body: properties.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: properties.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final property = properties[index];
                return PropertyCard(
                  property: property,
                  onTap: () => context.push(
                    '/landlord/properties/edit/${property.id}',
                    extra: property,
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.home_work_outlined,
            size: 64.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 16.h),
          Text(
            'No properties yet',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
