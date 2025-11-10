import 'package:ai_persona/features/chat/presentation/chat_history_screen.dart';
import 'package:ai_persona/features/home/presentation/home_screen.dart';
import 'package:ai_persona/features/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatHistoryScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFFFF5F5),
      body: Stack(
        children: [
          // Main screens
          IndexedStack(index: _selectedIndex, children: _screens),

          // Floating Navigation Bar
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.black.withOpacity(0.54)
                    : Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Iconsax.home, 0),
                  _buildNavItem(Iconsax.message, 1),
                  _buildNavItem(Iconsax.setting_2, 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // decoration: isSelected
        //     ? BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: const Color(0xFFFF8DC7).withOpacity(0.2),
        //       )
        //     : null,
        // child: Padding(
        //   padding: isSelected ? const EdgeInsets.all(8) : EdgeInsets.zero,
        child: Icon(
          icon,
          size: 28,
          color: isSelected
              ? const Color(0xFFFF8DC7)
              : isDark
              ? Colors.white.withOpacity(0.6)
              : Colors.black.withOpacity(0.5),
          //  ),
        ),
      ),
    );
  }
}
