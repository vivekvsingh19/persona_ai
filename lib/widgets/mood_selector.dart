import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../theme/app_theme.dart';

class MoodSelector extends StatelessWidget {
  final void Function(String) onMoodSelected;
  final String? selectedMood;

  const MoodSelector({
    super.key,
    required this.onMoodSelected,
    this.selectedMood,
  });

  @override
  Widget build(BuildContext context) {
    final moods = [
      _Mood('calm', 'Calm', Iconsax.coffee),
      _Mood('happy', 'Happy', Iconsax.emoji_happy),
      _Mood('anxious', 'Anxious', Iconsax.heart),
      _Mood('sad', 'Sad', Iconsax.emoji_sad),
      _Mood('energetic', 'Energetic', Iconsax.flash),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            'How are you feeling today?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 54,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: moods.length,
            itemBuilder: (context, index) {
              final mood = moods[index];
              final isSelected = selectedMood == mood.id;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GlassContainer(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () => onMoodSelected(mood.id),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            mood.icon,
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            mood.label,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onSurface,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Mood {
  final String id;
  final String label;
  final IconData icon;

  const _Mood(this.id, this.label, this.icon);
}
