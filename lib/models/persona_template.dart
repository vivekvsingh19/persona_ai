// This file contains the required Persona Model
// Place this in: lib/models/persona.dart
// Update your existing file if it differs

class Persona {
  final String id;
  final String name;
  final String avatar;
  final String description;
  final String personality;
  final String systemPrompt;
  final List<String> traits;
  final List<String> expertise;
  final String communicationStyle;
  final int messageLimit;
  final bool isAvailable;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Persona({
    required this.id,
    required this.name,
    required this.avatar,
    required this.description,
    required this.personality,
    required this.systemPrompt,
    required this.traits,
    required this.expertise,
    required this.communicationStyle,
    this.messageLimit = 1000,
    this.isAvailable = true,
    required this.createdAt,
    this.updatedAt,
  });

  // Convert to Firestore-compatible Map
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar,
      'description': description,
      'personality': personality,
      'systemPrompt': systemPrompt,
      'traits': traits,
      'expertise': expertise,
      'communicationStyle': communicationStyle,
      'messageLimit': messageLimit,
      'isAvailable': isAvailable,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create from Firestore document
  factory Persona.fromFirestore(Map<String, dynamic> data) {
    return Persona(
      id: data['id'] as String,
      name: data['name'] as String,
      avatar: data['avatar'] as String,
      description: data['description'] as String,
      personality: data['personality'] as String,
      systemPrompt: data['systemPrompt'] as String,
      traits: List<String>.from(data['traits'] as List? ?? []),
      expertise: List<String>.from(data['expertise'] as List? ?? []),
      communicationStyle: data['communicationStyle'] as String,
      messageLimit: data['messageLimit'] as int? ?? 1000,
      isAvailable: data['isAvailable'] as bool? ?? true,
      createdAt: (data['createdAt'] as dynamic).toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as dynamic)?.toDate(),
    );
  }

  // Create a copy with modified fields
  Persona copyWith({
    String? id,
    String? name,
    String? avatar,
    String? description,
    String? personality,
    String? systemPrompt,
    List<String>? traits,
    List<String>? expertise,
    String? communicationStyle,
    int? messageLimit,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Persona(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      description: description ?? this.description,
      personality: personality ?? this.personality,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      traits: traits ?? this.traits,
      expertise: expertise ?? this.expertise,
      communicationStyle: communicationStyle ?? this.communicationStyle,
      messageLimit: messageLimit ?? this.messageLimit,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Persona(id: $id, name: $name, description: $description)';
  }
}

// Predefined personas for the app
class PersonaTemplates {
  static Persona genius = Persona(
    id: 'persona_genius',
    name: 'The Genius',
    avatar: 'assets/avatars/genius_avatar.png',
    description: 'A brilliant and quick-witted problem solver',
    personality: 'Intellectual, curious, and witty',
    systemPrompt:
        'You are a brilliant AI persona known for solving complex problems with elegant solutions. Be witty, insightful, and always explain your reasoning clearly.',
    traits: ['Intelligent', 'Quick-witted', 'Logical', 'Creative'],
    expertise: ['Problem-solving', 'Analysis', 'Science', 'Technology'],
    communicationStyle: 'Direct and analytical with occasional wit',
    createdAt: DateTime.now(),
  );

  static Persona therapist = Persona(
    id: 'persona_therapist',
    name: 'The Therapist',
    avatar: 'assets/avatars/therapist_avatar.png',
    description: 'A compassionate listener and empathetic guide',
    personality: 'Empathetic, patient, and understanding',
    systemPrompt:
        'You are a supportive AI therapist persona. Listen carefully, ask thoughtful questions, and provide emotional support. Be warm, non-judgmental, and caring.',
    traits: ['Empathetic', 'Patient', 'Understanding', 'Supportive'],
    expertise: [
      'Emotional support',
      'Active listening',
      'Advice',
      'Motivation',
    ],
    communicationStyle: 'Warm, supportive, and deeply listening',
    createdAt: DateTime.now(),
  );

  static Persona mentor = Persona(
    id: 'persona_mentor',
    name: 'The Mentor',
    avatar: 'assets/avatars/mentor_avatar.png',
    description: 'An experienced guide who helps you grow',
    personality: 'Wise, patient, and encouraging',
    systemPrompt:
        'You are a wise AI mentor persona. Guide, teach, and encourage growth. Share knowledge generously and help users develop their skills and mindset.',
    traits: ['Wise', 'Patient', 'Encouraging', 'Knowledgeable'],
    expertise: ['Teaching', 'Leadership', 'Growth', 'Career development'],
    communicationStyle: 'Encouraging, educational, and motivational',
    createdAt: DateTime.now(),
  );

  static Persona comedian = Persona(
    id: 'persona_comedian',
    name: 'The Comedian',
    avatar: 'assets/avatars/comedian_avatar.png',
    description: 'A humorous friend who brings laughter',
    personality: 'Funny, witty, and entertaining',
    systemPrompt:
        'You are a funny AI comedian persona. Use humor, jokes, and wit to entertain. Be lighthearted but intelligent, making people laugh while still being helpful.',
    traits: ['Humorous', 'Witty', 'Entertaining', 'Creative'],
    expertise: ['Comedy', 'Entertainment', 'Social interaction', 'Fun'],
    communicationStyle: 'Humorous, playful, and entertaining',
    createdAt: DateTime.now(),
  );

  static List<Persona> getAll() => [genius, therapist, mentor, comedian];
}
