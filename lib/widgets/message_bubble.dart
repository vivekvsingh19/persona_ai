import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final theme = Theme.of(context).colorScheme;

    final bg = isUser ? theme.primary : theme.surfaceVariant.withOpacity(0.7);
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final textColor = isUser ? Colors.white : theme.onSurfaceVariant;

    final radius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular(isUser ? 20 : 4),
      bottomRight: Radius.circular(isUser ? 4 : 20),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Row(
            mainAxisAlignment: isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!isUser) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: theme.primaryContainer,
                  child: Icon(Iconsax.cpu, size: 18, color: theme.primary),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: radius,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: textColor,
                      height: 1.4,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              if (isUser) const SizedBox(width: 24),
            ],
          ),
          const SizedBox(height: 2),
          Padding(
            padding: EdgeInsets.only(
              left: isUser ? 0 : 48,
              right: isUser ? 12 : 0,
            ),
            child: Text(
              _formatTime(message.timestamp),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
