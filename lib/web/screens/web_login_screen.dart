import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/web_theme.dart';
import '../widgets/glass_container.dart';
import '../widgets/navbar_widget.dart';
import '../../services/web_auth_service.dart';
import '../../features/home/presentation/main_screen.dart';

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
  bool isLoading = false;

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

    if (isMobile) {
      return _buildMobileLayout();
    }

    return _buildDesktopLayout();
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: WebTheme.darkBg,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF0A0E27),
                  const Color(0xFF121212),
                  const Color(0xFF0F1229),
                  const Color(0xFF0C0C13),
                ],
                stops: const [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),

          // Subtle glossy overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.3, -0.5),
                radius: 1.2,
                colors: [
                  const Color(0xFF4A90E2).withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Main login content
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(32),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white.withOpacity(0.08),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App Logo
                    Image.asset(
                      'assets/icons/logo.png',
                      height: 90,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox(
                          height: 90,
                          child: Icon(
                            Icons.psychology,
                            size: 90,
                            color: WebTheme.primaryGradientStart,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Your AI Persona',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'Your intelligent companion awaits',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Description
                    Text(
                      'Sign in to personalize your experience or skip for guest access.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Google Sign-In Button
                    _buildMobileGoogleButton(),
                    const SizedBox(height: 20),

                    // Terms text
                    Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy.',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: Colors.white70,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
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
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side text (desktop only)
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
                      padding: const EdgeInsets.only(top: 60),
                      child: GlassContainer(
                        borderRadius: 24,
                        blurSigma: 12,
                        padding: const EdgeInsets.all(36),
                        backgroundColor: Colors.white.withOpacity(0.05),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1.5,
                        ),
                        width: 420,
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
      onTap: isLoading
          ? null
          : () async {
              setState(() => isLoading = true);
              try {
                final userCredential = await WebAuthService.signInWithGoogle();
                if (userCredential != null && mounted) {
                  // Navigate to home screen after successful login
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Sign in failed: $e')));
                }
              } finally {
                if (mounted) setState(() => isLoading = false);
              }
            },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isLoading
              ? Colors.grey.withOpacity(0.2)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    WebTheme.textPrimary,
                  ),
                ),
              )
            else
              Text('🔍', style: GoogleFonts.poppins(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              isLoading ? 'Signing in...' : 'Continue with Google',
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

  Widget _buildMobileGoogleButton() {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () async {
              setState(() => isLoading = true);
              try {
                final userCredential = await WebAuthService.signInWithGoogle();
                if (userCredential != null && mounted) {
                  // Navigate to mobile app MainScreen after successful login
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Sign in failed: $e')));
                }
              } finally {
                if (mounted) setState(() => isLoading = false);
              }
            },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isLoading ? Colors.grey[400] : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                ),
              )
            else
              Image.asset(
                'assets/icons/google_icon.png',
                height: 24,
                errorBuilder: (context, error, stackTrace) {
                  return Text('🔍', style: GoogleFonts.poppins(fontSize: 18));
                },
              ),
            const SizedBox(width: 8),
            Text(
              isLoading ? 'Signing in...' : 'Continue with Google',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
