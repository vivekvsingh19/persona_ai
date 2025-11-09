import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({super.key});

  String _getPersonaBackgroundImage(String personaName) {
    final name = personaName.toLowerCase();

    if (name.contains('mentor') || name.contains('professional')) {
      return 'assets/images/mentor.png';
    } else if (name.contains('coach') || name.contains('life')) {
      return 'assets/images/coach.png';
    } else if (name.contains('crush') || name.contains('lovely')) {
      return 'assets/images/crush.png';
    } else if (name.contains('wellness') ||
        name.contains('gym') ||
        name.contains('health')) {
      return 'assets/images/gym.png';
    } else if (name.contains('creative')) {
      return 'assets/images/coach.png';
    }

    return 'assets/images/coach.png'; // fallback
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFFF5F5),
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color(0xFF121212)
            : const Color(0xFFFFF5F5),
        elevation: 0,
        title: Text(
          'Chats',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16).copyWith(bottom: 100),
          itemCount: recentChats.length,
          itemBuilder: (context, index) {
            final chat = recentChats[index];
            return _buildChatItem(context, chat);
          },
        ),
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, Map<String, dynamic> chat) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen(persona: chat)),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
          border: isDark
              ? null
              : Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        ),
        child: Row(
          children: [
            // Avatar with persona background image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    _getPersonaBackgroundImage(chat['name'] as String),
                  ),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: (chat['gradient'] as List<Color>)[0],
                  width: 2,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat['name'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat['lastMessage'] as String,
                    style: TextStyle(
                      color: isDark
                          ? Colors.white.withOpacity(0.6)
                          : Colors.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              chat['time'] as String,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> recentChats = [
    {
      'name': 'Professional Mentor',
      'lastMessage': 'Let\'s discuss your career goals',
      'time': '2m ago',
      'image': 'https://images.unsplash.com/photo-1560250097-0b93528c311a',
      'gradient': [Color(0xFFFF8AD4), Color(0xFF6EE7F0)],
    },
    {
      'name': 'Life Coach',
      'lastMessage': 'Remember to practice mindfulness',
      'time': '1h ago',
      'image': 'https://images.unsplash.com/photo-1544717305-2782549b5136',
      'gradient': [Color(0xFFFFE37E), Color(0xFFB38CFF)],
    },
    {
      'name': 'Creative Companion',
      'lastMessage': 'Your latest project looks promising!',
      'time': '2h ago',
      'image': 'https://images.unsplash.com/photo-1542103749-8ef59b94f47e',
      'gradient': [Color(0xFF6EE7F0), Color(0xFFB38CFF)],
    },
    {
      'name': 'Wellness Guide',
      'lastMessage': 'Time for your evening meditation',
      'time': '5h ago',
      'image': 'https://images.unsplash.com/photo-1594381898411-846e7d193883',
      'gradient': [Color(0xFFFF8AD4), Color(0xFFFFE37E)],
    },
  ];
}
