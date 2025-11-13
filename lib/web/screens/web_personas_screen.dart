import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import '../widgets/navbar_widget.dart';
import '../widgets/footer_widget.dart';

class WebPersonasScreen extends StatefulWidget {
  const WebPersonasScreen({Key? key}) : super(key: key);

  @override
  State<WebPersonasScreen> createState() => _WebPersonasScreenState();
}

class _WebPersonasScreenState extends State<WebPersonasScreen> {
  final List<Map<String, dynamic>> personas = [
    {
      'title': 'Mentor Max',
      'category': 'Career',
      'description': 'Career guidance, interviews & professional growth',
      'features': [
        'Career guidance and resume optimization',
        'Interview preparation strategies',
        'Skill development planning',
        'Industry insights and trends',
        'Networking advice and tips',
        'Work-life balance counseling',
      ],
      'imageAsset': 'assets/images/mentor.png',
      'color': const Color(0xFF1E3A8A),
    },
    {
      'title': 'Lovely Crush Kiara',
      'category': 'Romance',
      'description': 'Romantic chats and emotional bonding',
      'features': [
        'Romantic and thoughtful advice',
        'Relationship communication tips',
        'Emotional support and listening',
        'Fun and engaging conversations',
        'Personal growth discussions',
        'Confidence building support',
      ],
      'imageAsset': 'assets/images/crush.png',
      'color': const Color(0xFFEC4899),
    },
    {
      'title': 'Calm Friend Mira',
      'category': 'Companion',
      'description': 'A gentle and comforting friend to talk to openly',
      'features': [
        'Empathetic listening',
        'Emotional support and understanding',
        'Comfortable conversations',
        'Friendly advice and guidance',
        'Stress relief and comfort',
        'Personal sharing space',
      ],
      'imageAsset': 'assets/images/friend.png',
      'color': const Color(0xFF6366F1),
    },
    {
      'title': 'Startup Coach Blaze',
      'category': 'Business',
      'description': 'Sharp guidance for business, startups & strategy',
      'features': [
        'Business strategy and planning',
        'Startup mentorship and guidance',
        'Market analysis and insights',
        'Growth hacking strategies',
        'Entrepreneurship advice',
        'Investment and funding guidance',
      ],
      'imageAsset': 'assets/images/startup.png',
      'color': const Color(0xFF0EA5E9),
    },
    {
      'title': 'Study Buddy Neo',
      'category': 'Education',
      'description': 'Learning assistance, notes & exam help',
      'features': [
        'Study material organization',
        'Exam preparation strategies',
        'Learning techniques and tips',
        'Subject explanations',
        'Homework and assignment help',
        'Exam anxiety management',
      ],
      'imageAsset': 'assets/images/study.png',
      'color': const Color(0xFFF59E0B),
    },
    {
      'title': 'Zen Wellness Guide',
      'category': 'Health',
      'description': 'Health, fitness & mindfulness guidance',
      'features': [
        'Fitness routine recommendations',
        'Nutrition and diet guidance',
        'Mental health support',
        'Meditation and mindfulness guidance',
        'Wellness tracking advice',
        'Holistic health approach',
      ],
      'imageAsset': 'assets/images/coach.png',
      'color': const Color(0xFF059669),
    },
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
            // Header Section
            _buildHeaderSection(context, isMobile),
            const SizedBox(height: 60),
            // Personas Grid
            _buildPersonasGrid(context, isMobile),
            const SizedBox(height: 60),
            // Footer
            FooterWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 40 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meet Your AI Companions',
            style: GoogleFonts.poppins(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w700,
              color: WebTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Each AI persona is uniquely designed to support you in different aspects of your life. Explore their specialties and find the perfect companion for your needs.',
            style: GoogleFonts.inter(
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w400,
              height: 1.6,
              color: WebTheme.textSecondary,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonasGrid(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 80),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              childAspectRatio: isMobile ? 0.9 : 0.9,
              crossAxisSpacing: isMobile ? 12 : 30,
              mainAxisSpacing: isMobile ? 12 : 30,
            ),
            itemCount: personas.length,
            itemBuilder: (context, index) {
              final persona = personas[index];
              return _buildPersonaCard(context, persona, isMobile);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonaCard(
    BuildContext context,
    Map<String, dynamic> persona,
    bool isMobile,
  ) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          child: Stack(
            children: [
              // Background with gradient - fully transparent
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (persona['color'] as Color).withOpacity(0.05),
                      (persona['color'] as Color).withOpacity(0.01),
                    ],
                  ),
                  border: Border.all(
                    color: (persona['color'] as Color).withOpacity(0.15),
                    width: 1.5,
                  ),
                ),
              ),
              // Glass effect overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 1,
                  ),
                ),
              ),
              // Content
              Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar and Title Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Icon with Background - Circular with image
                        Container(
                          width: isMobile ? 70 : 90,
                          height: isMobile ? 70 : 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                (persona['color'] as Color).withOpacity(0.9),
                                (persona['color'] as Color).withOpacity(0.5),
                              ],
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              persona['imageAsset'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: (persona['color'] as Color)
                                      .withOpacity(0.5),
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                    size: isMobile ? 35 : 50,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Title and Category beside avatar
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                persona['title'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: isMobile ? 18 : 22,
                                  fontWeight: FontWeight.w800,
                                  color: WebTheme.textPrimary,
                                  letterSpacing: -0.5,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              // Category Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      (persona['color'] as Color).withOpacity(
                                        0.15,
                                      ),
                                      (persona['color'] as Color).withOpacity(
                                        0.08,
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: (persona['color'] as Color)
                                        .withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  persona['category'] as String,
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: persona['color'] as Color,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Description
                    Text(
                      persona['description'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                        color: WebTheme.textSecondary,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 24),

                    // Divider
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            (persona['color'] as Color).withOpacity(0.15),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Features Section - Responsive (Compact for web, scrollable for mobile)
                    Text(
                      'What You Get',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: WebTheme.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Features List - Different layout for web and mobile
                    if (isMobile)
                      // Mobile: Scrollable list
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...(persona['features'] as List<String>)
                                  .take(5)
                                  .map((feature) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Check icon
                                          Container(
                                            width: 20,
                                            height: 20,
                                            margin: const EdgeInsets.only(
                                              top: 2,
                                              right: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                colors: [
                                                  (persona['color'] as Color)
                                                      .withOpacity(0.7),
                                                  (persona['color'] as Color)
                                                      .withOpacity(0.4),
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.check_rounded,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              feature,
                                              style: GoogleFonts.inter(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                height: 1.5,
                                                color: WebTheme.textSecondary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                  .toList(),
                            ],
                          ),
                        ),
                      )
                    else
                      // Web: Compact grid (2 columns, no scrolling)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...(persona['features'] as List<String>).take(4).map((
                            feature,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Check icon
                                  Container(
                                    width: 16,
                                    height: 16,
                                    margin: const EdgeInsets.only(
                                      top: 2,
                                      right: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          (persona['color'] as Color)
                                              .withOpacity(0.7),
                                          (persona['color'] as Color)
                                              .withOpacity(0.4),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: 1.4,
                                        color: WebTheme.textSecondary,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    const SizedBox(height: 24),

                    // CTA Button - No Shadow
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              (persona['color'] as Color),
                              (persona['color'] as Color).withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Start Chatting',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
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
