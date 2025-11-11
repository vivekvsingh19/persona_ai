import 'package:flutter/material.dart';
import 'glass_container.dart';
import '../theme/web_theme.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({Key? key, required this.message, this.isUser = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: EdgeInsets.only(
          bottom: 12,
          right: isUser ? 0 : 48,
          left: isUser ? 48 : 0,
        ),
        borderRadius: WebTheme.radiusMedium,
        backgroundColor: isUser
            ? WebTheme.primaryGradientStart.withOpacity(0.3)
            : Colors.white.withOpacity(0.08),
        border: Border.all(
          color: isUser
              ? WebTheme.primaryGradientStart.withOpacity(0.5)
              : Colors.white.withOpacity(0.15),
          width: 1,
        ),
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: WebTheme.textPrimary,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class ChatWindow extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const ChatWindow({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: 350,
      height: 280,
      padding: const EdgeInsets.all(16),
      borderRadius: WebTheme.radiusXL,
      backgroundColor: Colors.black.withOpacity(0.3),
      child: Column(
        children: [
          // Header with dots
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                Row(
                  children: List.generate(
                    3,
                    (i) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: WebTheme.primaryGradientStart.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white, height: 0.5, thickness: 0.5),
          // Messages
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: messages
                      .map(
                        (msg) => ChatBubble(
                          message: msg['text'],
                          isUser: msg['isUser'] ?? false,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
