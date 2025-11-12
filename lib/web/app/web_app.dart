import 'package:flutter/material.dart';
import '../screens/web_home_screen.dart';
import '../screens/web_login_screen.dart';
import '../screens/web_chat_interface.dart';
import '../screens/web_personas_screen.dart';
import '../theme/web_theme.dart';

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Personas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: WebTheme.darkBg,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C5BFF),
          secondary: Color(0xFFFF5AA2),
          background: WebTheme.darkBg,
          surface: WebTheme.cardBg,
        ),
        textTheme: WebTheme.textTheme,
        cardTheme: CardThemeData(
          color: WebTheme.cardBg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C5BFF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: WebTheme.textPrimary,
            side: const BorderSide(color: WebTheme.textSecondary, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(WebTheme.radiusLarge),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WebHomeScreen(),
        '/login': (context) => const WebLoginScreen(),
        '/personas': (context) => const WebPersonasScreen(),
        '/chat': (context) => const WebChatInterface(),
      },
    );
  }
}
