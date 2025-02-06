import 'package:home_rental_app/models/property_model.dart';

enum BookingStatus {
  upcoming,
  ongoing,
  completed,
  cancelled
}

class Booking {
  final String id;
  final Property property;
  final DateTime checkIn;
  final DateTime checkOut;
  final double totalPrice;
  final BookingStatus status;

  Booking({
    required this.id,
    required this.property,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
    required this.status,
  });

  static List<Booking> dummyBookings = [
    Booking(
      id: '1',
      property: Property.dummyProperties[0],
      checkIn: DateTime.now().add(const Duration(days: 5)),
      checkOut: DateTime.now().add(const Duration(days: 10)),
      totalPrice: 3500 * 5,
      status: BookingStatus.upcoming,
    ),
    Booking(
      id: '2',
      property: Property.dummyProperties[1],
      checkIn: DateTime.now().subtract(const Duration(days: 2)),
      checkOut: DateTime.now().add(const Duration(days: 3)),
      totalPrice: 2800 * 5,
      status: BookingStatus.ongoing,
    ),
    Booking(
      id: '3',
      property: Property.dummyProperties[2],
      checkIn: DateTime.now().subtract(const Duration(days: 15)),
      checkOut: DateTime.now().subtract(const Duration(days: 10)),
      totalPrice: 2200 * 5,
      status: BookingStatus.completed,
    ),
    Booking(
      id: '4',
      property: Property.dummyProperties[4],
      checkIn: DateTime.now().subtract(const Duration(days: 20)),
      checkOut: DateTime.now().subtract(const Duration(days: 30)),
      totalPrice: 1600 * 5,
      status: BookingStatus.upcoming,
    ),
  ];
}
