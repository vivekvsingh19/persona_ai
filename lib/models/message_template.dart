// This file contains the required Data Models for the Chat App
// Place this in: lib/models/message.dart
// Update your existing file if it differs

class Message {
  final String id;
  final String userId;
  final String personaId;
  final String conversationId;
  final String content;
  final bool isUserMessage;
  final DateTime timestamp;
  final String? imageUrl;
  final MessageStatus status;
  final int? characterCount;

  Message({
    required this.id,
    required this.userId,
    required this.personaId,
    required this.conversationId,
    required this.content,
    required this.isUserMessage,
    required this.timestamp,
    this.imageUrl,
    this.status = MessageStatus.sent,
    this.characterCount,
  });

  // Convert to Firestore-compatible Map
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'personaId': personaId,
      'conversationId': conversationId,
      'content': content,
      'isUserMessage': isUserMessage,
      'timestamp': timestamp,
      'imageUrl': imageUrl,
      'status': status.toString(),
      'characterCount': characterCount ?? content.length,
    };
  }

  // Create from Firestore document
  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
      id: data['id'] as String,
      userId: data['userId'] as String,
      personaId: data['personaId'] as String,
      conversationId: data['conversationId'] as String,
      content: data['content'] as String,
      isUserMessage: data['isUserMessage'] as bool,
      timestamp: (data['timestamp'] as dynamic).toDate() ?? DateTime.now(),
      imageUrl: data['imageUrl'] as String?,
      status: MessageStatus.values.firstWhere(
        (e) => e.toString() == data['status'],
        orElse: () => MessageStatus.sent,
      ),
      characterCount: data['characterCount'] as int?,
    );
  }

  // Create a copy with modified fields
  Message copyWith({
    String? id,
    String? userId,
    String? personaId,
    String? conversationId,
    String? content,
    bool? isUserMessage,
    DateTime? timestamp,
    String? imageUrl,
    MessageStatus? status,
    int? characterCount,
  }) {
    return Message(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      personaId: personaId ?? this.personaId,
      conversationId: conversationId ?? this.conversationId,
      content: content ?? this.content,
      isUserMessage: isUserMessage ?? this.isUserMessage,
      timestamp: timestamp ?? this.timestamp,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      characterCount: characterCount ?? this.characterCount,
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, userId: $userId, content: $content, isUserMessage: $isUserMessage, timestamp: $timestamp)';
  }
}

// Enum for message delivery status
enum MessageStatus { sending, sent, failed, read }

// Extension for better string representation
extension MessageStatusExtension on MessageStatus {
  String get displayName {
    switch (this) {
      case MessageStatus.sending:
        return 'Sending...';
      case MessageStatus.sent:
        return 'Sent';
      case MessageStatus.failed:
        return 'Failed';
      case MessageStatus.read:
        return 'Read';
    }
  }
}
