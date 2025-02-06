import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/models/booking_model.dart';
import 'package:home_rental_app/models/message.dart';
import 'package:home_rental_app/models/property_model.dart';
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
      _NotificationItem(
        id: '1',
        icon: Icons.home_rounded,
        title: 'New Property Available',
        description: 'A new property matching your preferences is available.',
        time: '2 hours ago',
        isUnread: true,
        data: Property.dummyProperties[0], // Add relevant property data
      ),
      _NotificationItem(
        id: '2',
        title: 'Booking Confirmed',
        icon: Icons.check_circle_rounded,
        description: 'Your booking for Luxury Apartment has been confirmed.',
        time: '5 hours ago',
        isUnread: true,
        data: Booking.dummyBookings[0], // Add relevant booking data
      ),
      _NotificationItem(
        id: '3',
        icon: Icons.message_rounded,
        title: 'New Message',
        description: 'You have a new message from property owner.',
        time: '1 day ago',
        isUnread: false,
        data: Message.dummyMessages[0], // Add message data
      ),
      _NotificationItem(
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
              return _NotificationCard(notification: notifications[index]);
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

class _NotificationCard extends StatelessWidget {
  final _NotificationItem notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _handleNotificationTap(context),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: notification.isUnread
              ? AppColors.primary.withOpacity(0.05)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: notification.isUnread
              ? Border.all(color: AppColors.primary.withOpacity(0.1))
              : null,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(16.w),
          leading: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              notification.icon,
              color: AppColors.primary,
              size: 24.sp,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (notification.isUnread)
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                notification.description,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                notification.time,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNotificationTap(BuildContext context) {
    switch (notification.icon) {
      case Icons.home_rounded:
        // Navigate to property details
        context.push('/home/property/${notification.id}', extra: notification.data);
        break;
      case Icons.check_circle_rounded:
        // Navigate to booking details
        context.push('/bookings');
        break;
      case Icons.message_rounded:
        // Navigate to chat
        if (notification.data != null) {
          context.push('/messages/chat', extra: notification.data);
        }
        break;
      case Icons.local_offer_rounded:
        // Navigate to property details with the special offer
        if (notification.data != null) {
          context.push('/home/property/${notification.id}', extra: notification.data);
        }
        break;
      default:
        // Handle unknown notification types
        break;
    }
  }
}

class _NotificationItem {
  final String id;
  final IconData icon;
  final String title;
  final String description;
  final String time;
  final bool isUnread;
  final dynamic data; // This can hold related data like Property or Message objects

  _NotificationItem({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    required this.isUnread,
    this.data,
  });
}
