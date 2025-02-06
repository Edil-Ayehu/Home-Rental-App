import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/constants/color_constants.dart';
import '../../models/booking_model.dart';
import '../../widgets/common/page_layout.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<BookingStatus> _tabs = [
    BookingStatus.upcoming,
    BookingStatus.ongoing,
    BookingStatus.completed,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'My Bookings',
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: _tabs.map((status) => Tab(
              text: status.name[0].toUpperCase() + status.name.substring(1),
            )).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((status) => _BookingsList(status: status)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingsList extends StatelessWidget {
  final BookingStatus status;

  const _BookingsList({required this.status});

  @override
  Widget build(BuildContext context) {
    final bookings = Booking.dummyBookings.where((booking) => booking.status == status).toList();

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64.sp,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16.h),
            Text(
              'No ${status.name} bookings',
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

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return GestureDetector(
          onTap: () => context.push(
            '/home/property/${booking.property.id}',
            extra: booking.property,
          ),
          child: Container(
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
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.asset(
                    booking.property.imageUrl,
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.property.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        Icons.location_on_outlined,
                        'Location',
                        booking.property.location,
                      ),
                      SizedBox(height: 16.h),
                      _buildInfoRow(
                        Icons.calendar_today_outlined,
                        'Check-in',
                        DateFormat('MMM dd, yyyy').format(booking.checkIn),
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        Icons.calendar_today_outlined,
                        'Check-out',
                        DateFormat('MMM dd, yyyy').format(booking.checkOut),
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        Icons.attach_money,
                        'Total Price',
                        '\$${booking.totalPrice.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.textSecondary,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
