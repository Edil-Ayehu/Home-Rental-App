import 'package:flutter/material.dart';
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
              children: _tabs.map((status) => BookingsList(status: status)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
