class Rating {
  final String id;
  final String propertyId;
  final String userId;
  final String userName;
  final double rating;
  final String? comment;
  final DateTime timestamp;

  Rating({
    required this.id,
    required this.propertyId,
    required this.userId,
    required this.userName,
    required this.rating,
    this.comment,
    required this.timestamp,
  });

  static List<Rating> dummyRatings = [
    Rating(
      id: '1',
      propertyId: '1',
      userId: '1',
      userName: 'John Doe',
      rating: 4.5,
      comment: 'Great property with amazing views!',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];
}
