// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import '../controllers/chat_controller.dart';
// import '../models/nav_item.dart';
// import '../models/persona.dart';
// import '../models/message.dart';
// import '../widgets/message_bubble.dart';
// import '../widgets/mood_selector.dart';
// import '../widgets/persona_card.dart';
// import '../theme/app_theme.dart';

// class ModernChatScreen extends StatefulWidget {
//   final ChatController controller;

//   const ModernChatScreen({super.key, required this.controller});

//   @override
//   State<ModernChatScreen> createState() => _ModernChatScreenState();
// }

// class _ModernChatScreenState extends State<ModernChatScreen> {
//   final TextEditingController _input = TextEditingController();
//   final ScrollController _scroll = ScrollController();
//   String? _selectedMood;

//   void _send() {
//     final text = _input.text;
//     if (text.trim().isEmpty) return;
//     widget.controller.sendUserMessage(text);
//     _input.clear();
//     Future.delayed(const Duration(milliseconds: 300), () {
//       if (_scroll.hasClients) {
//         _scroll.animateTo(
//           _scroll.position.maxScrollExtent + 120,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   void _onMoodSelected(String mood) {
//     setState(() => _selectedMood = mood);
//   }

//   @override
//   void dispose() {
//     _input.dispose();
//     _scroll.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           stops: const [0.0, 0.4, 0.8],
//           colors: [
//             const Color(0xFFFFE4E1),
//             const Color(0xFFFFF0F5),
//             const Color(0xFFFFF5FA),
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundColor: theme.colorScheme.primary.withOpacity(
//                         0.1,
//                       ),
//                       child: Icon(
//                         Iconsax.user,
//                         color: theme.colorScheme.primary,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Welcome back',
//                           style: theme.textTheme.bodySmall?.copyWith(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         Text(
//                           'Alex',
//                           style: theme.textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Iconsax.notification),
//                     ),
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Iconsax.setting_2),
//                     ),
//                   ],
//                 ),
//               ),

//               MoodSelector(
//                 onMoodSelected: _onMoodSelected,
//                 selectedMood: _selectedMood,
//               ),

//               Padding(
//                 padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
//                 child: Row(
//                   children: [
//                     Text('AI Personas', style: theme.textTheme.titleLarge),
//                     const Spacer(),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Row(
//                         children: [
//                           Text('View all'),
//                           SizedBox(width: 4),
//                           Icon(Iconsax.arrow_right_3, size: 16),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(
//                 height: 140,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   itemCount: widget.controller.personas.length,
//                   itemBuilder: (context, index) {
//                     final persona = widget.controller.personas[index];
//                     final isSelected =
//                         persona.id == widget.controller.currentPersona.id;
//                     return SizedBox(
//                       width: 280,
//                       child: PersonaCard(
//                         persona: persona,
//                         isSelected: isSelected,
//                         onTap: () => setState(
//                           () => widget.controller.switchPersona(persona.id),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               const SizedBox(height: 8),

//               Expanded(
//                 child: GlassContainer(
//                   margin: const EdgeInsets.all(16),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   child: AnimatedBuilder(
//                     animation: widget.controller,
//                     builder: (context, _) {
//                       final List<Message> msgs = widget.controller.messages;
//                       return ListView.builder(
//                         controller: _scroll,
//                         padding: const EdgeInsets.only(bottom: 8),
//                         itemCount: msgs.length,
//                         itemBuilder: (ctx, i) =>
//                             MessageBubble(message: msgs[i]),
//                       );
//                     },
//                   ),
//                 ),
//               ),

//               GlassContainer(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Iconsax.gallery),
//                       color: theme.colorScheme.primary,
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: TextField(
//                         controller: _input,
//                         textCapitalization: TextCapitalization.sentences,
//                         decoration: InputDecoration(
//                           hintText:
//                               'Message ${widget.controller.currentPersona.name}...',
//                           filled: true,
//                           fillColor: theme.colorScheme.surface,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(24),
//                             borderSide: BorderSide.none,
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 12,
//                           ),
//                         ),
//                         onSubmitted: (_) => _send(),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     FloatingActionButton(
//                       onPressed: _send,
//                       elevation: 0,
//                       backgroundColor: theme.colorScheme.primary,
//                       child: const Icon(Iconsax.send_1, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
