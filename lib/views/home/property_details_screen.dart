import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/models/property_model.dart';
import 'package:home_rental_app/widgets/common/custom_button.dart';
import 'package:home_rental_app/widgets/common/rating_dialog.dart';
import '../../core/constants/color_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final String propertyId;
  final Property property;

  const PropertyDetailsScreen({
    super.key,
    required this.propertyId,
    required this.property,
  });

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.surface.withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 18),
                  color: AppColors.textPrimary,
                  onPressed: () => context.pop(),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.surface.withOpacity(0.5),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border, size: 18),
                    color: AppColors.textPrimary,
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              IconButton(
                icon: const Icon(Icons.star_border),
                color: AppColors.textPrimary,
                onPressed: () => _showRatingDialog(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.property.images[_selectedImageIndex],
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildShimmerEffect(),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.error_outline,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: Offset(0, -20.h),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.r)),
                ),
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.property.images.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedImageIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImageIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CachedNetworkImage(
                                  imageUrl: widget.property.images[index],
                                  width: 80.w,
                                  height: 80.h,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      _buildShimmerEffect(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.error_outline,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.property.title,
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16.sp,
                                  color: AppColors.textSecondary,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  widget.property.location,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$2,500',
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            Text(
                              'per month',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    _buildFeatures(),
                    SizedBox(height: 24.h),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'This modern apartment features a spacious living area, fully equipped kitchen, and stunning city views. Perfect for professionals or small families.',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomButton(
                      text: 'Book Now',
                      onPressed: () =>
                          context.push('/home/book', extra: widget.property),
                      height: 56.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFeatureItem(Icons.king_bed_outlined, '3 Beds'),
          SizedBox(width: 12.w),
          _buildFeatureItem(Icons.bathtub_outlined, '2 Baths'),
          SizedBox(width: 12.w),
          _buildFeatureItem(Icons.square_foot, '1,200 ft²'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerEffect({double? width, double? height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        color: Colors.white,
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RatingDialog(
        onSubmit: (rating, comment) {
          // Here you would normally save the rating to your backend
          // For now, we'll just show a success message
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thank you for your rating!')),
          );
        },
      ),
    );
  }
}
