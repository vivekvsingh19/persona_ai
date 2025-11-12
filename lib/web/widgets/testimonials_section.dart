import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import 'glass_container.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    final testimonials = [
      {
        'name': 'Sarah Johnson',
        'role': 'Career Professional',
        'text':
            'The AI mentor helped me navigate my career transition. Highly personalized advice!',
        'avatar': '👩‍💼',
        'rating': 5,
      },
      {
        'name': 'Michael Chen',
        'role': 'Fitness Enthusiast',
        'text':
            'Best wellness guide ever. Available 24/7 and truly understands my health goals.',
        'avatar': '💪',
        'rating': 5,
      },
      {
        'name': 'Emma Davis',
        'role': 'Student',
        'text':
            'Life coaching from an AI was skeptical at first, but it\'s genuinely helpful.',
        'avatar': '📚',
        'rating': 5,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 80,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section title
          Text(
            'What Users Say',
            style: GoogleFonts.poppins(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              color: WebTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            'Join thousands of happy users worldwide',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: WebTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 60),
          // Testimonials grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              childAspectRatio: isMobile ? 1.1 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            itemCount: testimonials.length,
            itemBuilder: (context, index) {
              final testimonial = testimonials[index];
              return _buildTestimonialCard(
                name: testimonial['name'] as String,
                role: testimonial['role'] as String,
                text: testimonial['text'] as String,
                avatar: testimonial['avatar'] as String,
                rating: testimonial['rating'] as int,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String text,
    required String avatar,
    required int rating,
  }) {
    return GlassContainer(
      borderRadius: 20,
      blurSigma: 12,
      backgroundColor: Colors.white.withOpacity(0.05),
      border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stars
          Row(
            children: List.generate(
              rating,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Text('⭐', style: GoogleFonts.poppins(fontSize: 14)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Testimonial text
          Text(
            '"$text"',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: WebTheme.textSecondary,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          // User info
          Row(
            children: [
              // Avatar
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      WebTheme.primaryGradientStart.withOpacity(0.6),
                      WebTheme.primaryGradientEnd.withOpacity(0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(avatar, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 12),
              // Name and role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: WebTheme.textPrimary,
                      ),
                    ),
                    Text(
                      role,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: WebTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
