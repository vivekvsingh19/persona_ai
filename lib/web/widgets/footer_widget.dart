import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: 60,
        ),
        child: Column(
          children: [
            if (!isMobile)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand/Logo section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Personas',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: WebTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Conversations that feel alive',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: WebTheme.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Social links
                        Row(
                          children: [
                            _buildSocialButton('𝕏', () {}),
                            const SizedBox(width: 12),
                            _buildSocialButton('f', () {}),
                            const SizedBox(width: 12),
                            _buildSocialButton('in', () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Links columns
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: WebTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildFooterLink('Features'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Personas'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Pricing'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Download'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Company',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: WebTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildFooterLink('About'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Blog'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Careers'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Contact'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Legal',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: WebTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildFooterLink('Privacy'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Terms'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Security'),
                        const SizedBox(height: 12),
                        _buildFooterLink('Cookies'),
                      ],
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Personas',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: WebTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Conversations that feel alive',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: WebTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Social links
                  Row(
                    children: [
                      _buildSocialButton('𝕏', () {}),
                      const SizedBox(width: 12),
                      _buildSocialButton('f', () {}),
                      const SizedBox(width: 12),
                      _buildSocialButton('in', () {}),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Links columns
                  _buildMobileLinksColumn('Product', [
                    'Features',
                    'Personas',
                    'Pricing',
                  ]),
                  const SizedBox(height: 32),
                  _buildMobileLinksColumn('Company', [
                    'About',
                    'Blog',
                    'Careers',
                  ]),
                  const SizedBox(height: 32),
                  _buildMobileLinksColumn('Legal', [
                    'Privacy',
                    'Terms',
                    'Security',
                  ]),
                ],
              ),
            const SizedBox(height: 40),
            // Divider
            Container(height: 1, color: Colors.white.withOpacity(0.1)),
            const SizedBox(height: 24),
            // Copyright
            Text(
              '© 2024 AI Personas. All rights reserved.',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: WebTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String icon, VoidCallback onPressed) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
          ),
          child: Center(
            child: Text(
              icon,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLink(String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: WebTheme.textSecondary,
          decoration: TextDecoration.underline,
          decorationColor: WebTheme.textSecondary.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildMobileLinksColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: WebTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...links
            .map(
              (link) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildFooterLink(link),
              ),
            )
            .toList(),
      ],
    );
  }
}
