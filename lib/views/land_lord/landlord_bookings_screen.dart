import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/constants/color_constants.dart';
import '../../widgets/common/page_layout.dart';
import '../../controllers/booking_controller.dart';
import '../../models/booking_model.dart';

class LandlordBookingsScreen extends StatelessWidget {
  final _bookingController = BookingController();
  
  LandlordBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Bookings',
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: TabBar(
                tabs: const [
                  Tab(text: 'Active'),
                  Tab(text: 'Past'),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.textSecondary,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                splashBorderRadius: BorderRadius.circular(30.r),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildBookingsList(context,isActive: true),
                  _buildBookingsList(context,isActive: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsList(BuildContext context,{required bool isActive}) {
    // Using Jane Smith's ID (2) for demo
    final landlordId = '2';
    final allBookings = _bookingController.getBookingsByLandlordId(landlordId);
    
    // Filter bookings based on active/past status
    final bookings = allBookings.where((booking) {
      if (isActive) {
        return booking.status == BookingStatus.upcoming || 
               booking.status == BookingStatus.ongoing;
      } else {
        return booking.status == BookingStatus.completed || 
               booking.status == BookingStatus.cancelled;
      }
    }).toList();
    
    if (bookings.isEmpty) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(24.w),
          margin: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isActive ? Icons.calendar_today_outlined : Icons.history_outlined,
                  size: 40.sp,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'No ${isActive ? 'active' : 'past'} bookings',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                isActive 
                  ? 'Your upcoming and ongoing bookings will appear here'
                  : 'Your completed and cancelled bookings will appear here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              TextButton.icon(
                onPressed: () => context.push('/landlord/properties'),
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 18.sp,
                  color: AppColors.primary,
                ),
                label: Text(
                  'Add a new property',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  backgroundColor: AppColors.primary.withOpacity(0.08),
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return _BookingCard(booking: bookings[index]);
      },
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Booking booking;

  const _BookingCard({required this.booking});

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 150.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image with Shimmer
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: CachedNetworkImage(
              imageUrl: booking.property.imageUrl,
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildShimmerEffect(),
              errorWidget: (context, url, error) => Container(
                height: 150.h,
                color: Colors.grey[200],
                child: Center(
                  child: Icon(
                    Icons.image_not_supported, 
                    color: Colors.grey,
                    size: 32.sp,
                  ),
                ),
              ),
            ),
          ),
          
          // Status Chip
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusChip(booking.status),
                Text(
                  '\$${booking.totalPrice.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          
          // Property Details
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.property.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        booking.property.location,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                
                // Date Range
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.sp,
                        color: AppColors.primary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${DateFormat('MMM dd, yyyy').format(booking.checkIn)} - ${DateFormat('MMM dd, yyyy').format(booking.checkOut)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/landlord/properties/details/${booking.property.id}', 
                        extra: booking.property);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'View Property',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(BookingStatus status) {
    Color chipColor;
    switch (status) {
      case BookingStatus.upcoming:
        chipColor = Colors.green;
        break;
      case BookingStatus.ongoing:
        chipColor = Colors.orange;
        break;
      case BookingStatus.cancelled:
        chipColor = Colors.red;
        break;
      case BookingStatus.completed:
        chipColor = Colors.blue;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.name[0].toUpperCase() + status.name.substring(1),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: chipColor,
        ),
      ),
    );
  }
}
