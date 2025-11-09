// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import '../models/persona.dart';
// import '../theme/app_theme.dart';

// class PersonaCard extends StatelessWidget {
//   final Persona persona;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final bool isCompact;

//   const PersonaCard({
//     super.key,
//     required this.persona,
//     required this.isSelected,
//     required this.onTap,
//     this.isCompact = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (isCompact) {
//       return _buildCompactCard(context);
//     }
//     return _buildFullCard(context);
//   }

//   Widget _buildFullCard(BuildContext context) {
//     return GlassContainer(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       color: isSelected ? persona.color : Colors.white,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(24),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               _buildAvatar(size: 60),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           persona.name,
//                           style: Theme.of(context).textTheme.titleLarge
//                               ?.copyWith(
//                                 color: isSelected ? Colors.white : null,
//                               ),
//                         ),
//                         const SizedBox(width: 8),
//                         if (persona.isOnline)
//                           Container(
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               color: Colors.green,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       persona.specialty ?? '',
//                       style: TextStyle(
//                         color: isSelected
//                             ? Colors.white.withOpacity(0.9)
//                             : Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(
//                           Iconsax.star1,
//                           size: 16,
//                           color: isSelected
//                               ? Colors.white
//                               : const Color(0xFFFFB800),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           persona.rating.toString(),
//                           style: TextStyle(
//                             color: isSelected ? Colors.white : Colors.grey[700],
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         ...persona.tags
//                             .take(2)
//                             .map(
//                               (tag) => Container(
//                                 margin: const EdgeInsets.only(right: 8),
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 8,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: isSelected
//                                       ? Colors.white.withOpacity(0.2)
//                                       : persona.color.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Text(
//                                   tag,
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: isSelected
//                                         ? Colors.white
//                                         : persona.color,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                       ],
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

//   Widget _buildCompactCard(BuildContext context) {
//     return GlassContainer(
//       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       color: isSelected ? persona.color : Colors.white,
//       padding: const EdgeInsets.all(12),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(24),
//         child: Row(
//           children: [
//             _buildAvatar(size: 40),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     persona.name,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: isSelected ? Colors.white : null,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     persona.specialty ?? '',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: isSelected
//                           ? Colors.white.withOpacity(0.9)
//                           : Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAvatar({required double size}) {
//     if (persona.imageUrl != null) {
//       return Container(
//         width: size,
//         height: size,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           image: DecorationImage(
//             image: AssetImage(persona.imageUrl!),
//             fit: BoxFit.cover,
//           ),
//           border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
//           boxShadow: [
//             BoxShadow(
//               color: persona.color.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//       );
//     }

//     return CircleAvatar(
//       radius: size / 2,
//       backgroundColor: persona.color.withOpacity(0.1),
//       child: Icon(persona.icon, color: persona.color, size: size * 0.5),
//     );
//   }
// }
