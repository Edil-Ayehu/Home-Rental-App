class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String senderName;
  final String receiverName;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });

  static List<Message> dummyMessages = [
    Message(
      id: '1',
      senderId: '2', // Jane Smith (Landlord)
      receiverId: '1', // John Doe (Tenant)
      senderName: 'Jane Smith',
      receiverName: 'John Doe',
      content: 'Thank you for your interest in the property.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: true,
    ),
    Message(
      id: '2',
      senderId: '1', // John Doe (Tenant)
      receiverId: '2', // Jane Smith (Landlord)
      senderName: 'John Doe',
      receiverName: 'Jane Smith',
      content: 'Is the property still available?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
  ];
}
