import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  // Featured personas with images
  final List<Map<String, String>> featuredPersonas = [
    {
      'title': 'Professional Mentor',
      'description': 'Career guidance\nand skill growth',
      'category': 'Career',
      'imageAsset': 'assets/images/mentor.png',
    },
    {
      'title': 'Life Coach',
      'description': 'Motivation, mindfulness.\nand clarity',
      'category': 'Health',
      'imageAsset': 'assets/images/coach.png',
    },
    {
      'title': 'Wellness Guide',
      'description': 'Health, fitness\nand wellness tips',
      'category': 'Health',
      'imageAsset': 'assets/images/gym.png',
    },
  ];

  final List<Map<String, String>> allPersonas = [
    {
      'title': 'Professional Mentor',
      'description': 'Career guidance and self growth',
      'imageAsset': 'assets/images/mentor.png',
    },
    {
      'title': 'Lovely Crush',
      'description': 'Romantic, empathetic, and fun-chats',
      'imageAsset': 'assets/images/crush.png',
    },
    {
      'title': 'Life Coach',
      'description': 'Motivation, mindfulness and clarity',
      'imageAsset': 'assets/images/coach.png',
    },
    {
      'title': 'Wellness Guide',
      'description': 'Health, fitness and wellness tips',
      'imageAsset': 'assets/images/gym.png',
    },
  ];

  final List<Map<String, dynamic>> chatMessages = [
    {'text': 'Hey, I need some guidance', 'isUser': true},
    {'text': 'Of course! I\'m here to help you succeed.', 'isUser': false},
    {'text': 'How can I achieve my goals?', 'isUser': true},
    {'text': 'Let\'s break it down together.', 'isUser': false},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: WebTheme.darkBg,
      body: SingleChildScrollView(
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
            _buildHeroSection(context, isMobile),
            const SizedBox(height: 60),
            // Choose Your AI Companion Section
            _buildChooseSection(context, isMobile),
            const SizedBox(height: 100),
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
      height: 700,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: 30,
        ),
        child: Row(
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/chat');
                        },
                        isPrimary: true,
                      ),
                      const SizedBox(width: 16),
                      GlassButton(
                        text: 'Explore Personas',
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        isPrimary: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Right side - Cards and chat
            if (!isMobile)
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
            child: PersonaCard(
              title: featuredPersonas[0]['title']!,
              description: featuredPersonas[0]['description']!,
              category: featuredPersonas[0]['category'],
              imageAsset: featuredPersonas[0]['imageAsset'],
              width: 260,
              height: 360,
            ),
          ),
          // Right card - Behind
          Positioned(
            right: 0,
            top: 40,
            child: PersonaCard(
              title: featuredPersonas[2]['title']!,
              description: featuredPersonas[2]['description']!,
              category: featuredPersonas[2]['category'],
              imageAsset: featuredPersonas[2]['imageAsset'],
              width: 260,
              height: 360,
            ),
          ),
          // Center card - Front (On top of both side cards)
          Positioned(
            left: 120,
            top: 0,
            child: PersonaCard(
              title: featuredPersonas[1]['title']!,
              description: featuredPersonas[1]['description']!,
              category: featuredPersonas[1]['category'],
              imageAsset: featuredPersonas[1]['imageAsset'],
              width: 300,
              height: 420,
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
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
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
          // 4 column grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              childAspectRatio: isMobile ? 0.75 : 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: allPersonas.length,
            itemBuilder: (context, index) {
              final persona = allPersonas[index];
              return PersonaCard(
                title: persona['title']!,
                description: persona['description']!,
                imageAsset: persona['imageAsset'],
                width: isMobile ? 140 : 200,
                height: isMobile ? 280 : 320,
              );
            },
          ),
        ],
      ),
    );
  }
}
