import 'package:ai_persona/features/chat/presentation/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../domain/persona.dart';
import 'widgets/persona_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Persona> filteredPersonas = [];
  bool hasNotification = true;

  @override
  void initState() {
    super.initState();
    filteredPersonas = Persona.defaultPersonas;
  }

  // Get greeting based on current time
  String _getTimeBasedGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 5 && hour < 12) {
      return 'Good morning 🌅';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon ☀️';
    } else if (hour >= 17 && hour < 21) {
      return 'Good evening 🌆';
    } else {
      return 'Good night 🌙';
    }
  }

  void _onPersonaTap(BuildContext context, Persona persona) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(persona: persona.toMap()),
      ),
    );
  }

  Widget _buildTopBar() {
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? user?.email ?? 'User';
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 👤 Left: avatar + greeting
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      user?.photoURL ??
                          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getTimeBasedGreeting(),
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 🔍 + 🔔 right side icons
          Row(
            children: [
              // _buildCircleIcon(Iconsax.search_normal),
              // const SizedBox(width: 12),
              Stack(
                children: [
                  _buildCircleIcon(Iconsax.notification, isDark),
                  if (hasNotification)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF4C6C),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, bool isDark) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? Colors.grey[900] : Colors.white.withOpacity(0.85),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.black.withOpacity(0.1),
        ),
      ),
      child: Icon(
        icon,
        color: isDark ? Colors.grey[300] : Colors.black54,
        size: 26,
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isSelected, bool isDark) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (category == 'All') {
            filteredPersonas = Persona.defaultPersonas;
          } else {
            filteredPersonas = Persona.defaultPersonas
                .where((p) => p.category == category)
                .toList();
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: !isSelected
              ? Colors.transparent
              : isDark
              ? Color(0xFF2C2C2C)
              : Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? isDark
                      ? Colors.grey[700]!
                      : Colors.black.withOpacity(0.1)
                : Colors.transparent,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected
                ? isDark
                      ? Colors.grey[400]
                      : Colors.black87
                : isDark
                ? Colors.grey[200]
                : Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      ...Persona.defaultPersonas.map((p) => p.category).toSet().toList(),
    ];
    final selectedCategory =
        filteredPersonas.length == Persona.defaultPersonas.length
        ? 'All'
        : filteredPersonas.isNotEmpty
        ? filteredPersonas.first.category
        : 'All';

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFFF5F5),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed: Top bar
              _buildTopBar(),
              const SizedBox(height: 24),

              // Fixed: Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'AI Conversations\nThat Feel Alive',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    height: 1.3,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Scrollable: Everything below (Category + Cards)
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // 🏷️ Category chips - Scrollable
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 36,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: categories.map((cat) {
                              return _buildCategoryChip(
                                cat,
                                selectedCategory == cat,
                                isDark,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 24)),

                    // 💬 Persona cards - Scrollable
                    if (filteredPersonas.isNotEmpty)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ).copyWith(bottom: 80),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 16,
                              ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => PersonaCard(
                              persona: filteredPersonas[index],
                              onTap: () => _onPersonaTap(
                                context,
                                filteredPersonas[index],
                              ),
                            ),
                            childCount: filteredPersonas.length,
                          ),
                        ),
                      )
                    else
                      SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'No companions found',
                            style: TextStyle(
                              color: isDark ? Colors.grey[600] : Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
