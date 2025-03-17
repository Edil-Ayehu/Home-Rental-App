import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/color_constants.dart';
import '../../../models/booking_model.dart';
import '../../../widgets/common/page_layout.dart';
import 'widgets/bookings_list.dart';

class BookingsListScreen extends StatefulWidget {
  const BookingsListScreen({super.key});

  @override
  State<BookingsListScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsListScreen> with SingleTickerProviderStateMixin {
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: _tabs.map((status) => Tab(
                text: status.name[0].toUpperCase() + status.name.substring(1),
              )).toList(),
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
              controller: _tabController,
              children: _tabs.map((status) => BookingsList(status: status)).toList(),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
