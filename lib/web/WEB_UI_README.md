# Flutter Web AI Personas UI Documentation

## Overview
This is a modern, responsive Flutter Web UI for the AI Personas application. It features a dark theme with neon purple-to-pink gradients and is fully optimized for desktop and web browsers.

## Architecture

### Directory Structure
```
lib/web/
├── app/
│   └── web_app.dart          # Main web app setup with Material3
├── screens/
│   └── web_home_screen.dart  # Main home screen with all sections
├── widgets/
│   ├── sidebar_nav.dart      # Left navigation sidebar
│   ├── hero_section.dart     # Hero section with CTA buttons
│   ├── persona_card.dart     # Persona card with hover effects
│   └── feature_card.dart     # Feature card component
├── theme/
│   └── web_theme.dart        # Centralized theme and colors
└── utils/
    └── platform_helper.dart  # Platform detection utility
```

## Key Components

### 1. **WebTheme** (`web_theme.dart`)
Centralized theme management with:
- **Colors**: Dark background (#0B0B0E), card background, gradient colors
- **Gradients**: Primary gradient (purple → pink), dark gradient
- **Typography**: Poppins & Inter via Google Fonts
- **Shadows & Border Radius**: Consistent spacing and depth

### 2. **SidebarNav** (`sidebar_nav.dart`)
Left navigation sidebar featuring:
- Logo with gradient background
- Navigation items: Home, Chat, Personas, Settings
- Active item highlighting with gradient
- Sign Out button in red
- Smooth hover animations

**Usage:**
```dart
SidebarNav(
  currentIndex: 0,
  onNavigate: (index) { /* handle nav */ },
  onSignOut: () { /* handle sign out */ },
)
```

### 3. **HeroSection** (`hero_section.dart`)
Main hero banner with:
- Large title: "AI Conversations That Feel Alive"
- Descriptive subtitle
- Two CTA buttons: "Start Chatting" (gradient) & "Explore Personas" (outline)
- Hover effects and animations

**Usage:**
```dart
HeroSection(
  onStartChat: () { /* handle */ },
  onExplorePersonas: () { /* handle */ },
)
```

### 4. **PersonaCard** (`persona_card.dart`)
Reusable persona card component with:
- **Featured Layout**: Image + title + description + CTA button
- **Compact Layout**: Icon + title + description
- Smooth hover animations (lift + shadow + border glow)
- Shimmer animation using flutter_animate

**Usage:**
```dart
PersonaCard(
  title: 'Professional Mentor',
  description: 'Career guidance and professional growth',
  isFeatured: true,
  imageAsset: 'assets/images/mentor.png',
  onTap: () { /* handle */ },
)
```

### 5. **FeatureCard** (`feature_card.dart`)
Feature showcase card with:
- Icon with animated gradient background
- Title and subtitle
- Hover elevation effect
- Border glow on hover

**Usage:**
```dart
FeatureCard(
  icon: Icons.message,
  title: 'Real Conversations',
  subtitle: 'Natural and engaging dialogues',
)
```

### 6. **WebHomeScreen** (`web_home_screen.dart`)
Main screen that orchestrates:
- Sidebar navigation
- Hero section
- Featured personas section
- All personas grid section
- How It Works section with steps
- Features section
- Responsive layout handling

## Design System

### Colors
| Name | Hex | Usage |
|------|-----|-------|
| Dark BG | #0B0B0E | Main background |
| Card BG | #1A1A1D | Cards & containers |
| Primary Start | #6C5BFF | Gradient start (purple) |
| Primary End | #FF5AA2 | Gradient end (pink) |
| Text Primary | #FFFFFF | Main text |
| Text Secondary | #B3B3B3 | Secondary text |
| Accent Red | #FF4757 | Sign out button |

### Typography
- **Headings**: Poppins, Bold (700), Various sizes
- **Body**: Inter, Regular (400), Opacity ~70%
- **Sizes**: DisplayMedium (44px), HeadlineMedium (24px), BodyLarge (16px), etc.

### Spacing
- **Small**: 8px
- **Medium**: 16px
- **Large**: 24px
- **XL**: 32px+

### Border Radius
- **Small**: 8px
- **Medium**: 16px
- **Large**: 24px

## Responsive Design

### Breakpoints
- **Mobile**: < 768px
  - Single column layouts
  - Sidebar hidden (can be toggled)
  - Reduced padding

- **Tablet/Desktop**: ≥ 768px
  - Multi-column grids
  - Sidebar always visible
  - Full padding and spacing

### Grid Layouts
- **Featured Personas**: 1-3 columns based on screen size
- **All Personas**: 2-4 columns based on screen size
- **Features**: 1-3 columns based on screen size

## Animations & Interactions

### Hover Effects
- **Cards**: Lift up + shadow glow + border color change
- **Buttons**: Border/background color transition + shadow
- **Nav Items**: Gradient background on active/hover

### Animations
- **Shimmer**: Subtle shimmer on persona cards
- **Transform**: Smooth scale and translate on hover
- **Duration**: 300ms for most animations

## Platform Integration

### Platform Detection
The app automatically routes to the appropriate UI:
```dart
if (kIsWeb) {
  runApp(const WebApp());  // Web UI
} else {
  runApp(const MyApp());   // Mobile UI
}
```

### Firebase Integration
Both mobile and web share:
- Firebase initialization
- Authentication (optional for web)
- Same backend services

## Usage Examples

### Complete Web App
```dart
import 'package:ai_persona/web/app/web_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const WebApp());
}
```

### Custom Persona Section
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    childAspectRatio: 0.75,
    crossAxisSpacing: 24,
    mainAxisSpacing: 24,
  ),
  itemBuilder: (context, index) {
    return PersonaCard(
      title: personas[index].title,
      description: personas[index].description,
      isFeatured: true,
    );
  },
)
```

## Best Practices

1. **Theme**: Always use `WebTheme` constants for colors and spacing
2. **Responsive**: Check `MediaQuery.of(context).size.width` for breakpoints
3. **Performance**: Use `SingleChildScrollView` with `shrinkWrap: true` on nested grids
4. **Accessibility**: Include proper semantic labels and high contrast text
5. **Animations**: Keep durations between 200-500ms for smoothness

## Customization

### Changing Colors
Edit `WebTheme` class in `web_theme.dart`:
```dart
static const Color darkBg = Color(0xFF0B0B0E);
static const Color primaryGradientStart = Color(0xFF6C5BFF);
```

### Adding New Sections
Create new widget in `web/widgets/`:
```dart
class NewSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Column(/* content */),
    );
  }
}
```

### Custom Personas Data
Modify the lists in `web_home_screen.dart`:
```dart
final List<Map<String, String>> featuredPersonas = [
  {'title': '...', 'description': '...'},
];
```

## Performance Tips

1. Use `const` constructors where possible
2. Use `SingleChildScrollView` + `shrinkWrap` for nested scrolling
3. Lazy load images with `Image.asset()`
4. Use `NeverScrollableScrollPhysics` for nested grids
5. Implement proper state management for large sections

## Troubleshooting

### Dependencies Not Found
Run: `flutter pub get`

### Google Fonts Not Loading
Ensure pubspec.yaml has:
```yaml
google_fonts: ^6.3.2
flutter_animate: ^4.2.0
```

### Layout Overflow
Check responsive breakpoint and padding values in affected widgets

### Animations Not Smooth
Verify animation durations and curves match the design

## Future Enhancements

- [ ] Add real persona data integration
- [ ] Implement authentication UI
- [ ] Add chat interface
- [ ] Mobile sidebar toggle
- [ ] Dark/Light theme toggle
- [ ] Analytics tracking
- [ ] Performance optimizations

## Support

For questions or issues, refer to the Flutter Web documentation:
- https://flutter.dev/docs/deployment/web
- https://material.io/design/
- https://pub.dev/packages/flutter_animate
- https://pub.dev/packages/google_fonts
