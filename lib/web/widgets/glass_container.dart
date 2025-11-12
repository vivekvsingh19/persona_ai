import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import '../theme/web_theme.dart';

/// Glass-morphism container widget
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final double blurSigma;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  const GlassContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = WebTheme.radiusLarge,
    this.blurSigma = 10,
    this.border,
    this.boxShadow,
    this.backgroundColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            Colors.white.withOpacity(0.08), // Glass effect color
        borderRadius: BorderRadius.circular(borderRadius),
        border:
            border ??
            Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: -2,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Glass button with gradient
class GlassButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final EdgeInsetsGeometry padding;

  const GlassButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
  }) : super(key: key);

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: isMobile
              ? const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
              : widget.padding,
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? WebTheme.primaryGradient
                : LinearGradient(
                    colors: [Colors.transparent, Colors.transparent],
                  ),
            borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
            border: !widget.isPrimary
                ? Border.all(
                    color: isHovered
                        ? WebTheme.textPrimary
                        : WebTheme.textSecondary,
                    width: 2,
                  )
                : null,
            boxShadow: widget.isPrimary && isHovered
                ? [
                    BoxShadow(
                      color: WebTheme.primaryGradientStart.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.text,
            style: GoogleFonts.poppins(
              color: WebTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 14 : 15,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
