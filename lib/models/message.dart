class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });

  static List<Message> dummyMessages = [
    Message(
      id: '1',
      senderId: 'host1',
      receiverId: 'user1',
      content: 'Hello! Is this property still available?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      isRead: true,
    ),
    Message(
      id: '2',
      senderId: 'host2',
      receiverId: 'user1',
      content: 'Your booking has been confirmed!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
  ];
}
