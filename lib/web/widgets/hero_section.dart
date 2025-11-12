import 'package:flutter/material.dart';
import '../theme/web_theme.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onStartChat;
  final VoidCallback onExplorePersonas;

  const HeroSection({
    Key? key,
    required this.onStartChat,
    required this.onExplorePersonas,
  }) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool isStartChatHovered = false;
  bool isExploreHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 60,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Title
          Text(
            'AI Conversations\nThat Feel Alive',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: isMobile ? 26 : null,
              color: WebTheme.textPrimary,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          // Subtitle
          SizedBox(
            width: isMobile ? double.infinity : 600,
            child: Text(
              'Talk to AI mentors, coaches, and friends who understand you — anytime, anywhere.',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: WebTheme.textSecondary,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Buttons
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Start Chatting Button
                MouseRegion(
                  onEnter: (_) => setState(() => isStartChatHovered = true),
                  onExit: (_) => setState(() => isStartChatHovered = false),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: WebTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                      boxShadow: isStartChatHovered
                          ? [
                              BoxShadow(
                                color: WebTheme.primaryGradientStart
                                    .withOpacity(0.6),
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: const Offset(0, 10),
                              ),
                            ]
                          : [],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onStartChat,
                        borderRadius: BorderRadius.circular(
                          WebTheme.radiusLarge,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Text(
                            'Start Chatting',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Explore Personas Button
                MouseRegion(
                  onEnter: (_) => setState(() => isExploreHovered = true),
                  onExit: (_) => setState(() => isExploreHovered = false),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isExploreHovered
                            ? WebTheme.textPrimary
                            : WebTheme.textSecondary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                      color: isExploreHovered
                          ? Colors.white.withOpacity(0.05)
                          : Colors.transparent,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onExplorePersonas,
                        borderRadius: BorderRadius.circular(
                          WebTheme.radiusLarge,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Text(
                            'Explore Personas',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  color: isExploreHovered
                                      ? WebTheme.textPrimary
                                      : WebTheme.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // Start Chatting Button
                MouseRegion(
                  onEnter: (_) => setState(() => isStartChatHovered = true),
                  onExit: (_) => setState(() => isStartChatHovered = false),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: WebTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                      boxShadow: isStartChatHovered
                          ? [
                              BoxShadow(
                                color: WebTheme.primaryGradientStart
                                    .withOpacity(0.6),
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: const Offset(0, 10),
                              ),
                            ]
                          : [],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onStartChat,
                        borderRadius: BorderRadius.circular(
                          WebTheme.radiusLarge,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: Text(
                            'Start Chatting',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Explore Personas Button
                MouseRegion(
                  onEnter: (_) => setState(() => isExploreHovered = true),
                  onExit: (_) => setState(() => isExploreHovered = false),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isExploreHovered
                            ? WebTheme.textPrimary
                            : WebTheme.textSecondary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                      color: isExploreHovered
                          ? Colors.white.withOpacity(0.05)
                          : Colors.transparent,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onExplorePersonas,
                        borderRadius: BorderRadius.circular(
                          WebTheme.radiusLarge,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: Text(
                            'Explore Personas',
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  color: isExploreHovered
                                      ? WebTheme.textPrimary
                                      : WebTheme.textSecondary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
