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
        'imageUrl':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&h=150&fit=crop',
        'rating': 5,
      },
      {
        'name': 'Michael Chen',
        'role': 'Fitness Enthusiast',
        'text':
            'Best wellness guide ever. Available 24/7 and truly understands my health goals.',
        'imageUrl':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop',
        'rating': 5,
      },
      {
        'name': 'Emma Davis',
        'role': 'Student',
        'text':
            'I was skeptical at first, but this AI coaching is genuinely helpful.',
        'imageUrl':
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop',
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

          // Testimonials Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              childAspectRatio: isMobile ? 1.1 : 1.2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            itemCount: testimonials.length,
            itemBuilder: (context, index) {
              final t = testimonials[index];
              return _buildTestimonialCard(
                name: t['name'] as String,
                role: t['role'] as String,
                text: t['text'] as String,
                imageUrl: t['imageUrl'] as String,
                rating: t['rating'] as int,
              );
            },
          ),
        ],
      ),
    );
  }

  // ⭐ TESTIMONIAL CARD (Full-width Image + Overlay Text)
  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String text,
    required String imageUrl,
    required int rating,
  }) {
    return GlassContainer(
      borderRadius: 20,
      blurSigma: 12,
      backgroundColor: Colors.white.withOpacity(0.05),
      border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Full-width Image
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: WebTheme.primaryGradientStart.withOpacity(0.2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Image load error for $imageUrl: $error');
                  return Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: WebTheme.primaryGradientStart,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      strokeWidth: 2,
                    ),
                  );
                },
              ),
            ),
          ),

          // Translucent Container with Text (Bottom - Fixed Size)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Colors.black.withOpacity(0.55),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Name
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: WebTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),

                  // Role
                  Text(
                    role,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: WebTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // ⭐ Star Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      rating,
                      (index) =>
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Review Text
                  Expanded(
                    child: Text(
                      '"$text"',
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        height: 1.4,
                        color: WebTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
