class Property {
  final String id;
  final String title;
  final String location;
  final double price;
  final String imageUrl;
  final List<String> images;
  final double rating;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.images,
    required this.rating,
  });

  static List<Property> dummyProperties = [
    Property(
      id: '1',
      title: 'Modern Villa',
      location: 'Beverly Hills, LA',
      price: 3500,
      imageUrl: 'assets/images/house/villa.jpg',
      images: [
        'assets/images/house/villa.jpg',
        'assets/images/house/villa_1.jpg',
        'assets/images/house/villa_2.jpg',
        'assets/images/house/villa_3.jpg',
      ],
      rating: 4.8,
    ),
    Property(
      id: '2',
      title: 'Luxury Apartment',
      location: 'Manhattan, NY',
      price: 2800,
      imageUrl: 'assets/images/house/apartment_1.jpg',
      images: [
        'assets/images/house/villa_4.jpg',
        'assets/images/house/villa_3.jpg',
        'assets/images/house/villa_2.jpg',
        'assets/images/house/villa.jpg',
      ],
      rating: 4.5,
    ),
    Property(
      id: '3',
      title: 'Cozy House',
      location: 'San Francisco, CA',
      price: 2200,
      imageUrl: 'assets/images/house/villa.jpg',
      images: [
        'assets/images/house/villa_4.jpg',
        'assets/images/house/villa_3.jpg',
        'assets/images/house/villa_2.jpg',
        'assets/images/house/villa.jpg',
      ],
      rating: 4.3,
    ),
     Property(
      id: '4',
      title: 'Modern Villa',
      location: 'Beverly Hills, LA',
      price: 3500,
      imageUrl: 'assets/images/house/villa.jpg',
      images: [
        'assets/images/house/villa_4.jpg',
        'assets/images/house/villa_3.jpg',
        'assets/images/house/villa_2.jpg',
        'assets/images/house/villa.jpg',
      ],
      rating: 4.3,
    ),
     Property(
      id: '5',
      title: 'Double Villa',
      location: 'Beverly Hills, LA',
        price: 4500,
      imageUrl: 'assets/images/house/villa.jpg',
      images: [
        'assets/images/house/villa_4.jpg',
        'assets/images/house/villa_3.jpg',
        'assets/images/house/villa_2.jpg',
        'assets/images/house/villa.jpg',
      ],
      rating: 4.3,
    ),
     Property(
      id: '6',
      title: 'Elegant Villa',
      location: 'New York, NY',
      price: 4500,
      imageUrl: 'assets/images/house/villa.jpg',
      images: [
        'assets/images/house/villa_4.jpg',
        'assets/images/house/villa_3.jpg',
        'assets/images/house/villa_2.jpg',
        'assets/images/house/villa.jpg',
      ],
      rating: 4.3,
    ),
     Property(
      id: '7',
      title: 'Classic Villa',
      location: 'San Francisco, CA',
      price: 8200,
      imageUrl: 'assets/images/house/villa.jpg',
      images: [
        'assets/images/house/villa_4.jpg',
        'assets/images/house/villa_3.jpg',
        'assets/images/house/villa_2.jpg',
        'assets/images/house/villa.jpg',
      ],
      rating: 4.3,
    ),
  ];
}
