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
      name: 'Professional Mentor',
      description: 'Career guidance and professional development',
      image: 'assets/images/mentor.png',
      category: 'Career',
      gradient: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
    ),
    Persona(
      name: 'Life Coach',
      description: 'Personal growth and motivation',
      image: 'assets/images/coach.png',
      category: 'Personal',
      gradient: [Color(0xFF7C3AED), Color(0xFFA78BFA)],
    ),
    Persona(
      name: 'lovely crush',
      description: 'Romantic conversations and advice',
      image: 'assets/images/crush.png',
      category: 'Creative',
      gradient: [Color(0xFFEC4899), Color(0xFFF472B6)],
    ),
    Persona(
      name: 'Wellness Guide',
      description: 'Health, fitness, and mindfulness',
      image: 'assets/images/gym.png',
      category: 'Health',
      gradient: [Color(0xFF059669), Color(0xFF10B981)],
    ),
    Persona(
      name: 'Study Buddy',
      description: 'Academic support and learning assistance',
      image: 'https://images.unsplash.com/photo-1629425733761-caae3b5f2e50',
      category: 'Education',
      gradient: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
    ),
    Persona(
      name: 'Tech Advisor',
      description: 'Technology and digital solutions',
      image: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2',
      category: 'Technology',
      gradient: [Color(0xFF06B6D4), Color(0xFF22D3EE)],
    ),
  ];
}
