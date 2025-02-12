import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';
import '../../widgets/common/page_layout.dart';
import '../../controllers/property_controller.dart';
import '../../widgets/property/property_card.dart';

class LandlordDashboardScreen extends StatelessWidget {
  final _propertyController = PropertyController();
  
  LandlordDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Dashboard',
      actions: [
        IconButton(
          onPressed: () => context.push('/landlord/messages'),
          icon: const Icon(Icons.message_outlined),
        ),
        IconButton(
          onPressed: () => context.push('/landlord/add-property'),
          icon: const Icon(Icons.add),
        ),
      ],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCards(),
            SizedBox(height: 24.h),
            _buildRecentBookings(),
            SizedBox(height: 24.h),
            _buildMyProperties(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards() {
    return Row(
      children: [
        _StatCard(
          icon: Icons.home_rounded,
          title: 'Properties',
          value: '5',
          color: AppColors.primary,
        ),
        SizedBox(width: 16.w),
        _StatCard(
          icon: Icons.book_rounded,
          title: 'Bookings',
          value: '12',
          color: Colors.green,
        ),
        SizedBox(width: 16.w),
        _StatCard(
          icon: Icons.star_rounded,
          title: 'Rating',
          value: '4.8',
          color: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildRecentBookings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Bookings',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        // List of recent bookings
      ],
    );
  }

  Widget _buildMyProperties(BuildContext context) {
    // Using Jane Smith's ID (2) for demo
    final properties = _propertyController.getPropertiesByOwnerId('2');
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Properties',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () => context.push('/landlord/add-property'),
              child: Text(
                'Add New',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: properties.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final property = properties[index];
            return PropertyCard(
              property: property,
              onTap: () => context.push(
                '/landlord/edit-property/${property.id}',
                extra: property,
              ),
            );
          },
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
