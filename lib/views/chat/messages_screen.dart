import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../models/message.dart';
import '../../core/constants/color_constants.dart';
import '../../widgets/common/page_layout.dart';

class MessagesScreen extends StatelessWidget {
  final bool isLandlord;
  final String userId;
  
  const MessagesScreen({
    super.key,
    required this.isLandlord,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final userMessages = Message.dummyMessages.where(
      (m) => m.senderId == userId || m.receiverId == userId
    ).toList();

    return PageLayout(
      title: 'Messages',
      body: Container(
        color: AppColors.surface,
        child: userMessages.isEmpty
            ? _buildEmptyState(isLandlord)
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'Recent Messages',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final message = userMessages[index];
                        return _MessageCard(
                          message: message,
                          isLandlord: isLandlord,
                          userId: userId,
                        );
                      },
                      childCount: userMessages.length,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyState(bool isLandlord) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.message_outlined,
                size: 48.sp,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Messages Yet',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            if (!isLandlord) ...[
              SizedBox(height: 12.h),
              Text(
                'Start chatting with property owners',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final Message message;
  final bool isLandlord;
  final String userId;

  const _MessageCard({
    required this.message,
    required this.isLandlord,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final otherPartyName = message.senderId == userId 
        ? message.receiverName 
        : message.senderName;
    final isUnread = !message.isRead && message.receiverId == userId;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: isUnread 
              ? AppColors.primary.withOpacity(0.3)
              : Colors.transparent,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () => context.push(
          isLandlord ? '/landlord/messages/chat' : '/messages/chat',
          extra: message,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: isUnread 
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.surface,
                child: Text(
                  otherPartyName[0].toUpperCase(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          otherPartyName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: isUnread 
                                ? FontWeight.w600 
                                : FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (isUnread)
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
                      message.content,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
