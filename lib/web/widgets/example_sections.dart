import 'package:flutter/material.dart';
import '../theme/web_theme.dart';

/// Example: Custom testimonial section
class TestimonialSection extends StatelessWidget {
  final List<Map<String, String>> testimonials;

  TestimonialSection({Key? key})
    : testimonials = [
        {
          'name': 'Sarah Johnson',
          'role': 'Career Changer',
          'text':
              'This AI mentor helped me transition into tech. Highly recommended!',
          'avatar': '👩‍💼',
        },
        {
          'name': 'Mike Chen',
          'role': 'Entrepreneur',
          'text': 'Great for brainstorming and getting unstuck on problems.',
          'avatar': '👨‍💼',
        },
        {
          'name': 'Emily Rodriguez',
          'role': 'Fitness Enthusiast',
          'text': 'My wellness guide keeps me motivated every single day!',
          'avatar': '👩‍⚕️',
        },
      ],
      super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What Users Say',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: WebTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: testimonials
                .map(
                  (testimonial) => _buildTestimonialCard(context, testimonial),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(
    BuildContext context,
    Map<String, String> testimonial,
  ) {
    return SizedBox(
      width: 320,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
          border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: -2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  testimonial['avatar']!,
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testimonial['name']!,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: WebTheme.textPrimary,
                        ),
                      ),
                      Text(
                        testimonial['role']!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: WebTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              testimonial['text']!,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: WebTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example: CTA Section with newsletter signup
class CTASection extends StatefulWidget {
  final VoidCallback onSignUp;

  const CTASection({Key? key, required this.onSignUp}) : super(key: key);

  @override
  State<CTASection> createState() => _CTASectionState();
}

class _CTASectionState extends State<CTASection> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 80,
      ),
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      decoration: BoxDecoration(
        gradient: WebTheme.primaryGradient,
        borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
        boxShadow: WebTheme.glowShadow,
      ),
      child: Column(
        children: [
          Text(
            'Ready to Transform Your Life?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Start your AI-powered journey today and unlock your potential.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: isMobile ? double.infinity : 500,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          WebTheme.radiusLarge,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    widget.onSignUp();
                    _emailController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C5BFF),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}

/// Example: FAQ Section
class FAQSection extends StatefulWidget {
  const FAQSection({Key? key}) : super(key: key);

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  int expandedIndex = -1;

  late List<Map<String, String>> faqs;

  @override
  void initState() {
    super.initState();
    faqs = [
      {
        'question': 'How does the AI personalization work?',
        'answer':
            'Our AI learns from your conversations and preferences to provide increasingly personalized responses and recommendations.',
      },
      {
        'question': 'Is my data secure and private?',
        'answer':
            'Yes! All conversations are encrypted end-to-end and we never share your data with third parties.',
      },
      {
        'question': 'Can I switch between different personas?',
        'answer':
            'Absolutely! You can chat with any persona at any time and switch between them freely.',
      },
      {
        'question': 'What if I have technical issues?',
        'answer':
            'Our support team is available 24/7. Contact us through the help center in your account settings.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequently Asked Questions',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: WebTheme.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: isMobile ? double.infinity : 600,
            child: Column(
              children: List.generate(
                faqs.length,
                (index) => _buildFAQItem(context, index),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, int index) {
    final isExpanded = expandedIndex == index;
    final faq = faqs[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(WebTheme.radiusMedium),
        border: Border.all(
          color: isExpanded
              ? Colors.white.withOpacity(0.3)
              : Colors.white.withOpacity(0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() {
            expandedIndex = isExpanded ? -1 : index;
          }),
          borderRadius: BorderRadius.circular(WebTheme.radiusMedium),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        faq['question']!,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: WebTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.expand_more,
                        color: WebTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (isExpanded) ...[
                  const SizedBox(height: 12),
                  Text(
                    faq['answer']!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: WebTheme.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
