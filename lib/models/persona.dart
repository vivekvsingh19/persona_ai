import 'package:flutter/material.dart';

class Persona {
  final String id;
  final String name;
  final String description;
  final Color color;
  final IconData icon;
  final String? imageUrl;
  final double rating;
  final String? specialty;
  final List<String> tags;
  final bool isOnline;

  Persona({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
    this.imageUrl,
    this.rating = 4.5,
    this.specialty,
    this.tags = const [],
    this.isOnline = true,
  });
}
