# Fix Google Sign-In Error on Web

## Error Message
```
Sign in failed: Assertion failed: file:///C:/Users/rimpal%20singh/AppData/Local/Pub/Cache/hosted/pub.dev/google_sign_in_web-0.12.4+4/lib/google_sign_in_web.dart:144:9
appClientId != null
"ClientID not set. Either set it on a <meta name="google-signin-client_id" content="CLIENT_ID" /> tag, 
or pass clientId when initializing GoogleSignIn"
```

## Solution

### Step 1: Get Your Google OAuth Client ID

You need to create a **Web Application OAuth Client ID** from Google Cloud Console.

**Instructions:**
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Select your project: **persona-ai-b0d88**
3. Go to **APIs & Services** → **Credentials**
4. Create a new OAuth 2.0 Client ID:
   - Application type: **Web application**
   - Authorized JavaScript origins:
     - `http://localhost:7777` (for development)
     - `http://localhost:8080` (alternative)
     - `https://yourdomain.com` (for production)
   - Authorized redirect URIs:
     - `http://localhost:7777/` 
     - `https://yourdomain.com/`

5. Copy your **Client ID** (looks like: `xxxxx-xxxxxxxxxxxxxxxx.apps.googleusercontent.com`)

### Step 2: Update web/index.html

Add the Google Sign-In meta tag with your Client ID:

```html
<!-- Google Sign-In Meta Tag -->
<meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com">
```

**Full example:**
```html
<!DOCTYPE html>
<html>
<head>
  <base href="$FLUTTER_BASE_HREF">
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="AI Personas">

  <!-- Google Sign-In Meta Tag (IMPORTANT!) -->
  <meta name="google-signin-client_id" content="1158986913917-lkvs95vn5o8cq8nkjh8jq6o7k6j5i4h3.apps.googleusercontent.com">

  <!-- iOS meta tags -->
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">
  <link rel="icon" type="image/png" href="favicon.png"/>

  <title>AI Personas</title>
  <link rel="manifest" href="manifest.json">

  <!-- Firebase Web SDK -->
  <script type="module">
    import { auth, app, analytics } from './firebase-config.js';
    window.firebaseAuth = auth;
    window.firebaseApp = app;
    window.firebaseAnalytics = analytics;
    console.log('Firebase initialized successfully');
  </script>
</head>
<body>
  <script src="flutter_bootstrap.js" async></script>
</body>
</html>
```

### Step 3: Update lib/services/web_auth_service.dart

✅ **Already done!** The file now uses:
```dart
static Future<UserCredential?> signInWithGoogle() async {
  try {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    final UserCredential userCredential =
        await _firebaseAuth.signInWithPopup(googleProvider);
    return userCredential;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}
```

### Step 4: Enable Google Sign-In in Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select project: **persona-ai-b0d88**
3. Go to **Authentication** → **Sign-in methods**
4. Enable **Google** provider
5. Add your domain to **Authorized domains**:
   - `localhost` (for development)
   - `yourdomain.com` (for production)

## Complete Checklist

- [ ] Created OAuth Client ID in Google Cloud Console
- [ ] Added `<meta name="google-signin-client_id">` tag to `web/index.html`
- [ ] Google Sign-In enabled in Firebase Console
- [ ] Authorized domains added in Firebase Console
- [ ] Running on `localhost:7777` or approved domain

## Testing

### 1. Local Development
```bash
# Run on localhost with port 7777
flutter run -d chrome --web-renderer canvaskit --local-engine-src-path=.
```

Or use:
```bash
flutter run -d web
```

This typically runs on `http://localhost:58000` or similar.

### 2. Test Google Sign-In
1. Click "Continue with Google" button
2. Google OAuth popup should appear
3. Select Google account and authorize
4. Should redirect to `/chat` after success

### 3. Common Issues and Fixes

**Popup blocked?**
- Ensure the button click directly triggers `signInWithGoogle()`
- Not called inside `setTimeout` or delayed callbacks

**"Invalid client" error?**
- Check Client ID is correct in `index.html`
- Verify localhost port matches authorized origin in Google Cloud

**"Redirect URI mismatch" error?**
- Add exact redirect URI in Google Cloud Console
- If running on `localhost:7777`, add that exact URL

**"CORS error"?**
- This is normal with OAuth - the popup should handle it
- Ensure popup is not blocked by browser

## Advanced: Environment-Specific Configuration

For different environments, create separate configs:

**web/index.html (development - localhost)**
```html
<meta name="google-signin-client_id" content="xxxxx-dev.apps.googleusercontent.com">
```

**web/index.html (production - yourdomain.com)**
```html
<meta name="google-signin-client_id" content="xxxxx-prod.apps.googleusercontent.com">
```

## Alternative: Set Client ID Programmatically

If you want to avoid hardcoding, you can set it in code:

**Update lib/services/web_auth_service.dart:**
```dart
static void initialize({required String googleClientId}) {
  _googleSignIn = GoogleSignIn(
    clientId: googleClientId,
    scopes: ['email', 'profile'],
  );
}
```

**Call during app startup:**
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Set Google Client ID for web
  WebAuthService.initialize(
    googleClientId: 'YOUR_CLIENT_ID.apps.googleusercontent.com'
  );
  
  runApp(const WebApp());
}
```

## Expected Behavior After Fix

1. ✅ Click "Continue with Google"
2. ✅ Google OAuth popup appears
3. ✅ User selects account and authorizes
4. ✅ Popup closes
5. ✅ User redirected to `/chat` screen
6. ✅ User stays logged in after page refresh

## Security Notes

- Your Client ID is public - this is safe
- Real security comes from OAuth 2.0 consent flow
- Never expose your **Client Secret** (keep this private)
- Authorized domains ensure only your domain can use the Client ID

## Support

If you still get errors after following these steps:

1. Check browser console (F12) for detailed error messages
2. Verify Firebase project ID: `persona-ai-b0d88`
3. Ensure internet connection is working
4. Clear browser cache and try again
5. Try incognito/private browsing mode

## Reference Documentation

- [Google OAuth 2.0 Setup](https://developers.google.com/identity/protocols/oauth2/web-server)
- [Firebase Google Sign-In](https://firebase.google.com/docs/auth/web/google-signin)
- [Flutter Google Sign-In Plugin](https://pub.dev/packages/google_sign_in)
