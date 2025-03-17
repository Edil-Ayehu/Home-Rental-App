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
            ? _buildEmptyState(context,isLandlord)
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
                  SliverToBoxAdapter(
                    child: SizedBox(height: 16.h),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context,bool isLandlord) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32.w),
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
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              TextButton.icon(
                onPressed: () => context.push('/properties'),
                icon: Icon(
                  Icons.search,
                  size: 18.sp,
                  color: AppColors.primary,
                ),
                label: Text(
                  'Browse Properties',
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
    final timestamp = DateTime.now().difference(message.timestamp).inHours < 24
        ? '${DateTime.now().difference(message.timestamp).inHours}h ago'
        : '${DateTime.now().difference(message.timestamp).inDays}d ago';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isUnread 
              ? AppColors.primary.withOpacity(0.3)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
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
                    : Colors.grey.withOpacity(0.1),
                child: Text(
                  otherPartyName[0].toUpperCase(),
                  style: TextStyle(
                    color: isUnread ? AppColors.primary : Colors.grey[700],
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
                        Text(
                          timestamp,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message.content,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isUnread 
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: isUnread 
                                  ? FontWeight.w500 
                                  : FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isUnread)
                          Container(
                            margin: EdgeInsets.only(left: 8.w),
                            width: 10.w,
                            height: 10.w,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
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
