import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import 'glass_container.dart';

class AppDownloadSection extends StatelessWidget {
  const AppDownloadSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      child: GlassContainer(
        borderRadius: 32,
        blurSigma: 12,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 60,
          vertical: isMobile ? 40 : 60,
        ),
        backgroundColor: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Main text
            Text(
              'Available on All Platforms',
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 28 : 40,
                fontWeight: FontWeight.w700,
                color: WebTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subtitle
            Text(
              'Download our app and take your AI conversations anywhere',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: WebTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            // Download buttons
            if (isMobile)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDownloadButton(
                    icon: '🍎',
                    label: 'Download on App Store',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  _buildDownloadButton(
                    icon: '▶️',
                    label: 'Get it on Google Play',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16),
                  _buildDownloadButton(
                    icon: '🌐',
                    label: 'Use on Web',
                    onPressed: () {},
                  ),
                ],
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDownloadButton(
                    icon: '🍎',
                    label: 'App Store',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _buildDownloadButton(
                    icon: '▶️',
                    label: 'Google Play',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _buildDownloadButton(
                    icon: '🌐',
                    label: 'Web App',
                    onPressed: () {},
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton({
    required String icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                WebTheme.primaryGradientStart.withOpacity(0.8),
                WebTheme.primaryGradientEnd.withOpacity(0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: WebTheme.primaryGradientStart.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
