import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/views/booking/booking_form/widgets/guest_counter.dart';
import 'package:home_rental_app/views/booking/booking_form/widgets/price_summary.dart';
import 'package:home_rental_app/views/booking/booking_form/widgets/property_header.dart';
import 'package:home_rental_app/widgets/common/custom_button.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/color_constants.dart';
import '../../../models/property_model.dart';
import '../../../models/booking_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

extension DateTimeComparison on DateTime {
  bool isAtSameMoment(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class BookingFormScreen extends StatefulWidget {
  final Property property;

  const BookingFormScreen({
    super.key,
    required this.property,
  });

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int numberOfGuests = 1;
  bool isLoading = false;

  double get totalPrice {
    if (checkInDate == null || checkOutDate == null) return 0;
    final numberOfDays = checkOutDate!.difference(checkInDate!).inDays;
    return widget.property.price * numberOfDays;
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn
          ? DateTime.now().add(const Duration(days: 1))
          : (checkInDate?.add(const Duration(days: 1)) ??
              DateTime.now().add(const Duration(days: 2))),
      firstDate: isCheckIn
          ? DateTime.now()
          : (checkInDate ?? DateTime.now()).add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
          // Reset checkout date if it's before or equal to check-in
          if (checkOutDate != null &&
              (checkOutDate!.isBefore(picked) ||
                  checkOutDate!.isAtSameMoment(picked))) {
            checkOutDate = null;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Check-out date has been reset as it was before the new check-in date'),
              ),
            );
          }
        } else {
          if (picked.isBefore(checkInDate!) ||
              picked.isAtSameMoment(checkInDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Check-out date must be after check-in date'),
              ),
            );
            return;
          }
          checkOutDate = picked;
        }
      });
    }
  }

  Future<void> _handleBooking() async {
    if (checkInDate == null || checkOutDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select check-in and check-out dates')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final newBooking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        property: widget.property,
        checkIn: checkInDate!,
        checkOut: checkOutDate!,
        totalPrice: totalPrice,
        status: BookingStatus.upcoming,
      );

      // Add to dummy bookings (in real app, this would be an API call)
      Booking.dummyBookings.add(newBooking);

      if (mounted) {
        context.go('/bookings');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking confirmed successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to create booking. Please try again.')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Book Property',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PropertyHeader(property: widget.property),
                SizedBox(height: 32.h),
                _buildDateSelection(),
                SizedBox(height: 32.h),
                GuestCounter(
                  numberOfGuests: numberOfGuests,
                  onChanged: (value) => setState(() => numberOfGuests = value),
                ),
                SizedBox(height: 32.h),
                PriceSummary(
                  pricePerNight: widget.property.price,
                  checkInDate: checkInDate,
                  checkOutDate: checkOutDate,
                  totalPrice: totalPrice,
                ),
                SizedBox(height: 100.h), // Space for bottom button
              ],
            ),
          ),
          Positioned(
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
            child: CustomButton(
              text: 'Confirm Booking • \$${totalPrice.toStringAsFixed(2)}',
              onPressed: _handleBooking,
              isLoading: isLoading,
              height: 56.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: date != null
                ? AppColors.primary.withOpacity(0.3)
                : AppColors.primary.withOpacity(0.1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16.sp,
                  color: date != null
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
                SizedBox(width: 8.w),
                Text(
                  date != null
                      ? DateFormat('MMM dd, yyyy').format(date)
                      : 'Select date',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: date != null
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight:
                        date != null ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Dates',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildDateField(
                'Check-in',
                checkInDate,
                () => _selectDate(context, true),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildDateField(
                'Check-out',
                checkOutDate,
                () => _selectDate(context, false),
              ),
            ),
          ],
        ),
      ],
    );
  }

}
