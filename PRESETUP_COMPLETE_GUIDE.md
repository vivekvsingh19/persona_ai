# 🚀 AI Persona Chat App - Complete Pre-Setup Guide

**Last Updated:** November 13, 2025  
**Status:** Pre-Backend Setup (Environment Preparation Only)

---

## 📋 Table of Contents

1. [Firebase CLI Setup](#1-firebase-cli-setup)
2. [FlutterFire Configuration](#2-flutterfire-configuration)
3. [Firebase Functions Folder Structure](#3-firebase-functions-folder-structure)
4. [Gemini API Configuration](#4-gemini-api-configuration)
5. [Flutter Assets Setup](#5-flutter-assets-setup)
6. [Chat UI Requirements Checklist](#6-chat-ui-requirements-checklist)
7. [Verification Steps](#7-verification-steps)

---

## 1. Firebase CLI Setup

### Step 1.1: Install Firebase Tools

```powershell
# Install Firebase CLI globally
npm install -g firebase-tools

# Verify installation
firebase --version
```

### Step 1.2: Login to Firebase

```powershell
# Authenticate with Google account
firebase login

# Verify login status
firebase projects:list
```

**Expected Output:**
```
Listed 1 project(s):

✔ persona-ai-b0d88
  - Name: persona-ai-b0d88
  - Project ID: persona-ai-b0d88
```

### Step 1.3: Initialize Firebase Project

You already have a Firebase project! Verify with:

```powershell
# List all your Firebase projects
firebase list

# Set the current project
firebase use persona-ai-b0d88
```

If you need to initialize fresh, the command would be:
```powershell
firebase init
```

**Select these options when prompted:**
- ✅ Firestore Database
- ✅ Cloud Functions
- ✅ TypeScript
- ✅ Do you want to install dependencies now? → Yes

---

## 2. FlutterFire Configuration

### Step 2.1: Current Dependencies Status

Your `pubspec.yaml` already has:
```yaml
firebase_core: ^3.1.0
firebase_auth: ^5.1.0
google_sign_in: ^6.2.0
```

### Step 2.2: Add Cloud Firestore & Functions Dependencies

Update your `pubspec.yaml` to include these dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase Core & Auth
  firebase_core: ^3.1.0
  firebase_auth: ^5.1.0
  google_sign_in: ^6.2.0
  
  # ✨ NEW: Firestore & Cloud Functions
  cloud_firestore: ^5.4.0
  cloud_functions: ^4.7.0
  
  # Modern icons from Iconsax
  iconsax: ^0.0.8
  cupertino_icons: ^1.0.8
  iconsax_flutter: ^1.0.1

  # Web UI dependencies
  google_fonts: ^6.3.2
  flutter_animate: ^4.2.0
  crypto: ^3.0.3
```

### Step 2.3: Install Dependencies

```powershell
# Get all Flutter dependencies
flutter pub get

# Verify Firebase packages
flutter pub list | findstr firebase
```

### Step 2.4: Run FlutterFire Configure

```powershell
# Install FlutterFire CLI (if not already installed)
dart pub global activate flutterfire_cli

# Run configure for your project
flutterfire configure --project=persona-ai-b0d88
```

**Select platforms when prompted:**
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows (optional)
- ✅ macOS (optional)

### Step 2.5: Verify Configuration Files

After running `flutterfire configure`, verify these files exist:

```
android/app/google-services.json    ✅ Already exists
ios/Runner/GoogleService-Info.plist ✅ Will be auto-generated
web/firebase-config.js              ✅ Already exists
lib/firebase_options.dart           ✅ Already exists
```

**Current google-services.json Status:**
```
Project ID: persona-ai-b0d88
Package Name: com.persona.app
Android App ID: 1:158986913917:android:4767920fdb143679070914
```

---

## 3. Firebase Functions Folder Structure

### Step 3.1: Create Functions Directory

```powershell
# Navigate to your project root
cd c:\Flutter_projects\ai_persona

# Create Firebase Functions folder
mkdir functions
cd functions
```

### Step 3.2: Initialize Firebase Functions Project

```powershell
# This should already be done if you ran firebase init
# If not, initialize it:
firebase init functions

# Select:
# - Language: TypeScript
# - ESLint: Yes (recommended)
# - Install dependencies: Yes
# - Node version: 20
```

### Step 3.3: Folder Structure

After initialization, your `functions/` folder should look like:

```
functions/
├── .eslintrc.js
├── .gitignore
├── package.json          (Configure here)
├── tsconfig.json         (TypeScript config)
├── src/
│   └── index.ts          (Main entry point)
└── lib/
    └── index.js          (Compiled output)
```

### Step 3.4: Update functions/package.json

Replace your `functions/package.json` with:

```json
{
  "name": "functions",
  "description": "Cloud Functions for AI Persona Chat App",
  "type": "module",
  "engines": {
    "node": "20"
  },
  "scripts": {
    "build": "tsc",
    "watch": "tsc --watch",
    "start": "npm run build && func start",
    "deploy": "firebase deploy --only functions",
    "logs": "firebase functions:log"
  },
  "main": "lib/index.js",
  "dependencies": {
    "firebase-admin": "^13.0.0",
    "firebase-functions": "^6.1.0",
    "@google-cloud/generative-ai": "^0.7.0",
    "cors": "^2.8.5"
  },
  "devDependencies": {
    "@types/cors": "^2.8.17",
    "@types/node": "^20.0.0",
    "typescript": "^5.0.0",
    "eslint": "^8.0.0",
    "@typescript-eslint/eslint-plugin": "^7.0.0",
    "@typescript-eslint/parser": "^7.0.0"
  }
}
```

### Step 3.5: Update functions/tsconfig.json

```json
{
  "compilerOptions": {
    "module": "esnext",
    "moduleResolution": "node",
    "noImplicitAny": true,
    "outDir": "./lib",
    "sourceMap": true,
    "strict": true,
    "target": "ES2020",
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "compileOnSave": true,
  "include": [
    "src"
  ]
}
```

### Step 3.6: Create functions/src/index.ts

Create a placeholder TypeScript Cloud Function:

```typescript
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as cors from "cors";

// Initialize Firebase Admin
admin.initializeApp();

// Initialize CORS
const corsHandler = cors({ origin: true });

/**
 * ============================================
 * PLACEHOLDER: Chat Message Processing
 * ============================================
 * This function will handle:
 * - Receiving user messages
 * - Calling Gemini API
 * - Storing responses in Firestore
 * - Returning AI-generated persona responses
 */
export const processChatMessage = functions
  .region("us-central1")
  .https.onRequest((req, res) => {
    corsHandler(req, res, () => {
      // Placeholder response
      res.json({
        status: "PLACEHOLDER",
        message: "Chat processing function ready for backend implementation",
      });
    });
  });

/**
 * ============================================
 * PLACEHOLDER: Persona Selection Handler
 * ============================================
 * This function will:
 * - Initialize persona in Firestore
 * - Set up user-persona relationship
 * - Prepare chat history
 */
export const selectPersona = functions
  .region("us-central1")
  .https.onRequest((req, res) => {
    corsHandler(req, res, () => {
      // Placeholder response
      res.json({
        status: "PLACEHOLDER",
        message: "Persona selection function ready for backend implementation",
      });
    });
  });

/**
 * ============================================
 * PLACEHOLDER: Get Chat History
 * ============================================
 * This function will:
 * - Fetch conversation history from Firestore
 * - Apply pagination
 * - Return formatted messages
 */
export const getChatHistory = functions
  .region("us-central1")
  .https.onRequest((req, res) => {
    corsHandler(req, res, () => {
      // Placeholder response
      res.json({
        status: "PLACEHOLDER",
        message: "Chat history function ready for backend implementation",
        messages: [],
      });
    });
  });

// ============================================
// ENVIRONMENT VARIABLES THAT WILL BE SET:
// ============================================
// process.env.GEMINI_API_KEY (set via firebase functions:config:set)
// process.env.FIREBASE_PROJECT_ID (automatic)
// process.env.FIREBASE_BUCKET (automatic)
```

### Step 3.7: Install Functions Dependencies

```powershell
cd functions
npm install

# Verify installation
npm list
```

Expected packages installed:
- ✅ firebase-admin
- ✅ firebase-functions
- ✅ @google-cloud/generative-ai
- ✅ cors
- ✅ TypeScript

---

## 4. Gemini API Configuration

### Step 4.1: Get Gemini API Key

1. Visit: **https://ai.google.dev/gemini-api/docs**
2. Click **"Get API Key"** button
3. Create a new API key or use existing one
4. Copy the API key (keep it secret!)

### Step 4.2: Store API Key in Firebase Functions Config

```powershell
# From your project root directory (NOT in functions/)
# Set the Gemini API Key in Firebase Functions environment

firebase functions:config:set gemini.api_key="YOUR_ACTUAL_API_KEY_HERE"

# Verify it was set
firebase functions:config:get
```

**Expected Output:**
```
✔  Code already present, skipping download
✔  Analyzed 68 files in c:\Flutter_projects\ai_persona
✔  Found 0 issues
✔  Writing new config
{
  "gemini": {
    "api_key": "AIzaXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx"
  }
}
```

### Step 4.3: Update functions/.runtimeconfig.json (Local Development)

Create `functions/.runtimeconfig.json` for local testing:

```json
{
  "gemini": {
    "api_key": "YOUR_GEMINI_API_KEY_HERE"
  }
}
```

⚠️ **Security Note:** Never commit this file to Git. Add to `.gitignore`.

### Step 4.4: How to Access in Cloud Functions

Once deployed, access the API key in your TypeScript code like this:

```typescript
// This will be shown in the NEXT backend implementation prompt
const config = functions.config();
const geminiApiKey = config.gemini.api_key;

// Then use it with the Gemini SDK:
// const genAI = new GoogleGenerativeAI(geminiApiKey);
```

---

## 5. Flutter Assets Setup

### Step 5.1: Persona Avatar Structure

Create this folder structure in your `assets/` directory:

```
assets/
├── avatars/
│   ├── genius_avatar.png           (1024×1024px, PNG)
│   ├── therapist_avatar.png        (1024×1024px, PNG)
│   ├── mentor_avatar.png           (1024×1024px, PNG)
│   ├── comedian_avatar.png         (1024×1024px, PNG)
│   └── .gitkeep
├── icons/
│   ├── send_icon.svg
│   ├── attach_icon.svg
│   └── settings_icon.svg
└── images/
    ├── splash_screen.png
    └── app_logo.png
```

### Step 5.2: Create Avatar Folders

```powershell
# Create persona avatar folders
cd c:\Flutter_projects\ai_persona\assets\avatars

# Verify structure
Get-ChildItem -Recurse
```

### Step 5.3: Update pubspec.yaml Assets Section

Your current assets section is good:

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/icons/
    - assets/images/
    - assets/avatars/        # ✨ Add this if not present
```

If avatars section is missing, update `pubspec.yaml`:

```powershell
flutter pub get
```

### Step 5.4: Recommended Image Specifications

| Asset Type | Resolution | Format | Size | Folder |
|---|---|---|---|---|
| Persona Avatar | 1024×1024px | PNG | <500KB | `assets/avatars/` |
| App Icon | 192×192px | PNG | <100KB | `assets/icons/` |
| Splash Screen | 1080×1920px | PNG | <1MB | `assets/images/` |
| Background | 1920×1080px | PNG | <2MB | `assets/images/` |

### Step 5.5: Asset Loading Example (For Reference)

```dart
// This is how the app will load persona images later:
Image.asset(
  'assets/avatars/genius_avatar.png',
  width: 128,
  height: 128,
  fit: BoxFit.cover,
)
```

---

## 6. Chat UI Requirements Checklist

Before implementing the backend, ensure your Flutter app has these UI components:

### 6.1: Required Screens

#### ✅ Login Screen (`lib/screens/login_screen.dart`)
- [ ] Google Sign-In button
- [ ] Firebase authentication integration
- [ ] Redirect to home screen after login
- [ ] Error message display for failed auth

#### ✅ Persona Selection Screen (To Create)
- [ ] List/Grid of available personas
- [ ] Persona name display
- [ ] Persona avatar image
- [ ] Description/bio for each persona
- [ ] "Select Persona" button
- [ ] Navigation to chat screen

#### ✅ Chat Screen (Main Feature)
- [ ] Message list widget (scrollable)
- [ ] User message bubble styling
- [ ] AI persona message bubble styling
- [ ] Different colors/styles for user vs AI
- [ ] Timestamp display
- [ ] Loading indicator while waiting for response
- [ ] Text input field
- [ ] Send button
- [ ] Clear chat button (optional)

#### ✅ Settings Screen
- [ ] User profile display
- [ ] Current persona info
- [ ] Logout button
- [ ] Clear chat history button

### 6.2: Required UI Widgets/Components

```dart
// You should have or create these widgets:

// 1. Message Bubble Widget
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;
  final DateTime timestamp;
  // ... styling based on isUserMessage
}

// 2. Chat Input Field
class ChatInputField extends StatefulWidget {
  final Function(String) onSend;
  // ... text input with send button
}

// 3. Persona Card Widget
class PersonaCard extends StatelessWidget {
  final String name;
  final String avatar;
  final String description;
  final VoidCallback onSelect;
}

// 4. Chat List Widget
class ChatListView extends StatelessWidget {
  final List<Message> messages;
  // ... scrollable list of messages
}
```

### 6.3: Data Models to Verify

Check these exist in `lib/models/`:

#### ✅ Message Model
```dart
class Message {
  final String id;
  final String userId;
  final String personaId;
  final String content;
  final bool isUserMessage;
  final DateTime timestamp;
  // Additional fields as needed
}
```

#### ✅ Persona Model  
Check your existing `lib/features/home/domain/persona.dart`:
```dart
class Persona {
  final String id;
  final String name;
  final String avatar;
  final String description;
  final String personality;
  // Additional fields as needed
}
```

### 6.4: Navigation Structure

Verify your app navigation includes:

```
MyApp
├── LoginScreen (Authentication)
│   └── Google Sign-In
├── HomeScreen / PersonaSelectionScreen
│   └── List of Personas
│       └── Select Persona
├── ChatScreen
│   ├── Messages
│   ├── Chat Input
│   └── Send Button
└── SettingsScreen
    ├── User Profile
    ├── Clear Chat
    └── Logout
```

---

## 7. Verification Steps

### Step 7.1: Verify Firebase Project Status

```powershell
# Check Firebase CLI is ready
firebase --version
# Expected: Firebase CLI version X.X.X

# Check current project
firebase projects:list
# Expected: persona-ai-b0d88 listed

# Check functions are ready
firebase functions:list
# Expected: Shows deployed functions (or empty if not deployed yet)

# Check Firestore is enabled
firebase firestore:describe --database=(default)
# Expected: Database info displayed
```

### Step 7.2: Verify Flutter Setup

```powershell
# Check Flutter version
flutter --version
# Expected: Flutter X.X.X | Dart X.X.X

# Check dependencies
flutter pub get
flutter pub list | findstr firebase
# Expected: firebase_core, firebase_auth, cloud_firestore, cloud_functions

# Verify no analyzer errors
flutter analyze
# Expected: No errors related to Firebase packages
```

### Step 7.3: Verify Functions Project

```powershell
# Navigate to functions
cd c:\Flutter_projects\ai_persona\functions

# Check TypeScript compilation
npm run build
# Expected: Compiles without errors, outputs to lib/

# Check dependencies
npm list
# Expected: All packages listed without errors
```

### Step 7.4: Verify Assets

```powershell
# Check assets folder structure
Get-ChildItem -Path c:\Flutter_projects\ai_persona\assets -Recurse

# Expected structure:
# assets/
# ├── avatars/
# ├── icons/
# └── images/
```

### Step 7.5: Final Verification Command

```powershell
# Run this comprehensive check
Write-Host "=== Firebase Setup Verification ===" -ForegroundColor Green
firebase --version
firebase projects:list
Write-Host "`n=== Flutter Setup Verification ===" -ForegroundColor Green
flutter --version
flutter pub list | findstr "firebase"
Write-Host "`n=== Functions Setup Verification ===" -ForegroundColor Green
cd functions
npm list | findstr "firebase\|generative"
cd ..
Write-Host "`n✅ Pre-Setup Verification Complete!" -ForegroundColor Green
```

---

## 📝 Pre-Setup Checklist

Before proceeding to backend implementation, verify:

- [ ] **Firebase CLI installed** (`firebase --version` works)
- [ ] **Logged into Firebase** (`firebase projects:list` shows your project)
- [ ] **FlutterFire configured** (`lib/firebase_options.dart` exists)
- [ ] **Cloud Firestore enabled** (in Firebase Console)
- [ ] **Cloud Functions folder created** (`functions/` exists with src/index.ts)
- [ ] **TypeScript configured** (`functions/tsconfig.json` exists)
- [ ] **Gemini API key obtained** (from ai.google.dev)
- [ ] **API key stored** (`firebase functions:config:get` shows gemini.api_key)
- [ ] **Flutter dependencies updated** (pubspec.yaml has cloud_firestore, cloud_functions)
- [ ] **Assets folder structure created** (`assets/avatars/`, `assets/icons/`, etc.)
- [ ] **Chat UI components ready** (MessageBubble, ChatInputField, Message model)
- [ ] **All verification commands pass** (firebase, flutter, npm commands work)

---

## 🎯 Next Steps

Once you've completed this pre-setup guide:

1. ✅ All environment variables are configured
2. ✅ All folder structures are created
3. ✅ All dependencies are installed
4. ✅ All Firebase services are enabled
5. ✅ All Flutter UI components are ready

**Then:** Provide the next prompt with `@next-backend-implementation` and I will generate:
- Complete Gemini API integration functions
- Firestore database schema and operations
- Cloud Functions implementation
- Flutter service layer for backend communication
- Error handling and logging

---

## 🔒 Security Notes

- **Never commit** `.runtimeconfig.json` with API keys
- **Never expose** API keys in client code
- **Always use** Firebase Security Rules for Firestore
- **Always validate** user input on the backend
- **Always use** CORS properly for your domains
- Keep `.gitignore` updated:

```
functions/.runtimeconfig.json
functions/node_modules/
functions/lib/
.env
.env.local
```

---

## 📞 Troubleshooting

### Firebase CLI Issues
```powershell
# Re-login if authentication fails
firebase logout
firebase login

# Clear cache if having issues
Remove-Item -Path "$env:APPDATA\.firebase" -Recurse -Force
firebase login
```

### Flutter/Pub Issues
```powershell
# Clean and reinstall
flutter clean
flutter pub get

# Verify no conflicts
flutter pub list
```

### Functions Deployment Issues
```powershell
# Check function logs
firebase functions:log

# Re-deploy if needed
cd functions
npm run build
cd ..
firebase deploy --only functions
```

---

**You are now ready for the AI Persona Chat App backend implementation! 🎉**

