import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class ChatScreen extends StatefulWidget {
  final Map<String, dynamic> persona;

  const ChatScreen({super.key, required this.persona});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _messageController;
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  // Background image options
  int _selectedBackground = 0;
  final List<String> _backgroundImages = [
    // Tech & AI themes
    'https://images.unsplash.com/photo-1557821552-17105176677c?w=1000&h=2000&fit=crop', // AI/Tech blue

    'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=1000&h=2000&fit=crop', // Purple tech
    // Love & Romance themes
    'https://images.unsplash.com/photo-1518895949257-7621c3c786d7?w=1000&h=2000&fit=crop', // Romantic heart
    'https://images.unsplash.com/photo-1516962712202-907c88ed4d4b?w=1000&h=2000&fit=crop', // Love couple
    // Study & Education themes
    'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=1000&h=2000&fit=crop', // Books & learning
    'https://images.unsplash.com/photo-1507842758343-583f20270319?w=1000&h=2000&fit=crop', // Study desk
    // Gym & Fitness themes
    'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=1000&h=2000&fit=crop', // Gym workout
    'https://images.unsplash.com/photo-1517836357463-d25ddfcbf042?w=1000&h=2000&fit=crop', // Fitness training
    'https://images.unsplash.com/photo-1574680096145-c2621f9c3e02?w=1000&h=2000&fit=crop', // Running fitness
    // Health & Wellness themes
    'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=1000&h=2000&fit=crop', // Health wellness
    'https://images.unsplash.com/photo-1449452237370-4a4851014e1e?w=1000&h=2000&fit=crop', // Meditation peace
    // Professional & Career themes
    'https://images.unsplash.com/photo-1552664730-d307ca884978?w=1000&h=2000&fit=crop', // Professional workspace
    'https://images.unsplash.com/photo-1552664088-97bb3df61cf7?w=1000&h=2000&fit=crop', // Career growth
    // Nature & Calm themes
    'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1000&h=2000&fit=crop', // Ocean waves
    'https://images.unsplash.com/photo-1469022563149-aa64dbd37dae?w=1000&h=2000&fit=crop', // Forest nature
    'https://images.unsplash.com/photo-1505142468610-359e7d316be0?w=1000&h=2000&fit=crop', // Ocean sunset
  ];

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();

    // Add example messages
    _messages.addAll([
      {
        'text': 'Hey! How are you doing today?',
        'isUser': true,
        'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      },
      {
        'text': 'I\'m doing great! How can I help you today? 😊',
        'isUser': false,
        'timestamp': DateTime.now().subtract(
          const Duration(minutes: 4, seconds: 30),
        ),
      },
      {
        'text': 'I need some advice on a project I\'m working on',
        'isUser': true,
        'timestamp': DateTime.now().subtract(const Duration(minutes: 3)),
      },
      {
        'text': 'I\'d be happy to help! Tell me more about your project.',
        'isUser': false,
        'timestamp': DateTime.now().subtract(
          const Duration(minutes: 2, seconds: 30),
        ),
      },
      {
        'text':
            'It\'s a mobile app for fitness tracking. I\'m stuck on the UI design.',
        'isUser': true,
        'timestamp': DateTime.now().subtract(const Duration(minutes: 2)),
      },
      {
        'text':
            'That sounds exciting! For fitness tracking, I\'d suggest:\n\n1. Clean, minimalist interface\n2. Large, readable metrics\n3. Smooth animations\n4. Dark mode support\n\nWould you like specific design suggestions?',
        'isUser': false,
        'timestamp': DateTime.now().subtract(
          const Duration(minutes: 1, seconds: 30),
        ),
      },
      {
        'text': 'Yes! That would be really helpful. Thanks so much! 🙌',
        'isUser': true,
        'timestamp': DateTime.now().subtract(const Duration(seconds: 30)),
      },
    ]);

    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isUser': true,
        'timestamp': DateTime.now(),
      });
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate response
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': 'I received your message! How can I help?',
            'isUser': false,
            'timestamp': DateTime.now(),
          });
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
    }

    return 'assets/images/coach.png'; // fallback
  }

  void _showBackgroundSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  children: [
                    const Icon(Icons.image, color: Color(0xFF4ECDC4), size: 28),
                    const SizedBox(width: 12),
                    const Text(
                      'Choose Chat Background',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Background options - Grid layout with scrolling
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.5,
                        ),
                    itemCount: _backgroundImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedBackground = index;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedBackground == index
                                  ? const Color(0xFF4ECDC4)
                                  : Colors.grey[700]!,
                              width: _selectedBackground == index ? 4 : 2,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              if (_selectedBackground == index)
                                BoxShadow(
                                  color: const Color(
                                    0xFF4ECDC4,
                                  ).withOpacity(0.4),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Background image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  _backgroundImages[index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[700],
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Selected checkmark
                              if (_selectedBackground == index)
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF4ECDC4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF4ECDC4,
                                          ).withOpacity(0.5),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(6),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Close button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4ECDC4),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: const Color(0xFF0A0E27),
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Beautiful background with image and overlay
              Stack(
                children: [
                  // Background image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          _backgroundImages[_selectedBackground],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Chat content and input
              Column(
                children: [
                  // AI app-style top bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFF4ECDC4).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            // Back button
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color(0xFFffffff),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),

                            // Persona avatar
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(
                                    0xFF4ECDC4,
                                  ).withOpacity(0.5),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF4ECDC4,
                                    ).withOpacity(0.3),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  _getPersonaBackgroundImage(
                                    widget.persona['name'] as String,
                                  ),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color(0xFF4ECDC4),
                                            const Color(0xFF44A08D),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Name and status info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.persona['name'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      letterSpacing: 0.3,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF4ECDC4),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Online",
                                        style: TextStyle(
                                          color: const Color(
                                            0xFF4ECDC4,
                                          ).withOpacity(0.8),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // More options button - Enhanced dropdown
                            PopupMenuButton<String>(
                              color: Colors.grey[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 16,
                              offset: const Offset(-10, 45),
                              onSelected: (String value) {
                                if (value == 'background') {
                                  _showBackgroundSelector();
                                } else if (value == 'clear') {
                                  // Clear messages functionality
                                } else if (value == 'info') {
                                  // Info functionality
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                    // Background option
                                    PopupMenuItem<String>(
                                      value: 'background',
                                      height: 48,
                                      child: SizedBox(
                                        width: 200,
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.image,
                                              color: Color(0xFF4ECDC4),
                                              size: 20,
                                            ),
                                            SizedBox(width: 16),
                                            Text(
                                              'Change Background',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Divider
                                    const PopupMenuDivider(height: 8),
                                    // Clear chat option
                                    PopupMenuItem<String>(
                                      value: 'clear',
                                      height: 48,
                                      child: SizedBox(
                                        width: 200,
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            SizedBox(width: 16),
                                            Text(
                                              'Clear Chat',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Divider
                                    const PopupMenuDivider(height: 8),
                                    // Info option
                                    PopupMenuItem<String>(
                                      value: 'info',
                                      height: 48,
                                      child: SizedBox(
                                        width: 200,
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            SizedBox(width: 16),
                                            Text(
                                              'Chat Info',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Chat messages area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          final isUser = message['isUser'] as bool;

                          return Padding(
                            padding: EdgeInsets.only(
                              left: isUser ? 80 : 0,
                              right: isUser ? 0 : 80,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Align(
                              alignment: isUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? Colors.white.withOpacity(0.9)
                                      : Colors.black.withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(20),
                                  // boxShadow: [
                                  //   // BoxShadow(
                                  //   //   color: isUser
                                  //   //       ? Colors.white.withOpacity(0.3)
                                  //   //       : Colors.black.withOpacity(0.4),
                                  //   //   blurRadius: 8,
                                  //   //   spreadRadius: 1,
                                  //   //   offset: const Offset(0, 3),
                                  //   // ),
                                  // ],
                                ),
                                child: Text(
                                  message['text'] as String,
                                  style: TextStyle(
                                    color: isUser
                                        ? Colors.black87
                                        : Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // Floating input
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(30),

                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4ECDC4).withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: _sendMessage,
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
