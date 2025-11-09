import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../models/persona.dart';
import '../models/message.dart';

class ChatController extends ChangeNotifier {
  final List<Persona> personas = [
    Persona(
      id: 'advisor',
      name: 'Aissi',
      description: 'General questions, conversations, searching',
      specialty: 'AI Consultant',
      color: const Color(0xFF7B61FF),
      icon: Iconsax.user,
      imageUrl: 'assets/avatars/advisor.png',
      tags: ['General AI', 'Conversation', 'Research'],
    ),
    Persona(
      id: 'counselor',
      name: 'Olivia',
      description: 'Emotional support and guidance',
      specialty: 'Mental Wellness Guide',
      color: const Color(0xFF4E8AFF),
      icon: Iconsax.heart,
      imageUrl: 'assets/avatars/counselor.png',
      tags: ['Empathy', 'Support', 'Wellness'],
    ),
    Persona(
      id: 'coach',
      name: 'Marcus',
      description: 'Goal setting and motivation',
      specialty: 'Performance Coach',
      color: const Color(0xFFFF6B4E),
      icon: Iconsax.trend_up,
      imageUrl: 'assets/avatars/coach.png',
      tags: ['Goals', 'Growth', 'Success'],
    ),
    Persona(
      id: 'creative',
      name: 'Luna',
      description: 'Creative projects and brainstorming',
      specialty: 'Creative Director',
      color: const Color(0xFF4ECAFF),
      icon: Iconsax.brush_2,
      imageUrl: 'assets/avatars/creative.png',
      tags: ['Art', 'Design', 'Ideas'],
    ),
  ];

  late Persona currentPersona;

  final List<Message> _messages = [];

  List<Message> get messages => List.unmodifiable(_messages);

  ChatController() {
    currentPersona = personas.first;
    // seed with a greeting from the persona
    _messages.add(
      Message(
        id: 'm0',
        text:
            '${currentPersona.name}: Hi — I am your ${currentPersona.name.toLowerCase()}. How can I help today?',
        isUser: false,
        personaId: currentPersona.id,
      ),
    );
  }

  void switchPersona(String id) {
    final p = personas.firstWhere((e) => e.id == id);
    currentPersona = p;
    _messages.add(
      Message(
        id: 'sys-${DateTime.now().millisecondsSinceEpoch}',
        text: '${p.name} is ready to chat with you.',
        isUser: false,
        personaId: p.id,
      ),
    );
    notifyListeners();
  }

  void sendUserMessage(String text) {
    if (text.trim().isEmpty) return;
    final msg = Message(
      id: 'u-${DateTime.now().millisecondsSinceEpoch}',
      text: text.trim(),
      isUser: true,
      personaId: currentPersona.id,
    );
    _messages.add(msg);
    notifyListeners();

    // generate a mock persona reply asynchronously
    _generateMockReply(text.trim(), currentPersona);
  }

  Future<void> _generateMockReply(String userText, Persona persona) async {
    // small delay to simulate thinking / network
    await Future.delayed(const Duration(milliseconds: 700));

    final reply = _mockReplyForPersona(userText, persona);

    _messages.add(
      Message(
        id: 'b-${DateTime.now().millisecondsSinceEpoch}',
        text: reply,
        isUser: false,
        personaId: persona.id,
      ),
    );
    notifyListeners();
  }

  String _mockReplyForPersona(String userText, Persona persona) {
    // Very simple persona-specific canned responses to illustrate
    if (persona.id == 'mentor') {
      return 'As a mentor, I suggest breaking this into smaller steps. Can you share the biggest blocker?';
    } else if (persona.id == 'coach') {
      return 'Nice! What is one measurable goal you can set this week? I will help you stay accountable.';
    } else if (persona.id == 'friend') {
      return 'I hear you. That sounds tough — want to tell me more or talk about something lighter?';
    } else if (persona.id == 'counselor') {
      return 'I am here to listen. What are you feeling right now? It may help to name one small feeling.';
    }
    return 'I am here to help.';
  }
}
