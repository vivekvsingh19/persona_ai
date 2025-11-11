import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:ai_persona/screens/login_screen.dart';
import 'package:ai_persona/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'features/home/presentation/main_screen.dart';
import 'web/app/web_app.dart';

import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run appropriate app based on platform
  if (kIsWeb) {
    runApp(const WebApp());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeService _themeService;

  @override
  void initState() {
    super.initState();
    _themeService = ThemeService();
    _themeService.addListener(_themeChanged);
  }

  @override
  void dispose() {
    _themeService.removeListener(_themeChanged);
    super.dispose();
  }

  void _themeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Personas',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeService.themeMode,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // If connection state is waiting, show a splash/loading screen
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Color(0xFF121212),
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // If user is logged in, show MainScreen, otherwise LoginScreen
          if (snapshot.hasData && snapshot.data != null) {
            return const MainScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
