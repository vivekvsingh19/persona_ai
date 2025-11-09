import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ai_persona/services/google_auth_service.dart';
import 'package:ai_persona/services/theme_service.dart';
import 'package:ai_persona/screens/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _changeTheme(ThemeMode themeMode) {
    final themeService = ThemeService();
    themeService.setThemeMode(themeMode);

    String themeName = themeMode == ThemeMode.light
        ? 'Light Theme'
        : themeMode == ThemeMode.dark
        ? 'Dark Theme'
        : 'System Theme';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Switched to $themeName'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 24),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white70 : Colors.black54,
        ),
      ),
    );
  }

  Widget _buildGlassSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),

            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: gradient[0].withOpacity(0.5),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? Colors.white.withOpacity(0.6)
                              : Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark
                      ? Colors.white.withOpacity(0.3)
                      : Colors.black.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSwitcher(bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFB38CFF), Color(0xFF7DE2FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFB38CFF),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.brush_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Theme',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Choose your preferred theme',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? Colors.white.withOpacity(0.6)
                              : Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildThemeButton(
                      label: 'Light',
                      icon: Icons.light_mode,
                      isSelected: !isDark,
                      isDark: isDark,
                      onTap: () {
                        _changeTheme(ThemeMode.light);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildThemeButton(
                      label: 'Dark',
                      icon: Icons.dark_mode,
                      isSelected: isDark,
                      isDark: isDark,
                      onTap: () {
                        _changeTheme(ThemeMode.dark);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildThemeButton(
                      label: 'System',
                      icon: Icons.settings_suggest,
                      isSelected: false,
                      isDark: isDark,
                      onTap: () {
                        _changeTheme(ThemeMode.system);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFB38CFF).withOpacity(0.3)
              : isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFB38CFF)
                : isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFFB38CFF)
                  : isDark
                  ? Colors.white.withOpacity(0.6)
                  : Colors.black.withOpacity(0.6),
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFFB38CFF)
                    : isDark
                    ? Colors.white.withOpacity(0.6)
                    : Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFFF5F5),
      appBar: AppBar(
        backgroundColor: isDark
            ? const Color(0xFF121212)
            : const Color(0xFFFFF5F5),
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16).copyWith(bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Account', isDark),
              _buildGlassSettingTile(
                icon: Icons.person_outline,
                title: 'Profile',
                subtitle: 'Manage your profile information',
                gradient: const [Color(0xFF4E9FFF), Color(0xFF6C63FF)],
                isDark: isDark,
                onTap: () {},
              ),
              _buildGlassSettingTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Configure notification preferences',
                gradient: const [Color(0xFFFF4C6C), Color(0xFFFF9A6C)],
                isDark: isDark,
                onTap: () {},
              ),
              _buildSectionHeader('Appearance', isDark),
              _buildThemeSwitcher(isDark),

              _buildSectionHeader('Help & About', isDark),
              _buildGlassSettingTile(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App information and legal',
                gradient: const [Color(0xFFB38CFF), Color(0xFF7DE2FF)],
                isDark: isDark,
                onTap: () {},
              ),
              _buildGlassSettingTile(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help and contact support',
                gradient: const [Color(0xFFB38CFF), Color(0xFF7DE2FF)],
                isDark: isDark,
                onTap: () {},
              ),
              const SizedBox(height: 10),

              // Sign Out Button
              _buildGlassSettingTile(
                icon: Icons.logout,
                title: 'Sign Out',
                subtitle: 'Logout from your account',
                gradient: const [Color(0xFFFF4C6C), Color(0xFFFF9A6C)],
                isDark: isDark,
                onTap: () async {
                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Sign Out'),
                        content: const Text(
                          'Are you sure you want to sign out?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await GoogleAuthService.signOut();
                              if (context.mounted) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? Colors.white.withOpacity(0.4)
                        : Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
