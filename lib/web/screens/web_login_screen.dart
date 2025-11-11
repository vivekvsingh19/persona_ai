import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/navbar_widget.dart';

class WebLoginScreen extends StatefulWidget {
  const WebLoginScreen({Key? key}) : super(key: key);

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  bool isLogin = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: WebTheme.darkBg,
      body: Column(
        children: [
          // Navbar
          NavbarWidget(
            onLoginPressed: () {},
            onHomePressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 80,
                vertical: isMobile ? 30 : 40,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side text (desktop only)
                  if (!isMobile)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 60, top: 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isLogin ? 'Welcome Back' : 'Join Us Today',
                              style: GoogleFonts.poppins(
                                fontSize: 44,
                                fontWeight: FontWeight.w700,
                                color: WebTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isLogin
                                  ? 'Sign in to continue your AI conversations'
                                  : 'Create an account to start chatting with AI mentors',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: WebTheme.textSecondary,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              height: 3,
                              width: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    WebTheme.primaryGradientStart,
                                    WebTheme.primaryGradientEnd,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  // Right side form
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: isMobile ? 0 : 60),
                      child: GlassContainer(
                        borderRadius: 24,
                        blurSigma: 12,
                        padding: EdgeInsets.all(isMobile ? 24 : 36),
                        backgroundColor: Colors.white.withOpacity(0.05),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1.5,
                        ),
                        width: isMobile ? double.infinity : 420,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Form title
                            Text(
                              isLogin ? 'Sign In' : 'Create Account',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: WebTheme.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),

                            // Name field (signup only)
                            if (!isLogin) ...[
                              _buildInputField(
                                label: 'Full Name',
                                controller: nameController,
                                hint: 'Enter your name',
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Email field
                            _buildInputField(
                              label: 'Email',
                              controller: emailController,
                              hint: 'your@email.com',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),

                            // Password field
                            _buildInputField(
                              label: 'Password',
                              controller: passwordController,
                              hint: 'Enter your password',
                              obscure: obscurePassword,
                              onObscureToggle: () {
                                setState(
                                  () => obscurePassword = !obscurePassword,
                                );
                              },
                            ),
                            const SizedBox(height: 24),

                            // Sign in / Sign up button
                            _buildActionButton(
                              label: isLogin ? 'Sign In' : 'Create Account',
                              onPressed: () {},
                            ),
                            const SizedBox(height: 14),

                            // Google sign in button
                            _buildGoogleButton(),
                            const SizedBox(height: 20),

                            // Divider
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    'or',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: WebTheme.textSecondary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Toggle between login/signup
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => isLogin = !isLogin);
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: isLogin
                                            ? 'Don\'t have an account? '
                                            : 'Already have an account? ',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          color: WebTheme.textSecondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: isLogin ? 'Sign Up' : 'Sign In',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: WebTheme.primaryGradientStart,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    VoidCallback? onObscureToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: WebTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscure,
            style: GoogleFonts.inter(fontSize: 13, color: WebTheme.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                fontSize: 13,
                color: WebTheme.textSecondary.withOpacity(0.6),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              suffixIcon: obscure != false
                  ? IconButton(
                      icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility,
                        color: WebTheme.textSecondary.withOpacity(0.6),
                        size: 16,
                      ),
                      onPressed: onObscureToggle,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              WebTheme.primaryGradientStart,
              WebTheme.primaryGradientEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: WebTheme.primaryGradientStart.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🔍', style: GoogleFonts.poppins(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              'Continue with Google',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: WebTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
