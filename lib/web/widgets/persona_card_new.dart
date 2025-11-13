import 'package:flutter/material.dart';
import 'glass_container.dart';
import '../theme/web_theme.dart';

class PersonaCard extends StatefulWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final String? imageAsset;
  final String? category;
  final VoidCallback? onTap;
  final bool isFeatured;
  final double width;
  final double height;
  final Alignment categoryAlignment;

  const PersonaCard({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.imageAsset,
    this.category,
    this.onTap,
    this.isFeatured = false,
    this.width = 280,
    this.height = 400,
    this.categoryAlignment = Alignment.topRight,
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()..translate(0, isHovered ? -12 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: WebTheme.primaryGradientStart.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 15),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: -2,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: GlassContainer(
            width: widget.width,
            height: widget.height,
            borderRadius: 24,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            blurSigma: 12,
            backgroundColor: Colors.white.withOpacity(0.05),
            border: Border.all(
              color: isHovered
                  ? WebTheme.primaryGradientStart.withOpacity(0.5)
                  : Colors.white.withOpacity(0.15),
              width: 1.5,
            ),
            child: Stack(
              children: [
                // Background image - fills entire card
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: widget.imageUrl != null
                        ? Image.network(
                            widget.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildGradientBackground();
                            },
                          )
                        : widget.imageAsset != null
                        ? Image.asset(
                            widget.imageAsset!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildGradientBackground();
                            },
                          )
                        : _buildGradientBackground(),
                  ),
                ),

                // Dark gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.75),
                        ],
                      ),
                    ),
                  ),
                ),

                // Content with category badge at top and text at bottom
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top category badge
                        if (widget.category != null)
                          Align(
                            alignment: widget.categoryAlignment,
                            child: GlassContainer(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              margin: EdgeInsets.zero,
                              borderRadius: 12,
                              backgroundColor: Colors.black.withOpacity(0.6),
                              blurSigma: 10,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1,
                              ),
                              child: Text(
                                widget.category!,
                                style: Theme.of(context).textTheme.labelSmall!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          )
                        else
                          SizedBox.shrink(),

                        // Title and description at bottom
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.description,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    color: Colors.white.withOpacity(0.85),
                                    height: 1.4,
                                    fontWeight: FontWeight.w400,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            WebTheme.primaryGradientStart.withOpacity(0.4),
            WebTheme.primaryGradientEnd.withOpacity(0.2),
          ],
        ),
      ),
    );
  }
}
