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
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9fAiRxHn4fyYp0nmFPzbTLolhJxdTdzzKRg&s',
      images: [
        'https://media.inmobalia.com/imgV1/B98Le8~d7M9k3DegpEFZhS0lI_F8U4XZVz~HWxt~mGgYekxX9nCAxh0ZjtE2u9zqepXEUrVLqfm8KeIGW6Gtyd4X89rFFK10v85qQta1cATBDN7qKfuT2L9OiVHyxuhoOOKveWlHqxMf6akqXhMqmr2txEX9e2aFKA--.jpg',
        'https://rqitects.com/wp-content/uploads/2024/08/01_VILLA_ISMAIL_FRONT1.webp',

      ],
      rating: 4.8,
    ),
    Property(
      id: '2',
      title: 'Luxury Apartment',
      location: 'Manhattan, NY',
      price: 2800,
      imageUrl: 'https://st3.idealista.pt/news/arquivos/styles/fullwidth_xl/public/2023-02/media/image/200912673.jpg?VersionId=TvjBUnAHtEUTlc7w7tv6NcN6HdrYFszJ&itok=oM5UI4FD',
      images: [
        'https://www.elitehavens.com/magazine/wp-content/uploads/2021/05/Header.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHtxvrgJOj6I7cnXdEJ_hhjsCKM3fLkjPJ7w&s',
      ],
      rating: 4.5,
    ),
     Property(
      id: '3',
      title: 'Elegant Villa',
      location: 'New York, NY',
      price: 4500,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAAo-63fa3jWHwtYEgxOkUzHA7sdDvGQ3r8Q&s',
      images: [
        'https://www.akvillas.com/-/media/akvillas/properties/spain/andalucia/villa-ana-may24/1-villa-ana-pool.jpg?la=en&hash=7EFACF66A7B6FB37BC4A0E6DD3423A36AC990D7B',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGpC6N4fsMlT85a8QBOc1aqztKs0CL3ugRKg&s',
      ],
      rating: 4.5,
    ),
     Property(
      id: '4',
      title: 'Modern Villa',
      location: 'Beverlly',
      price: 2800,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL0_OwmghtJfDVhpP9oF7JKzHX9KVessOz3Q&s',
      images: [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA5BitmD80mP0MPiR9_iEhJHFxLQEjO7Dn6w&s',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkYTk5RmDxnvNSlkVRWUaXIcNFDhD653zFKg&s',
      ],
      rating: 4.5,
    ),
     Property(
      id: '5',
      title: 'Luxury Apartment',
      location: 'Manhattan, NY',
      price: 2800,
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuGp_pgxNeU3XIQyVz2we63XNOG1iTDMPPMw&s',
      images: [
        'https://www.elitehavens.com/magazine/wp-content/uploads/2021/05/Header.jpg',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHtxvrgJOj6I7cnXdEJ_hhjsCKM3fLkjPJ7w&s',
      ],
      rating: 4.5,
    ),
  ];
}
