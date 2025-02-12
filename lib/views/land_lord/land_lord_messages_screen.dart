import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../models/message.dart';
import '../../core/constants/color_constants.dart';

class LandlordMessagesScreen extends StatelessWidget {
  const LandlordMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final landlordMessages = Message.dummyMessages.where(
      (m) => m.senderId == '2' || m.receiverId == '2'
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: landlordMessages.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: landlordMessages.length,
              itemBuilder: (context, index) {
                final message = landlordMessages[index];
                return _MessageCard(
                  message: message,
                  isLandlord: true,
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
            Icons.message_outlined,
            size: 64.sp,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 16.h),
          Text(
            'No messages yet',
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

class _MessageCard extends StatelessWidget {
  final Message message;
  final bool isLandlord;

  const _MessageCard({
    required this.message,
    required this.isLandlord,
  });

  @override
  Widget build(BuildContext context) {
    final otherPartyName = isLandlord 
        ? (message.senderId == '2' ? message.receiverName : message.senderName)
        : (message.senderId == '2' ? message.senderName : message.receiverName);

    return ListTile(
      contentPadding: EdgeInsets.all(16.w),
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(0.1),
        child: Text(
          otherPartyName[0].toUpperCase(),
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: Text(otherPartyName),
      subtitle: Text(message.content),
      trailing: !message.isRead && message.receiverId == '2'
          ? Container(
              padding: EdgeInsets.all(8.w),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                'New',
                style: TextStyle(
                  color: AppColors.surface,
                  fontSize: 12.sp,
                ),
              ),
            )
          : null,
      onTap: () => context.push('/landlord/messages/chat', extra: message),
    );
  }
}
