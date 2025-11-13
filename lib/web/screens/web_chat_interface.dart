import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/navbar_widget.dart';

class WebChatInterface extends StatefulWidget {
  final Map<String, dynamic>? persona;

  const WebChatInterface({Key? key, this.persona}) : super(key: key);

  @override
  State<WebChatInterface> createState() => _WebChatInterfaceState();
}

class _WebChatInterfaceState extends State<WebChatInterface> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hello! I\'m your AI mentor. How can I help you today?',
      'isUser': false,
      'timestamp': '10:30 AM',
    },
    {
      'text': 'Hi! I need help with my career path.',
      'isUser': true,
      'timestamp': '10:31 AM',
    },
    {
      'text':
          'Great! Tell me about your current role and what you\'d like to achieve.',
      'isUser': false,
      'timestamp': '10:31 AM',
    },
    {
      'text':
          'I\'m a junior developer and want to become a tech lead within 2 years.',
      'isUser': true,
      'timestamp': '10:32 AM',
    },
    {
      'text':
          'That\'s an excellent goal! Here are 5 key steps to get there:\n\n1. Master system design\n2. Lead projects\n3. Mentor others\n4. Improve communication\n5. Stay updated with tech',
      'isUser': false,
      'timestamp': '10:33 AM',
    },
  ];

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'text': text, 'isUser': true, 'timestamp': 'Now'});
    });
    messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  Widget _buildPersonaAvatar() {
    final String? imageUrl = widget.persona?['imageUrl'] as String?;
    final String? imagePath = widget.persona?['image'] as String?;

    // If persona has a network image URL, display it
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    // If persona has an asset image, display it
    if (imagePath != null && imagePath.isNotEmpty) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildFallbackAvatar();
            },
          ),
        ),
      );
    }

    // Fallback avatar
    return _buildFallbackAvatar();
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            WebTheme.primaryGradientStart.withOpacity(0.6),
            WebTheme.primaryGradientEnd.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text('🎓', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    if (isMobile) {
      return _buildMobileLayout();
    }

    return _buildDesktopLayout();
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: WebTheme.darkBg,
      body: Column(
        children: [
          // Mobile header with persona info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Row(
              children: [
                _buildPersonaAvatar(),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.persona?['name'] ?? 'AI Companion',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: WebTheme.textPrimary,
                        ),
                      ),
                      Text(
                        'Online',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: WebTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.more_vert, color: WebTheme.textSecondary, size: 20),
              ],
            ),
          ),
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(
                  text: message['text'],
                  isUser: message['isUser'],
                  timestamp: message['timestamp'],
                );
              },
            ),
          ),
          // Input area
          _buildMobileInputArea(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: WebTheme.darkBg,
      body: Column(
        children: [
          NavbarWidget(
            onLoginPressed: () => Navigator.pushNamed(context, '/login'),
            onHomePressed: () => Navigator.pushNamed(context, '/'),
          ),
          Expanded(
            child: Row(
              children: [
                _buildSidebar(),
                Expanded(child: _buildChatArea()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Sidebar
  Widget _buildSidebar() {
    return Container(
      width: 300,
      color: Colors.black.withOpacity(0.3),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Personas',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: WebTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Chat',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: WebTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('➕', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(
                      'New Chat',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: WebTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(color: Colors.white12, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildChatItem('Career guidance', true),
                const SizedBox(height: 8),
                _buildChatItem('Life coaching session', false),
                const SizedBox(height: 8),
                _buildChatItem('Wellness tips', false),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GlassContainer(
              borderRadius: 12,
              backgroundColor: Colors.white.withOpacity(0.05),
              padding: const EdgeInsets.all(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          WebTheme.primaryGradientStart,
                          WebTheme.primaryGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('👤', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: WebTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'user@email.com',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: WebTheme.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.logout, size: 18, color: WebTheme.textSecondary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Chat Area
  Widget _buildChatArea() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
          ),
          child: Row(
            children: [
              _buildPersonaAvatar(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.persona?['name'] ?? 'AI Companion',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: WebTheme.textPrimary,
                      ),
                    ),
                    Text(
                      'Online • ${widget.persona?['description'] ?? 'AI Assistant'}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: WebTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, color: WebTheme.textSecondary, size: 20),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return _buildMessageBubble(
                text: message['text'],
                isUser: message['isUser'],
                timestamp: message['timestamp'],
              );
            },
          ),
        ),
        _buildInputArea(),
      ],
    );
  }

  Widget _buildChatItem(String title, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.white.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: isActive
            ? Border.all(color: Colors.white.withOpacity(0.2), width: 1)
            : null,
      ),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: isActive ? WebTheme.textPrimary : WebTheme.textSecondary,
        ),
      ),
    );
  }

  Widget _buildMessageBubble({
    required String text,
    required bool isUser,
    required String timestamp,
  }) {
    final bgColor = isUser
        ? WebTheme.primaryGradientStart.withOpacity(0.7)
        : Colors.white.withOpacity(0.08);
    final textColor = Colors.white;
    final borderRadius = isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      WebTheme.primaryGradientStart.withOpacity(0.6),
                      WebTheme.primaryGradientEnd.withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('🤖', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    text,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: textColor,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  timestamp,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: WebTheme.textSecondary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          if (isUser)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      WebTheme.primaryGradientStart,
                      WebTheme.primaryGradientEnd,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('👤', style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            child: GlassContainer(
              borderRadius: 16,
              backgroundColor: Colors.white.withOpacity(0.05),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              child: TextField(
                controller: messageController,
                onSubmitted: (_) => sendMessage(),
                maxLines: 3,
                minLines: 1,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: WebTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: WebTheme.textSecondary.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: sendMessage,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    WebTheme.primaryGradientStart,
                    WebTheme.primaryGradientEnd,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: WebTheme.primaryGradientStart.withOpacity(0.4),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            child: GlassContainer(
              borderRadius: 12,
              backgroundColor: Colors.white.withOpacity(0.05),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              child: TextField(
                controller: messageController,
                onSubmitted: (_) => sendMessage(),
                maxLines: 3,
                minLines: 1,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: WebTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Message...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 13,
                    color: WebTheme.textSecondary.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: sendMessage,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    WebTheme.primaryGradientStart,
                    WebTheme.primaryGradientEnd,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: WebTheme.primaryGradientStart.withOpacity(0.4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
