import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';
import '../../models/property_model.dart';
import '../property_detail/widgets/property_reviews.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LandlordPropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const LandlordPropertyDetailsScreen({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(
              '/landlord/properties/edit/${property.id}',
              extra: property,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageGallery(),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPropertyHeader(),
                  SizedBox(height: 24.h),
                  _buildPropertyStats(),
                  SizedBox(height: 24.h),
                  _buildPropertyDetails(),
                  SizedBox(height: 24.h),
                  _buildAmenities(),
                  SizedBox(height: 24.h),
                  PropertyReviews(
                    propertyId: property.id,
                    averageRating: property.averageRating,
                    numberOfRatings: property.numberOfRatings,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery() {
    return SizedBox(
      height: 250.h,
      child: PageView.builder(
        itemCount: property.images.length,
        itemBuilder: (context, index) {
          return CachedNetworkImage(
            imageUrl: property.images[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildPropertyHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          property.title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(Icons.location_on, size: 16.sp, color: AppColors.primary),
            SizedBox(width: 4.w),
            Text(
              property.location,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPropertyDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          property.description,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: property.amenities.map((amenity) {
            return Chip(
              label: Text(amenity),
              backgroundColor: AppColors.primary.withOpacity(0.1),
              labelStyle: TextStyle(color: AppColors.primary),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPropertyStats() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _buildStatRow('Property Type', property.type),
            _buildStatRow('Price', '\$${property.price}'),
            _buildStatRow('Average Rating', '${property.averageRating.toStringAsFixed(1)} ⭐'),
            _buildStatRow('Total Reviews', property.numberOfRatings.toString()),
            _buildStatRow('Status', property.isAvailable ? 'Available' : 'Not Available'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
