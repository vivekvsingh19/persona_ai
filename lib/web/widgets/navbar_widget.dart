import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import '../../services/web_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class NavbarWidget extends StatefulWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onHomePressed;

  const NavbarWidget({
    Key? key,
    required this.onLoginPressed,
    required this.onHomePressed,
  }) : super(key: key);

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late Stream<User?> _authStream;

  @override
  void initState() {
    super.initState();
    _authStream = WebAuthService.authStateChanges();
  }

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
            onTap: widget.onHomePressed,
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
          // Login button or user profile
          StreamBuilder<User?>(
            stream: _authStream,
            builder: (context, snapshot) {
              final user = snapshot.data;

              if (user != null) {
                // User is logged in - show profile
                return _buildUserProfile(user, isMobile);
              } else {
                // User is not logged in - show login button
                return GestureDetector(
                  onTap: widget.onLoginPressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
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
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile(User user, bool isMobile) {
    // Generate Gravatar URL from email
    final String email = (user.email ?? '').trim().toLowerCase();
    final String gravatarHash = md5.convert(utf8.encode(email)).toString();
    final String gravatarUrl =
        'https://www.gravatar.com/avatar/$gravatarHash?s=200&d=identicon';

    return PopupMenuButton<String>(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User avatar from Gravatar
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  gravatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to initial avatar if Gravatar fails
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            WebTheme.primaryGradientStart,
                            WebTheme.primaryGradientEnd,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          (user.displayName?.isNotEmpty ?? false)
                              ? user.displayName![0].toUpperCase()
                              : user.email?[0].toUpperCase() ?? '👤',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.displayName ?? 'User',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: WebTheme.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.email ?? '',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: WebTheme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(width: 4),
            Icon(Icons.expand_more, color: WebTheme.textSecondary, size: 18),
          ],
        ),
      ),
      onSelected: (String value) async {
        if (value == 'logout') {
          await WebAuthService.signOut();
          if (mounted) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/login', (route) => false);
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person, size: 18, color: WebTheme.textPrimary),
              const SizedBox(width: 8),
              Text('Profile', style: GoogleFonts.inter(fontSize: 13)),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings, size: 18, color: WebTheme.textPrimary),
              const SizedBox(width: 8),
              Text('Settings', style: GoogleFonts.inter(fontSize: 13)),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 18, color: Color(0xFFFF6B6B)),
              const SizedBox(width: 8),
              Text(
                'Logout',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Color(0xFFFF6B6B),
                ),
              ),
            ],
          ),
        ),
      ],
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
