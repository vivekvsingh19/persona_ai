import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF1A237E),
        secondary: const Color(0xFF311B92),
        surface: const Color(0xFF1A1A1D),
        background: const Color(0xFF121212),
        onSurface: Colors.grey[300]!,
        onBackground: Colors.grey[300]!,
        tertiary: const Color(0xFF94CBFF),
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: const Color(0xFF1A1A1D),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1A1A1D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[800]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: const Color(0xFF1A237E), width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.2,
          letterSpacing: -0.5,
          color: Colors.grey[100],
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.2,
          letterSpacing: -0.3,
          color: Colors.grey[200],
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.2,
          letterSpacing: -0.2,
          color: Colors.grey[200],
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          letterSpacing: 0.1,
          color: Colors.grey[300],
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          letterSpacing: 0.1,
          color: Colors.grey[400],
        ),
      ),
      iconTheme: IconThemeData(color: Colors.grey[300]),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[900]!,
        disabledColor: Colors.grey[800]!,
        selectedColor: const Color(0xFF2C2C2C),
        secondarySelectedColor: const Color(0xFF1A237E),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        labelStyle: TextStyle(color: Colors.grey[300]),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1A1A1D),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[300]),
        titleTextStyle: TextStyle(
          color: Colors.grey[200],
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF1A1A1D),
        selectedItemColor: const Color(0xFF1A237E),
        unselectedItemColor: Colors.grey[600],
        selectedIconTheme: const IconThemeData(size: 24),
        unselectedIconTheme: const IconThemeData(size: 22),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF897E),
            brightness: Brightness.light,
          ).copyWith(
            primary: const Color(0xFFFF897E),
            secondary: const Color(0xFFE2A0FF),
            tertiary: const Color(0xFF94CBFF),
            surface: Colors.white,
            background: const Color(0xFFFFF5F5),
            onBackground: const Color(0xFF2D2D2D),
          ),
      scaffoldBackgroundColor: const Color(0xFFFFF5F5),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.white.withOpacity(0.85),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.85),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: const Color(0xFFFF897E).withOpacity(0.5),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.2,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.2,
          letterSpacing: -0.3,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.2,
          letterSpacing: -0.2,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          letterSpacing: 0.1,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: const Color(0xFF2D5AF8),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? color;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: (color ?? Colors.white).withOpacity(0.9),
        borderRadius: borderRadius ?? BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF897E).withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 8),
            spreadRadius: -5,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(-8, -8),
            spreadRadius: 0,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.8),
          ],
        ),
      ),
      child: child,
    );
  }
}
