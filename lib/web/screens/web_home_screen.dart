import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme/web_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/persona_card_new.dart';
import '../widgets/how_it_works_section.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/app_download_section.dart';
import '../widgets/footer_widget.dart';
import '../widgets/navbar_widget.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  late ScrollController _scrollController;
  final GlobalKey _chooseSectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Featured personas with images
  final List<Map<String, String>> featuredPersonas = [
    {
      'title': 'Professional Mentor',
      'description': 'Career guidance\nand skill growth',
      'category': 'Career',
      'imageAsset': 'assets/images/mentor.png',
    },
    {
      'title': 'Mira - Calm Friend',
      'description': 'gentle and\ncomforting friend',
      'category': 'companion',
      'imageAsset': 'assets/images/friend.png',
    },
    {
      'title': 'Blaze - Startup Coach',
      'description': 'Business, startups\nand strategy',
      'category': 'Business',
      'imageAsset': 'assets/images/startup.png',
    },
  ];

  final List<Map<String, String>> allPersonas = [
    {
      'title': 'Mentor Max',
      'description': 'Career guidance and skill growth',
      'imageAsset': 'assets/images/mentor.png',
      'category': 'Career',
    },
    {
      'title': 'Lovely Crush Kiara',
      'description': 'Romantic, empathetic, and fun-chats',
      'imageAsset': 'assets/images/crush.png',
      'category': 'Romance',
    },
    {
      'title': 'Calm Friend Mira',
      'description': 'A gentle and comforting friend',
      'imageAsset': 'assets/images/friend.png',
      'category': 'Companion',
    },
    {
      'title': 'Startup Coach Blaze',
      'description': 'Business, startups & strategy',
      'imageAsset': 'assets/images/startup.png',
      'category': 'Business',
    },
    {
      'title': 'Study Buddy Neo',
      'description': 'Learning assistance & exam help',
      'imageAsset': 'assets/images/study.png',
      'category': 'Education',
    },
    {
      'title': 'Zen Wellness Guide',
      'description': 'Health, fitness & mindfulness',
      'imageAsset': 'assets/images/coach.png',
      'category': 'Health',
    },
  ];

  final List<Map<String, dynamic>> chatMessages = [
    {'text': 'Hey, I need some guidance', 'isUser': true},
    {'text': 'Of course! I\'m here to help you succeed.', 'isUser': false},
    {'text': 'How can I achieve my goals?', 'isUser': true},
    {'text': 'Let\'s break it down together.', 'isUser': false},
  ];

  /// Check if user is logged in, if not redirect to login
  void _handleStartChatting() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, scroll to choose section
      _scrollToChooseSection();
    } else {
      // User is not logged in, redirect to login
      Navigator.pushNamed(context, '/login');
    }
  }

  /// Scroll to the "Choose Your AI Companion" section
  void _scrollToChooseSection() {
    final context = _chooseSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    if (isMobile) {
      return _buildMobileHomeScreen(context);
    }

    return _buildDesktopHomeScreen(context);
  }

  Widget _buildMobileHomeScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: WebTheme.darkBg,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Navbar
            NavbarWidget(
              onLoginPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              onHomePressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            // Hero Section
            _buildHeroSection(context, true),
            const SizedBox(height: 32),
            // Choose Your AI Companion Section
            Container(
              key: _chooseSectionKey,
              child: _buildChooseSection(context, true),
            ),
            const SizedBox(height: 48),
            // How It Works Section
            HowItWorksSection(),
            const SizedBox(height: 48),
            // Footer
            FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopHomeScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: WebTheme.darkBg,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Navbar
            NavbarWidget(
              onLoginPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              onHomePressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            // Hero Section
            _buildHeroSection(context, false),
            const SizedBox(height: 60),
            // Choose Your AI Companion Section
            Container(
              key: _chooseSectionKey,
              child: _buildChooseSection(context, false),
            ),
            const SizedBox(height: 10),
            // How It Works Section
            HowItWorksSection(),
            const SizedBox(height: 100),
            // Testimonials Section
            TestimonialsSection(),
            const SizedBox(height: 100),
            // App Download Section
            AppDownloadSection(),
            const SizedBox(height: 100),
            // Footer
            FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return SizedBox(
      height: isMobile ? 380 : 700,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 80,
          vertical: isMobile ? 20 : 30,
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Main title
                  Text(
                    'AI Conversations\nThat Feel Alive',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: WebTheme.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Subtitle
                  Text(
                    'Talk to AI mentors, coaches, and friends\nwho understand you — anytime, anywhere.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                      color: WebTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // Buttons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GlassButton(
                        text: 'Start Chatting',
                        onPressed: _handleStartChatting,
                        isPrimary: true,
                      ),
                      const SizedBox(height: 12),
                      GlassButton(
                        text: 'Explore Personas',
                        onPressed: () {
                          Navigator.pushNamed(context, '/personas');
                        },
                        isPrimary: false,
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side - Text and buttons
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Main title
                        Text(
                          'AI Conversations\nThat Feel Alive',
                          style: GoogleFonts.poppins(
                            fontSize: 56,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            color: WebTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Subtitle
                        Text(
                          'Talk to AI mentors, coaches, and friends\nwho understand you — anytime, anywhere.',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.6,
                            color: WebTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Buttons
                        Row(
                          children: [
                            GlassButton(
                              text: 'Start Chatting',
                              onPressed: _handleStartChatting,
                              isPrimary: true,
                            ),
                            const SizedBox(width: 16),
                            GlassButton(
                              text: 'Explore Personas',
                              onPressed: () {
                                Navigator.pushNamed(context, '/personas');
                              },
                              isPrimary: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Right side - Cards and chat
                  Expanded(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Floating chat bubbles
                        ..._buildFloatingChatBubbles(),
                        // Featured persona cards
                        Positioned(
                          right: 0,
                          top: 120,
                          child: _buildFeaturedCardsStack(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFeaturedCardsStack() {
    return SizedBox(
      width: 550,
      height: 520,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Left card - Behind
          Positioned(
            left: 0,
            top: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF6366F1), width: 1.5),
              ),
              child: PersonaCard(
                title: featuredPersonas[0]['title']!,
                description: featuredPersonas[0]['description']!,
                category: featuredPersonas[0]['category'],
                categoryAlignment: Alignment.topLeft,
                imageAsset: featuredPersonas[0]['imageAsset'],
                width: 260,
                height: 360,
              ),
            ),
          ),
          // Right card - Behind
          Positioned(
            right: 0,
            top: 40,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF06B6D4), width: 1.5),
              ),
              child: PersonaCard(
                title: featuredPersonas[2]['title']!,
                description: featuredPersonas[2]['description']!,
                category: featuredPersonas[2]['category'],
                imageAsset: featuredPersonas[2]['imageAsset'],
                width: 260,
                height: 360,
              ),
            ),
          ),
          // Center card - Front (On top of both side cards)
          Positioned(
            left: 120,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEC4899), width: 1.5),
              ),
              child: PersonaCard(
                title: featuredPersonas[1]['title']!,
                description: featuredPersonas[1]['description']!,
                category: featuredPersonas[1]['category'],
                imageAsset: featuredPersonas[1]['imageAsset'],
                width: 300,
                height: 420,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFloatingChatBubbles() {
    return [
      // First chat bubble (User) - Top left
      Positioned(
        left: 80,
        top: 80,
        child: _buildChatBubble(
          text: 'Hey, I need some guidance',
          isUser: true,
          maxWidth: 150,
        ),
      ),
      // Second chat bubble (AI) - Above right card at bottom
      Positioned(
        right: -55,
        bottom: 25,
        child: _buildChatBubble(
          text: 'Of course! I\'m here to help you succeed.',
          isUser: false,
          maxWidth: 180,
        ),
      ),
      // Third chat bubble (User) - Middle left
      // Positioned(
      //   left: 40,
      //   top: 280,
      //   child: _buildChatBubble(
      //     text: 'How can I achieve my goals?',
      //     isUser: true,
      //     maxWidth: 140,
      //   ),
      // ),
      // // Fourth chat bubble (AI) - Bottom right
      // Positioned(
      //   right: 80,
      //   bottom: 60,
      //   child: _buildChatBubble(
      //     text: 'Let\'s break it down together.',
      //     isUser: false,
      //     maxWidth: 140,
      //   ),
      // ),
    ];
  }

  Widget _buildChatBubble({
    required String text,
    required bool isUser,
    required double maxWidth,
  }) {
    final bgColor = isUser
        ? WebTheme.primaryGradientStart.withOpacity(0.8)
        : Colors.white.withOpacity(0.1);
    final textColor = isUser ? Colors.white : Colors.white;
    final borderRadius = isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildChooseSection(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Choose Your AI Companion',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: WebTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            'From career advice to personal motivation — find the persona that fits your world.',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.6,
              color: WebTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 48),

          if (!isMobile)
            SizedBox(
              height: 520,
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: allPersonas.length,

                // spacing between items
                separatorBuilder: (_, __) => const SizedBox(width: 20),

                itemBuilder: (context, index) {
                  final persona = allPersonas[index];

                  // Width to show exactly 4 cards on screen
                  final screenWidth = MediaQuery.of(context).size.width;
                  final cardWidth = screenWidth / 4 - 20;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20, // ⬅️ This fixes the top image cutoff
                    ),
                    child: SizedBox(
                      width: cardWidth,
                      child: PersonaCard(
                        title: persona['title']!,
                        description: persona['description']!,
                        imageAsset: persona['imageAsset'],
                        category: persona['category'],
                        width: 210,
                        height: 320,
                      ),
                    ),
                  );
                },
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: allPersonas.length,
              itemBuilder: (context, index) {
                final persona = allPersonas[index];
                return PersonaCard(
                  title: persona['title']!,
                  description: persona['description']!,
                  imageAsset: persona['imageAsset'],
                  category: persona['category'],
                  width: 140,
                  height: 280,
                );
              },
            ),
        ],
      ),
    );
  }
}
