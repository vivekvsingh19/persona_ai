class Message {
  final String id;
  final String text;
  final bool isUser;
  final String personaId;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.text,
    required this.isUser,
    required this.personaId,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
