import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';

class NavbarWidget extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onHomePressed;

  const NavbarWidget({
    Key? key,
    required this.onLoginPressed,
    required this.onHomePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: onHomePressed,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Text(
                'AI Personas',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.w700,
                  color: WebTheme.textPrimary,
                ),
              ),
            ),
          ),
          const Spacer(),
          // Navigation links (desktop)
          if (!isMobile) ...[
            _buildNavLink('Features'),
            const SizedBox(width: 32),
            _buildNavLink('How It Works'),
            const SizedBox(width: 32),
            _buildNavLink('About'),
            const SizedBox(width: 48),
          ],
          // Login button
          GestureDetector(
            onTap: onLoginPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    WebTheme.primaryGradientStart.withOpacity(0.8),
                    WebTheme.primaryGradientEnd.withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                isMobile ? 'Login' : 'Sign In',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavLink(String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: WebTheme.textSecondary,
        ),
      ),
    );
  }
}
