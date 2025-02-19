class Property {
  final String id;
  final String ownerId;
  final String title;
  final String location;
  final double price;
  final String imageUrl;
  final List<String> images;
  final double rating;
  final bool isAvailable;
  final List<String> amenities;
  final String description;
  final double averageRating;
  final int numberOfRatings;
  final double latitude;
  final double longitude;

  Property({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.images,
    required this.rating,
    this.isAvailable = true,
    this.amenities = const [],
    this.description = '',
    this.averageRating = 0.0,
    this.numberOfRatings = 0,
    required this.latitude,
    required this.longitude,
  });

  static List<Property> dummyProperties = [
    Property(
      id: '1',
      ownerId: '2', // Jane Smith's ID
      title: 'Modern Apartment in Downtown',
      location: 'Downtown, City',
      price: 3500,
      imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
      images: [
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688',
      ],
      rating: 4.8,
      amenities: ['WiFi', 'Pool', 'Gym', 'Parking'],
      description: 'A beautiful modern apartment in the heart of the city.',
            latitude: 37.7749,
      longitude: -122.4194,
    ),
    Property(
      id: '2',
      ownerId: '2', // Jane Smith's ID
      title: 'Cozy Beach House',
      location: 'Beachfront, Coast City',
      price: 2800,
      imageUrl: 'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2',
      images: [
        'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2',
        'https://images.unsplash.com/photo-1499793983690-e29da59ef1c3',
      ],
      rating: 4.5,
      amenities: ['Beach Access', 'WiFi', 'Kitchen', 'BBQ'],
      description: 'Beautiful beachfront property with amazing ocean views.',
            latitude: 77.7749,
      longitude: -122.4194,
    ),
    Property(
      id: '3',
      ownerId: '3',
      title: 'Mountain Cabin',
      location: 'Mountain View, Highland',
      price: 2200,
      imageUrl: 'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8',
      images: [
        'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8',
        'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d7',
      ],
      rating: 4.7,
      amenities: ['Fireplace', 'Hiking Trails', 'Scenic View'],
      description: 'Cozy cabin with breathtaking mountain views.',
            latitude: 17.7749,
      longitude: -122.4194,
    ),
    Property(
      id: '4',
      ownerId: '3',
      title: 'Luxury Villa',
      location: 'Suburban Area, Green City',
      price: 5000,
      imageUrl: 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
      images: [
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b914',
        'https://images.unsplash.com/photo-1580587771525-78b9dba3b915',
      ],
      rating: 4.9,
      amenities: ['Pool', 'Garden', 'Tennis Court', 'Security'],
      description: 'Luxurious villa with private pool and tennis court.',
            latitude: 37.7749,
      longitude: -102.4194,
    ),
    Property(
      id: '5',
      ownerId: '2',
      title: 'Studio Apartment',
      location: 'University District, Education City',
      price: 1600,
      imageUrl: 'https://images.unsplash.com/photo-1522156373667-4c7234bbd804',
      images: [
        'https://images.unsplash.com/photo-1522156373667-4c7234bbd804',
        'https://images.unsplash.com/photo-1522156373667-4c7234bbd805',
      ],
      rating: 4.3,
      amenities: ['WiFi', 'Study Area', 'Laundry'],
      description: 'Perfect for students, close to university campus.',
            latitude: 37.7749,
      longitude: -12.4194,
    ),
  ];
}
