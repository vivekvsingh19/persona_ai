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

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors =
        widget.persona['gradient'] as List<Color>;

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
              // Background image with blur effect
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      _getPersonaBackgroundImage(
                        widget.persona['name'] as String,
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: Container(color: Colors.black.withOpacity(0.4)),
                ),
              ),

              // Chat content and input
              Column(
                children: [
                  // Modern top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        // Back button with subtle circle
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Persona avatar
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: gradientColors[0],
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.persona['image'] as String,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Name and subtitle
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.persona['name'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Online", // you can make this dynamic
                              style: TextStyle(
                                color: Colors.green.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        // Optional actions
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white.withOpacity(0.2),
                        //     shape: BoxShape.circle,
                        //   ),
                        //   // child: IconButton(
                        //   //   icon: const Icon(
                        //   //     Icons.call,
                        //   //     color: Color(0xFF2D3142),
                        //   //   ),
                        //   //   onPressed: () {},
                        //   // ),
                        // ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
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

                          return Align(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? gradientColors[0].withOpacity(0.7)
                                    : Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                message['text'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
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
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
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
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: gradientColors[0].withOpacity(0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
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
