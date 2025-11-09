//import 'package:ai_persona/screens/home_screen.dart';
import 'package:ai_persona/features/home/presentation/main_screen.dart';
import 'package:ai_persona/services/google_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await GoogleAuthService.signInWithGoogle();

      if (userCredential != null && mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google sign-in successful!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to main app
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Google sign-in failed';

      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'An account already exists with this email address.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid credentials provided.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Google sign-in is not enabled.';
          break;
        default:
          errorMessage = e.message ?? 'Google sign-in failed';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google sign-in failed: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background - Responsive to theme
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? const [
                        Color(0xFF0A0E27),
                        Color(0xFF121212),
                        Color(0xFF0F1229),
                        Color(0xFF0C0C13),
                      ]
                    : const [
                        Color(0xFFFF8AD4), // soft pink
                        Color(0xFFFFE37E), // warm yellow
                        Color(0xFF6EE7F0), // cool cyan
                        Color(0xFFB38CFF), // lavender
                      ],
                stops: [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),

          // ✨ Subtle glossy overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.3, -0.5),
                radius: 1.2,
                colors: isDark
                    ? [
                        const Color(0xFF4A90E2).withOpacity(0.1),
                        Colors.transparent,
                      ]
                    : [
                        const Color(0xFFFF897E).withOpacity(0.15),
                        Colors.transparent,
                      ],
              ),
            ),
          ),

          // 💫 Main login content
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(32),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.white.withOpacity(0.85),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 🤖 App Logo
                    Image.asset('assets/icons/logo.png', height: 90),
                    const SizedBox(height: 24),

                    // 🧠 Title
                    Text(
                      'Your AI Persona',
                      style: textTheme.headlineMedium?.copyWith(
                        color: isDark ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'Your intelligent companion awaits',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Description
                    Text(
                      'Sign in to personalize your experience or skip for guest access.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // 🔘 Google Sign-In Button
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _signInWithGoogle,
                      icon: _isLoading
                          ? const SizedBox(
                              height: 26,
                              width: 26,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.black87,
                                ),
                              ),
                            )
                          : Image.asset(
                              'assets/icons/google_icon.png',
                              height: 26,
                            ),
                      label: Text(
                        _isLoading ? 'Signing in...' : 'Continue with Google',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadowColor: Colors.black26,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Terms text
                    Text(
                      'By continuing, you agree to our Terms of Service and Privacy Policy.',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white70 : Colors.black54,
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
}
