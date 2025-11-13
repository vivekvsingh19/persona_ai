import 'package:flutter/material.dart';

class Persona {
  final String name;
  final String description;
  final String image;
  final String category;
  final List<Color> gradient;

  const Persona({
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.gradient,
  });

  factory Persona.fromMap(Map<String, dynamic> map) {
    return Persona(
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      category: map['category'] as String,
      gradient:
          (map['gradient'] as List?)?.cast<Color>() ??
          [Colors.blue, Colors.purple],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'category': category,
      'gradient': gradient,
    };
  }

  static final List<Persona> defaultPersonas = [
    Persona(
      name: 'Mentor Max',
      description: 'Career guidance, interviews & professional growth',
      image: 'assets/images/mentor.png',
      category: 'Career',
      gradient: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
    ),

    Persona(
      name: 'Lovely Crush Kiara',
      description: 'Romantic chats and emotional bonding',
      image: 'assets/images/crush.png',
      category: 'Romance',
      gradient: [Color(0xFFEC4899), Color(0xFFF472B6)],
    ),

    Persona(
      name: 'Calm Friend Mira',
      description: 'A gentle and comforting friend to talk to openly',
      image: 'assets/images/friend.png',
      category: 'Companion',
      gradient: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    ),

    Persona(
      name: 'Startup Coach Blaze',
      description: 'Sharp guidance for business, startups & strategy',
      image: 'assets/images/startup.png',
      category: 'Business',
      gradient: [Color(0xFF0EA5E9), Color(0xFF38BDF8)],
    ),

    Persona(
      name: 'Study Buddy Neo',
      description: 'Learning assistance, notes & exam help',
      image: 'assets/images/study.png',
      category: 'Education',
      gradient: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
    ),

    Persona(
      name: 'Zen Wellness Guide',
      description: 'Health, fitness & mindfulness guidance',
      image: 'assets/images/coach.png',
      category: 'Health',
      gradient: [Color(0xFF059669), Color(0xFF10B981)],
    ),
  ];
}
