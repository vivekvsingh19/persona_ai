import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import '../widgets/navbar_widget.dart';
import '../widgets/glass_container.dart';
import '../widgets/footer_widget.dart';

class WebPersonasScreen extends StatefulWidget {
  const WebPersonasScreen({Key? key}) : super(key: key);

  @override
  State<WebPersonasScreen> createState() => _WebPersonasScreenState();
}

class _WebPersonasScreenState extends State<WebPersonasScreen> {
  final List<Map<String, dynamic>> personas = [
    {
      'title': 'Professional Mentor',
      'category': 'Career',
      'description': 'Your dedicated career guide and professional coach',
      'features': [
        'Career guidance and resume optimization',
        'Interview preparation strategies',
        'Skill development planning',
        'Industry insights and trends',
        'Networking advice and tips',
        'Work-life balance counseling',
      ],
      'imageAsset': 'assets/images/mentor.png',
      'color': const Color(0xFF6C5BFF),
    },
    {
      'title': 'Lovely Crush',
      'category': 'Relationships',
      'description': 'Empathetic companion for meaningful conversations',
      'features': [
        'Romantic and thoughtful advice',
        'Relationship communication tips',
        'Emotional support and listening',
        'Fun and engaging conversations',
        'Personal growth discussions',
        'Confidence building support',
      ],
      'imageAsset': 'assets/images/crush.png',
      'color': const Color(0xFFFF5AA2),
    },
    {
      'title': 'Life Coach',
      'category': 'Personal Development',
      'description': 'Motivational guide for achieving your goals',
      'features': [
        'Goal setting and planning',
        'Motivation and inspiration',
        'Mindfulness and meditation guidance',
        'Personal values clarification',
        'Habit formation strategies',
        'Accountability and tracking',
      ],
      'imageAsset': 'assets/images/coach.png',
      'color': const Color(0xFF00D4FF),
    },
    {
      'title': 'Wellness Guide',
      'category': 'Health',
      'description': 'Your health and fitness companion',
      'features': [
        'Fitness routine recommendations',
        'Nutrition and diet guidance',
        'Mental health support',
        'Exercise motivation',
        'Sleep improvement tips',
        'Wellness tracking advice',
      ],
      'imageAsset': 'assets/images/gym.png',
      'color': const Color(0xFF00D97E),
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
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              childAspectRatio: isMobile ? 1.0 : 1.1,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
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
    return GlassContainer(
      borderRadius: 20,
      blurSigma: 12,
      padding: const EdgeInsets.all(32),
      backgroundColor: Colors.white.withOpacity(0.05),
      border: Border.all(
        color: (persona['color'] as Color).withOpacity(0.3),
        width: 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (persona['color'] as Color).withOpacity(0.8),
                      (persona['color'] as Color).withOpacity(0.4),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (persona['color'] as Color).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    persona['imageAsset'] as String,
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 32,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      persona['title'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.w700,
                        color: WebTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      persona['category'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: (persona['color'] as Color),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Description
          Text(
            persona['description'] as String,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: WebTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          // Features list
          Text(
            'Key Features',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: WebTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // Features
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...(persona['features'] as List<String>).map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(top: 6, right: 12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: persona['color'] as Color,
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
                  }).toList(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // CTA Button
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (persona['color'] as Color).withOpacity(0.8),
                    (persona['color'] as Color).withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: (persona['color'] as Color).withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Text(
                'Chat with ${persona['title']}',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
