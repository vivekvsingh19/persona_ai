// ============================================
// FLUTTER UI COMPONENT TEMPLATES
// ============================================
// Add these as separate files in lib/widgets/

import 'package:flutter/material.dart';

// ============================================
// 1. MESSAGE BUBBLE WIDGET
// ============================================
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;
  final DateTime timestamp;
  final String? senderName;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isUserMessage,
    required this.timestamp,
    this.senderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final timeString =
        '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUserMessage
              ? Colors.blue.shade500
              : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: isUserMessage
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!isUserMessage && senderName != null)
              Text(senderName!, style: Theme.of(context).textTheme.labelSmall),
            Text(
              message,
              style: TextStyle(
                color: isUserMessage ? Colors.white : Colors.black87,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              timeString,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isUserMessage ? Colors.white70 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// 2. CHAT INPUT FIELD WIDGET
// ============================================
class ChatInputField extends StatefulWidget {
  final Function(String) onSend;
  final bool isLoading;
  final TextEditingController? controller;

  const ChatInputField({
    Key? key,
    required this.onSend,
    this.isLoading = false,
    this.controller,
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSend(_controller.text.trim());
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !widget.isLoading,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          FloatingActionButton(
            onPressed: widget.isLoading ? null : _sendMessage,
            mini: true,
            child: widget.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

// ============================================
// 3. PERSONA CARD WIDGET
// ============================================
class PersonaCard extends StatelessWidget {
  final String id;
  final String name;
  final String avatar;
  final String description;
  final VoidCallback onSelect;
  final bool isSelected;

  const PersonaCard({
    Key? key,
    required this.id,
    required this.name,
    required this.avatar,
    required this.description,
    required this.onSelect,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 8.0 : 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: isSelected
            ? const BorderSide(color: Colors.blue, width: 2.0)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, backgroundImage: AssetImage(avatar)),
            const SizedBox(height: 12.0),
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: onSelect,
              child: Text(isSelected ? 'Selected' : 'Select'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// 4. CHAT LIST WIDGET
// ============================================
class ChatListView extends StatelessWidget {
  final List<dynamic> messages;
  final bool isLoading;
  final VoidCallback? onLoadMore;
  final ScrollController? scrollController;

  const ChatListView({
    Key? key,
    required this.messages,
    this.isLoading = false,
    this.onLoadMore,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16.0),
            Text(
              'No messages yet',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Start a conversation with the AI persona',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      itemCount: messages.length + (isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (isLoading && index == 0) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final messageIndex = isLoading ? index - 1 : index;
        // Replace this with actual MessageBubble when message model is imported
        return Container();
      },
    );
  }
}

// ============================================
// 5. LOADING INDICATOR WIDGET
// ============================================
class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16.0),
            Text(message!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}

// ============================================
// 6. EMPTY STATE WIDGET
// ============================================
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? action;

  const EmptyStateWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16.0),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[const SizedBox(height: 24.0), action!],
        ],
      ),
    );
  }
}

// ============================================
// USAGE EXAMPLES IN COMMENTS
// ============================================

/*
// Example 1: MessageBubble
MessageBubble(
  message: "Hello, how can I help you?",
  isUserMessage: false,
  timestamp: DateTime.now(),
  senderName: "The Mentor",
)

// Example 2: ChatInputField
ChatInputField(
  onSend: (message) {
    print("User sent: $message");
  },
  isLoading: false,
)

// Example 3: PersonaCard in GridView
GridView.count(
  crossAxisCount: 2,
  children: personas.map((persona) {
    return PersonaCard(
      id: persona.id,
      name: persona.name,
      avatar: persona.avatar,
      description: persona.description,
      onSelect: () {
        // Handle persona selection
      },
      isSelected: selectedPersonaId == persona.id,
    );
  }).toList(),
)

// Example 4: LoadingIndicator
if (isLoading) {
  LoadingIndicator(message: "Waiting for response...")
}

// Example 5: EmptyStateWidget
EmptyStateWidget(
  icon: Icons.chat_bubble_outline,
  title: "No Conversations",
  subtitle: "Start a new conversation with an AI persona",
  action: ElevatedButton(
    onPressed: () {},
    child: const Text("Select Persona"),
  ),
)
*/
