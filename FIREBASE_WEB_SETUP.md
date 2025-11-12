# Firebase Setup for Flutter Web - Complete Guide

## Overview
Your Flutter web app now has Firebase Authentication integrated with Google Sign-In support.

## Files Created/Modified

### 1. **web/firebase-config.js** (NEW)
   - Contains Firebase configuration with your credentials
   - Initializes Firebase app, Authentication, and Analytics
   - Exports auth instance for Dart to access
   - Sets persistence to keep users logged in across sessions

### 2. **web/index.html** (MODIFIED)
   - Added Firebase SDK initialization
   - Makes Firebase accessible globally via `window.firebaseAuth` and `window.firebaseApp`
   - Loads the firebase-config.js module

### 3. **lib/services/web_auth_service.dart** (NEW)
   - Dart service class for Firebase authentication
   - Methods available:
     - `signInWithGoogle()` - Google Sign-In
     - `signInWithEmailPassword()` - Email/password authentication
     - `registerWithEmailPassword()` - User registration
     - `signOut()` - Sign out user
     - `getCurrentUser()` - Get current logged-in user
     - `isLoggedIn()` - Check if user is logged in
     - `authStateChanges()` - Listen to auth state changes

### 4. **lib/web/screens/web_login_screen.dart** (MODIFIED)
   - Integrated Firebase authentication
   - Google Sign-In button now fully functional
   - Shows loading state during authentication
   - Navigates to `/chat` screen after successful login
   - Error handling with SnackBar notifications

## Configuration Details

### Firebase Credentials (Already Set)
```
apiKey: "AIzaSyALFBmvJ01wIjSchY2Kz0FhVB6J2vnSR20"
authDomain: "persona-ai-b0d88.firebaseapp.com"
projectId: "persona-ai-b0d88"
storageBucket: "persona-ai-b0d88.firebasestorage.app"
messagingSenderId: "158986913917"
appId: "1:158986913917:web:c88fef3b15dbabe7070914"
measurementId: "G-DXET062F2T"
```

## How It Works

### 1. User Clicks "Continue with Google"
   - Button triggers `WebAuthService.signInWithGoogle()`
   - Loading state is shown while authenticating
   - User is redirected to Google login (if not already logged in)

### 2. Google Authentication Flow
   - User signs in with their Google account
   - Google returns access token and ID token
   - Firebase creates a user session with these credentials

### 3. Session Persistence
   - User session is stored in browser's local storage
   - User remains logged in even after closing the browser
   - Persistence is set to `browserLocalPersistence`

### 4. After Login
   - User is automatically redirected to `/chat` screen
   - Firebase auth state is updated
   - Web app recognizes user as authenticated

## Using Firebase Services in Your Code

### Get Current User
```dart
import 'package:ai_persona/services/web_auth_service.dart';

final user = WebAuthService.getCurrentUser();
if (user != null) {
  print('Logged in as: ${user.email}');
}
```

### Listen to Auth State Changes
```dart
WebAuthService.authStateChanges().listen((user) {
  if (user != null) {
    print('User signed in: ${user.uid}');
  } else {
    print('User signed out');
  }
});
```

### Sign Out User
```dart
await WebAuthService.signOut();
Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
```

### Email/Password Authentication (Optional)
```dart
// Sign up
try {
  final userCredential = await WebAuthService.registerWithEmailPassword(
    email: 'user@example.com',
    password: 'password123',
    displayName: 'John Doe',
  );
  print('User registered: ${userCredential.user?.uid}');
} catch (e) {
  print('Registration failed: $e');
}

// Sign in
try {
  final userCredential = await WebAuthService.signInWithEmailPassword(
    email: 'user@example.com',
    password: 'password123',
  );
  print('User signed in: ${userCredential.user?.uid}');
} catch (e) {
  print('Sign in failed: $e');
}
```

## Firebase Console Setup (Already Complete)

Your Firebase project is already configured:
1. ✅ Project created: `persona-ai-b0d88`
2. ✅ Web app registered
3. ✅ Google Sign-In enabled in Firebase Console
4. ✅ Authentication methods configured

## Security Notes

### Important for Production:
1. **API Key is public** - This is intentional in Firebase. The real security comes from:
   - Firebase Security Rules
   - OAuth 2.0 credentials
   - Domain verification in Firebase Console

2. **CORS Configuration** - Your domain must be whitelisted in Firebase Console:
   - Go to Firebase Console → Authentication → Settings
   - Add your domain to the authorized domains list

3. **Environment Variables** - For sensitive configurations:
   - Consider storing credentials in environment variables
   - Use `.env` files (excluded from git)

## Testing

1. **Local Testing**
   ```bash
   flutter run -d chrome --web-renderer canvaskit
   ```

2. **Build for Production**
   ```bash
   flutter build web --release
   ```

## Troubleshooting

### Issue: "Firebase is not initialized"
- **Solution**: Ensure `web/firebase-config.js` is properly linked in `index.html`

### Issue: "Google Sign-In popup blocked"
- **Solution**: Make sure it's not triggered by a non-user action (like setTimeout)
- Ensure you're in a secure context (HTTPS)

### Issue: "User not persisted after refresh"
- **Solution**: Check browser settings - local storage might be disabled
- Try incognito/private browsing mode to test

### Issue: "CORS error during sign-in"
- **Solution**: Add your domain to Firebase Console → Authentication → Settings → Authorized domains

## Next Steps

1. **Update Web Chat Interface** - Add user info and sign out functionality
2. **Add Email/Password Authentication** - Expand login options
3. **Implement User Profile** - Store additional user data in Firestore
4. **Add Protected Routes** - Create middleware to check auth state before navigating
5. **Configure Firebase Security Rules** - Set up Firestore/Storage rules

## File Structure
```
lib/
├── services/
│   ├── web_auth_service.dart (NEW)
│   └── google_auth_service.dart (existing)
└── web/
    ├── screens/
    │   ├── web_login_screen.dart (MODIFIED)
    │   └── web_chat_interface.dart
    └── app/
        └── web_app.dart

web/
├── firebase-config.js (NEW)
├── index.html (MODIFIED)
└── manifest.json
```

## Documentation Links
- [Firebase Web Setup](https://firebase.google.com/docs/web/setup)
- [Firebase Authentication](https://firebase.google.com/docs/auth/web/start)
- [Google Sign-In for Web](https://firebase.google.com/docs/auth/web/google-signin)
- [Firebase Security Rules](https://firebase.google.com/docs/rules/get-started)
