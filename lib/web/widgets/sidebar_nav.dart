import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../theme/web_theme.dart';

class SidebarNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onNavigate;
  final VoidCallback onSignOut;

  const SidebarNav({
    Key? key,
    required this.currentIndex,
    required this.onNavigate,
    required this.onSignOut,
  }) : super(key: key);

  @override
  State<SidebarNav> createState() => _SidebarNavState();
}

class _SidebarNavState extends State<SidebarNav> {
  late List<NavItem> navItems;

  @override
  void initState() {
    super.initState();
    navItems = [
      NavItem(icon: Iconsax.home, label: 'Home'),
      NavItem(icon: Iconsax.messages, label: 'Chat'),
      NavItem(icon: Iconsax.people, label: 'Personas'),
      NavItem(icon: Iconsax.setting, label: 'Settings'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.1), width: 1.5),
        ),
      ),
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: WebTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                  ),
                  child: Center(
                    child: Text(
                      'AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Personas',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: WebTheme.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Chat with AI',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: WebTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
            height: 0.1,
            thickness: 0.1,
            indent: 24,
            endIndent: 24,
          ),
          // Navigation Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Column(
                children: List.generate(
                  navItems.length,
                  (index) => _buildNavItem(context, navItems[index], index),
                ),
              ),
            ),
          ),
          // Sign Out Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: widget.onSignOut,
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Sign Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: WebTheme.accentRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, NavItem item, int index) {
    final isActive = widget.currentIndex == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        gradient: isActive ? WebTheme.primaryGradient : null,
        borderRadius: BorderRadius.circular(WebTheme.radiusMedium),
        color: isActive ? null : Colors.white.withOpacity(0.05),
        border: Border.all(
          color: isActive
              ? Colors.white.withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => widget.onNavigate(index),
          borderRadius: BorderRadius.circular(WebTheme.radiusMedium),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 20,
                  color: isActive
                      ? Colors.white
                      : WebTheme.textSecondary.withOpacity(0.7),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.label,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: isActive
                          ? Colors.white
                          : WebTheme.textSecondary.withOpacity(0.7),
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
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
}

class NavItem {
  final IconData icon;
  final String label;

  NavItem({required this.icon, required this.label});
}
