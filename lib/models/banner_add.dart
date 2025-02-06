class BannerAd {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String? link;


  BannerAd({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.link,
  });

  // Dummy data for testing
  static List<BannerAd> dummyBanners = [
    BannerAd(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
      title: 'Special Offer',
      description: 'Get 20% off on your first booking',
      link: '/offers/1',
    ),
    BannerAd(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
      title: 'New Properties',
      description: 'Explore new luxury properties',
      link: '/properties/new',
    ),
    BannerAd(
      id: '3',
      imageUrl: 'https://st3.idealista.pt/news/arquivos/styles/fullwidth_xl/public/2023-02/media/image/200912673.jpg?VersionId=TvjBUnAHtEUTlc7w7tv6NcN6HdrYFszJ&itok=oM5UI4FD',
      title: 'Premium Locations',
      description: 'Discover homes in premium locations',
      link: '/locations/premium',
    ),
  ];
}
