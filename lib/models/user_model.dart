enum UserRole {
  tenant,
  landlord
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;
  final UserRole role;
  final List<String>? ownedPropertyIds; // Only for landlords

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
    required this.role,
    this.ownedPropertyIds,
  });

  static List<User> dummyUsers = [
    User(
      id: '1',
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      role: UserRole.tenant,
    ),
    User(
      id: '2',
      fullName: 'Jane Smith',
      email: 'jane.smith@example.com',
      role: UserRole.landlord,
      ownedPropertyIds: ['1', '2'],
    ),
  ];
}
