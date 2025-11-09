import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/persona.dart';

class PersonaCard extends StatefulWidget {
  final Persona persona;
  final VoidCallback onTap;

  const PersonaCard({Key? key, required this.persona, required this.onTap})
    : super(key: key);

  @override
  State<PersonaCard> createState() => _PersonaCardState();
}

class _PersonaCardState extends State<PersonaCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _elevationAnimation = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovering) {
    if (isHovering) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  /// Build background image - supports both asset and network images
  Widget _buildBackgroundImage(String imagePath) {
    final isAsset = imagePath.startsWith('assets/');

    if (isAsset) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.persona.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          );
        },
      );
    } else {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.persona.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) {
          _animationController.reverse();
          widget.onTap();
        },
        onTapCancel: () => _animationController.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedBuilder(
            animation: _elevationAnimation,
            builder: (context, child) {
              return SizedBox(
                width: 180,
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                  elevation: _elevationAnimation.value,
                  shadowColor: widget.persona.gradient[0].withOpacity(0.5),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      // Blurred background image
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Opacity(
                            opacity: 0.9,
                            child: _buildBackgroundImage(widget.persona.image),
                          ),
                        ),
                      ),

                      // Gradient overlay from bottom to top - theme aware
                      Positioned.fill(
                        child: Builder(
                          builder: (context) {
                            final isDark =
                                Theme.of(context).brightness == Brightness.dark;
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: isDark
                                      ? [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.3),
                                          Colors.black.withOpacity(0.6),
                                        ]
                                      : [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.5),
                                          Colors.black.withOpacity(0.8),
                                        ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.2)
                                      : Colors.black.withOpacity(0.1),
                                  width: 1.5,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Category badge at top
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            widget.persona.category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),

                      // Text info on top - positioned at bottom
                      Positioned(
                        left: 14,
                        right: 14,
                        bottom: 14,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Name with shadow
                            Text(
                              widget.persona.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            // Description with shadow
                            Text(
                              widget.persona.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12,
                                height: 1.3,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Interactive overlay on tap
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(onTap: widget.onTap),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
