import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/models/booking_model.dart';
import 'package:home_rental_app/models/message.dart';
import 'package:home_rental_app/models/notification_item.dart';
import 'package:home_rental_app/models/property_model.dart';
import 'package:home_rental_app/views/notifications/widgets/notification_card.dart';
import '../../core/constants/color_constants.dart';
import '../../widgets/common/page_layout.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Notifications',
      body: _buildNotificationsList(),
    );
  }

  Widget _buildNotificationsList() {
    // Dummy notifications data
    final notifications = [
      NotificationItem(
        id: '1',
        icon: Icons.home_rounded,
        title: 'New Property Available',
        description: 'A new property matching your preferences is available.',
        time: '2 hours ago',
        isUnread: true,
        data: Property.dummyProperties[0], // Add relevant property data
      ),
      NotificationItem(
        id: '2',
        title: 'Booking Confirmed',
        icon: Icons.check_circle_rounded,
        description: 'Your booking for Luxury Apartment has been confirmed.',
        time: '5 hours ago',
        isUnread: true,
        data: Booking.dummyBookings[0], // Add relevant booking data
      ),
      NotificationItem(
        id: '3',
        icon: Icons.message_rounded,
        title: 'New Message',
        description: 'You have a new message from property owner.',
        time: '1 day ago',
        isUnread: false,
        data: Message.dummyMessages[0], // Add message data
      ),
      NotificationItem(
        id: '4',
        icon: Icons.local_offer_rounded,
        title: 'Special Offer',
        description: '20% off on your next booking! Limited time offer.',
        time: '2 days ago',
        isUnread: false,
        data: Property.dummyProperties[0], // Add property data for the offer
      ),
    ];

    return notifications.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationCard(notification: notifications[index]);
            },
          );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 64.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 16.h),
          Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You\'ll be notified about updates here',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
