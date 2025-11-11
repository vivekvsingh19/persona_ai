import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/web_theme.dart';

class PersonaCard extends StatefulWidget {
  final String title;
  final String description;
  final String? imageAsset;
  final VoidCallback? onTap;
  final bool isFeatured;

  const PersonaCard({
    Key? key,
    required this.title,
    required this.description,
    this.imageAsset,
    this.onTap,
    this.isFeatured = false,
  }) : super(key: key);

  @override
  State<PersonaCard> createState() => _PersonaCardState();
}

class _PersonaCardState extends State<PersonaCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  transform: Matrix4.identity()
                    ..translate(0, isHovered ? -8 : 0, 0)
                    ..scale(isHovered ? 1.02 : 1.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                    boxShadow: isHovered
                        ? [
                            BoxShadow(
                              color: const Color(0xFF6C5BFF).withOpacity(0.4),
                              blurRadius: 24,
                              spreadRadius: 0,
                              offset: const Offset(0, 12),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 16,
                              spreadRadius: -2,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              spreadRadius: -2,
                            ),
                          ],
                    border: Border.all(
                      color: isHovered
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white.withOpacity(0.12),
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                    child: Stack(
                      children: [
                        // Background gradient
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.03),
                                Colors.white.withOpacity(0.01),
                              ],
                            ),
                          ),
                        ),
                        // Content
                        if (widget.isFeatured)
                          _buildFeaturedLayout()
                        else
                          _buildCompactLayout(),
                      ],
                    ),
                  ),
                )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(
                  duration: const Duration(milliseconds: 2000),
                  color: Colors.white.withOpacity(0.1),
                ),
      ),
    );
  }

  Widget _buildFeaturedLayout() {
    return Column(
      children: [
        // Image area
        if (widget.imageAsset != null)
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    WebTheme.primaryGradientStart.withOpacity(0.3),
                    WebTheme.primaryGradientEnd.withOpacity(0.2),
                  ],
                ),
              ),
              child: Center(
                child: Image.asset(widget.imageAsset!, fit: BoxFit.cover),
              ),
            ),
          ),
        // Text area
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: WebTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: WebTheme.textSecondary,
                        height: 1.4,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: WebTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(WebTheme.radiusSmall),
                  ),
                  child: Text(
                    'Explore',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: WebTheme.primaryGradient,
              borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: WebTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: WebTheme.textSecondary,
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
