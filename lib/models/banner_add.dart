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
      imageUrl: 'https://img.freepik.com/free-psd/fashion-sale-banner-template_23-2148935598.jpg?semt=ais_hybrid',
      title: 'Special Offer',
      description: 'Get 20% off on your first booking',
      link: '/offers/1',
    ),
    BannerAd(
      id: '2',
      imageUrl: 'https://img.freepik.com/free-psd/flat-design-discount-banner-template_23-2149388688.jpg',
      title: 'New Properties',
      description: 'Explore new luxury properties',
      link: '/properties/new',
    ),
    BannerAd(
      id: '3',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPBfSCz-lt1sG7qgr8Tz4ARYaabe80sAts4g&s',
      title: 'Premium Locations',
      description: 'Discover homes in premium locations',
      link: '/locations/premium',
    ),
  ];
}
