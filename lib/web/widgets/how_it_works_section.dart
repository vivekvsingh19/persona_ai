import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import 'glass_container.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    final steps = [
      {
        'title': 'Pick Your AI Persona',
        'emoji': '🎭',
        'description':
            'Choose from Crush, Friend, Mentor, or more — each with a unique personality and vibe.',
      },
      {
        'title': 'Start Chatting',
        'emoji': '💬',
        'description':
            'Jump into natural, expressive conversations. Each persona responds in its own tone and style.',
      },
      {
        'title': 'Build a Connection',
        'emoji': '🧠',
        'description':
            'Your AI remembers context and gets better with every chat - forming a deeper bond over time.',
      },
      {
        'title': 'Switch Anytime',
        'emoji': '🔄',
        'description':
            'Feeling different? Instantly switch between personas anytime — your chats are saved safely.',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'How It Works',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 44,
              fontWeight: FontWeight.w700,
              color: WebTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Experience your AI world in 4 simple steps',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: WebTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 80),

          // Responsive layout
          isMobile
              ? _buildVerticalSteps(steps)
              : _buildZigZagHorizontalSteps(steps),
        ],
      ),
    );
  }

  /// DESKTOP — Zig-Zag Layout (One up, one down)
  Widget _buildZigZagHorizontalSteps(List<Map<String, String>> steps) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Connector line
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      WebTheme.primaryGradientStart.withOpacity(0.4),
                      WebTheme.primaryGradientEnd.withOpacity(0.4),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Steps
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(steps.length, (index) {
              final step = steps[index];
              final isTop = index % 2 == 0;

              return Expanded(
                child: Column(
                  mainAxisAlignment: isTop
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isTop)
                      _buildStepCard(
                        title: step['title']!,
                        description: step['description']!,
                        emoji: step['emoji']!,
                      ),
                    if (isTop) const SizedBox(height: 40),
                    _buildStepCircle(step['emoji']!),
                    if (!isTop) const SizedBox(height: 40),
                    if (!isTop)
                      _buildStepCard(
                        title: step['title']!,
                        description: step['description']!,
                        emoji: step['emoji']!,
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// MOBILE — Vertical Layout
  Widget _buildVerticalSteps(List<Map<String, String>> steps) {
    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Column(
            children: [
              _buildStepCircle(step['emoji']!),
              const SizedBox(height: 20),
              _buildStepCard(
                title: step['title']!,
                description: step['description']!,
                emoji: step['emoji']!,
              ),
            ],
          ),
        );
      }),
    );
  }

  /// Step Circle (Glowing Center)
  Widget _buildStepCircle(String emoji) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow aura
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                WebTheme.primaryGradientStart.withOpacity(0.2),
                WebTheme.primaryGradientEnd.withOpacity(0.05),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Core circle
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                WebTheme.primaryGradientStart,
                WebTheme.primaryGradientEnd,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: WebTheme.primaryGradientStart.withOpacity(0.4),
                blurRadius: 25,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 28)),
          ),
        ),
      ],
    );
  }

  /// Step Card (Now rounded and wide — not square)
  Widget _buildStepCard({
    required String title,
    required String description,
    required String emoji,
  }) {
    return GlassContainer(
      borderRadius: 40, // much more rounded corners
      blurSigma: 12,
      backgroundColor: Colors.white.withOpacity(0.05),
      border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      child: SizedBox(
        width: 250, // makes it wider, not square
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: WebTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: WebTheme.textSecondary,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
