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
  bool _isCheckingUpdate = false;
  bool _isPro = false; // Track if user has pro subscription

  void _changeTheme(ThemeMode themeMode) {
    final themeService = ThemeService();
    themeService.setThemeMode(themeMode);
  }

  Future<void> _checkForUpdate() async {
    setState(() {
      _isCheckingUpdate = true;
    });

    try {
      // Simulate checking for updates
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Check if update is available
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to check for updates: $e'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCheckingUpdate = false;
        });
      }
    }
  }

  Future<void> _upgradeToPro() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🚀 Upgrade to Pro'),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Unlock Premium Features:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Text('✓ Unlimited chat messages'),
                SizedBox(height: 8),
                Text('✓ Advanced AI personas'),
                SizedBox(height: 8),
                Text('✓ Priority support'),
                SizedBox(height: 8),
                Text('✓ Custom themes'),
                SizedBox(height: 8),
                Text('✓ Ad-free experience'),
                SizedBox(height: 16),
                Text(
                  'Pricing: \$9.99/month or \$79.99/year',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _processSubscription();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB38CFF),
              ),
              child: const Text(
                'Upgrade Now',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _processSubscription() async {
    // Payment processing parameters
    final subscriptionDetails = {
      'productId': 'ai_persona_pro_monthly', // Monthly subscription
      'productIdYearly': 'ai_persona_pro_yearly', // Yearly subscription
      'price': 9.99,
      'priceYearly': 79.99,
      'currency': 'USD',
      'description': 'Premium access to AI Persona',
      'features': [
        'Unlimited chat messages',
        'Advanced AI personas',
        'Priority support',
        'Custom themes',
        'Ad-free experience',
      ],
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPricingCard(
                plan: 'Monthly',
                price: '\$${subscriptionDetails['price']}',
                period: '/month',
                productId: subscriptionDetails['productId'] as String,
              ),
              const SizedBox(height: 16),
              _buildPricingCard(
                plan: 'Yearly',
                price: '\$${subscriptionDetails['priceYearly']}',
                period: '/year (Save 33%)',
                productId: subscriptionDetails['productIdYearly'] as String,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPricingCard({
    required String plan,
    required String price,
    required String period,
    required String productId,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFB38CFF)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            plan,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB38CFF),
            ),
          ),
          Text(
            period,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Integrate with payment gateway (Stripe, RevenueCat, etc.)
              _handlePayment(productId, plan);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB38CFF),
            ),
            child: const Text(
              'Subscribe',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePayment(String productId, String planName) async {
    // Payment processing logic
    // TODO: Integrate with payment gateway (Stripe, RevenueCat, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Processing $planName subscription (Product: $productId)...',
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isPro = true;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉 Successfully upgraded to Pro!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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

  Widget _buildProCard(bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFB38CFF).withOpacity(0.2),
            const Color(0xFF7DE2FF).withOpacity(0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFB38CFF).withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB38CFF).withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFB38CFF), size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isPro ? '✓ Pro Member' : 'Upgrade to Pro',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isPro
                            ? Colors.green
                            : (isDark ? Colors.white : Colors.black87),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _isPro
                          ? 'Enjoy unlimited features'
                          : 'Get unlimited chats & premium features',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? Colors.white.withOpacity(0.6)
                            : Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!_isPro) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _upgradeToPro,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB38CFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Upgrade Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
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
    final isDisabled = onTap == null;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: InkWell(
          onTap: onTap,
          child: Opacity(
            opacity: isDisabled ? 0.6 : 1.0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  //const SizedBox(width: 16),
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
                  // Icon(
                  //   Icons.chevron_right,
                  //   color: isDark
                  //       ? Colors.white.withOpacity(0.3)
                  //       : Colors.black.withOpacity(0.3),
                  // ),
                ],
              ),
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
          // decoration: BoxDecoration(
          //   color: isDark
          //       ? Colors.white.withOpacity(0.08)
          //       : Colors.white.withOpacity(0.5),
          //   borderRadius: BorderRadius.circular(20),
          //   border: Border.all(
          //     color: isDark
          //         ? Colors.white.withOpacity(0.1)
          //         : Colors.black.withOpacity(0.1),
          //   ),
          // ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Toggle dark theme',
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
              GestureDetector(
                onTap: () {
                  _changeTheme(isDark ? ThemeMode.light : ThemeMode.dark);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: 70,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: isDark
                        ? const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ).withOpacity(0.3)
                        : const Color(0xFFFFB800).withOpacity(0.2),
                    border: Border.all(
                      color: isDark
                          ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6)
                          : const Color(0xFFFFB800).withOpacity(0.6),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isDark
                            ? const Color.fromARGB(
                                255,
                                0,
                                0,
                                0,
                              ).withOpacity(0.2)
                            : const Color(0xFFFFB800).withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background track
                      Container(
                        width: 70,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      // Animated toggle button
                      AnimatedAlign(
                        alignment: isDark
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color(0xFFFFB800),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? const Color.fromARGB(
                                        255,
                                        0,
                                        0,
                                        0,
                                      ).withOpacity(0.5)
                                    : const Color(0xFFFFB800).withOpacity(0.5),
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: Icon(
                                isDark ? Icons.nights_stay : Icons.wb_sunny,
                                key: ValueKey<bool>(isDark),
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
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
              _buildSectionHeader('Subscription', isDark),
              _buildProCard(isDark),
              _buildThemeSwitcher(isDark),

              _buildSectionHeader('Help & About', isDark),
              _buildGlassSettingTile(
                icon: Icons.system_update_outlined,
                title: 'Check Update',
                subtitle: _isCheckingUpdate
                    ? 'Checking for updates...'
                    : 'Check for app updates',
                gradient: const [Color(0xFFB38CFF), Color(0xFF7DE2FF)],
                isDark: isDark,
                onTap: _isCheckingUpdate ? null : _checkForUpdate,
              ),
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
