import '../models/booking_model.dart';

class BookingController {
  List<Booking> getBookingsByLandlordId(String landlordId) {
    // Filter bookings where the property owner is the landlord
    return Booking.dummyBookings
        .where((booking) => booking.property.ownerId == landlordId)
        .toList();
  }

  List<Booking> getRecentBookingsByLandlordId(String landlordId, {int limit = 3}) {
    // Get bookings for this landlord
    final bookings = getBookingsByLandlordId(landlordId);
    
    // Sort by booking date (most recent first)
    bookings.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));
    
    // Return only the most recent ones
    return bookings.take(limit).toList();
  }
}
