# 🎯 AI Persona Chat App - Pre-Setup Completion Checklist

**Project:** AI Persona Chat App with Flutter + Firebase + Gemini API  
**Status:** Pre-Setup Phase (Environment Configuration)  
**Target Completion:** Before Backend Implementation  

---

## ✅ Section 1: Firebase CLI & Project Setup

- [ ] **Firebase CLI Installed**
  - Command: `firebase --version`
  - Expected: Shows version number (e.g., 13.5.0)
  - Link: https://firebase.google.com/docs/cli

- [ ] **Firebase Account Linked**
  - Command: `firebase login` completed
  - Command: `firebase projects:list` shows your project
  - Expected: `persona-ai-b0d88` in the list

- [ ] **Project Set as Default**
  - Command: `firebase use persona-ai-b0d88`
  - Verify: `firebase projects:list` shows check mark

- [ ] **Firestore Database Enabled**
  - Location: Firebase Console > persona-ai-b0d88 > Firestore
  - Status: Database should be created and ready
  - Region: Any region (recommended: us-central1)

- [ ] **Cloud Functions Enabled**
  - Location: Firebase Console > persona-ai-b0d88 > Functions
  - Status: Ready for deployment

---

## ✅ Section 2: FlutterFire Setup

- [ ] **FlutterFire CLI Installed**
  - Command: `dart pub global activate flutterfire_cli`
  - Verify: Should complete without errors

- [ ] **FlutterFire Configure Completed**
  - Command: `flutterfire configure --project=persona-ai-b0d88`
  - File Generated: `lib/firebase_options.dart`
  - Status: ✅ Should exist in your project

- [ ] **Firebase Packages in pubspec.yaml**
  - ✅ firebase_core: ^3.1.0
  - ✅ firebase_auth: ^5.1.0
  - ✅ google_sign_in: ^6.2.0
  - ✅ cloud_firestore: ^5.4.0 (added)
  - ✅ cloud_functions: ^4.7.0 (added)
  - Command: `flutter pub get`

- [ ] **Platform Configurations Generated**
  - ✅ Android: `android/app/google-services.json`
  - ✅ iOS: `ios/Runner/GoogleService-Info.plist`
  - ✅ Web: `web/firebase-config.js`

- [ ] **Flutter Dependencies Resolved**
  - Command: `flutter pub get`
  - Command: `flutter analyze` - No Firebase-related errors
  - Expected: All packages resolved successfully

---

## ✅ Section 3: Firebase Functions Project Setup

- [ ] **Functions Folder Structure Created**
  ```
  functions/
  ├── src/
  │   └── index.ts              ✅
  ├── package.json              ✅
  ├── tsconfig.json             ✅
  ├── node_modules/             (created by npm install)
  └── lib/                       (created by npm run build)
  ```

- [ ] **package.json Configured**
  - ✅ Node version: 20
  - ✅ Dependencies: firebase-admin, firebase-functions, @google-cloud/generative-ai, cors
  - ✅ Scripts: build, watch, deploy, logs
  - Verify: `npm list` shows all packages

- [ ] **tsconfig.json Configured**
  - ✅ Target: ES2020
  - ✅ Module: esnext
  - ✅ Output: lib/ folder
  - ✅ Strict mode: enabled

- [ ] **Placeholder Functions Created**
  - ✅ processChatMessage()
  - ✅ selectPersona()
  - ✅ getChatHistory()
  - ✅ clearChatHistory()
  - ✅ streamChatResponse()
  - ✅ testConfig()

- [ ] **Node Packages Installed**
  - Command: `cd functions && npm install`
  - Expected: node_modules folder created
  - Verify: `npm list` shows all dependencies

- [ ] **TypeScript Compiles**
  - Command: `cd functions && npm run build`
  - Expected: No errors, lib/index.js created
  - Verify: `lib/index.js` file exists

---

## ✅ Section 4: Gemini API Configuration

- [ ] **Gemini API Key Obtained**
  - Source: https://ai.google.dev/gemini-api/docs
  - Action: Create/copy your API key
  - Format: Starts with "AIza..."

- [ ] **API Key Stored in Firebase Config**
  - Command: `firebase functions:config:set gemini.api_key="YOUR_KEY"`
  - Verify: `firebase functions:config:get`
  - Expected: Shows gemini.api_key in output
  - ⚠️ KEEP KEY SECURE - Never commit to Git

- [ ] **Local Development Config (Optional)**
  - File: `functions/.runtimeconfig.json`
  - Contains: `{ "gemini": { "api_key": "YOUR_KEY" } }`
  - ⚠️ REQUIRED: Add to `.gitignore`
  - Command: `echo "functions/.runtimeconfig.json" >> .gitignore`

- [ ] **Gemini API Quotas Verified**
  - Location: Google Cloud Console
  - Check: Free tier quotas are sufficient for testing
  - Note: Monitor usage once deployed

---

## ✅ Section 5: Flutter Assets & Resources

- [ ] **Avatar Folder Structure Created**
  ```
  assets/avatars/
  ├── genius_avatar.png         (1024×1024px)
  ├── therapist_avatar.png      (1024×1024px)
  ├── mentor_avatar.png         (1024×1024px)
  └── comedian_avatar.png       (1024×1024px)
  ```

- [ ] **Asset Paths in pubspec.yaml**
  - ✅ assets/icons/
  - ✅ assets/images/
  - ✅ assets/avatars/ (added)
  - Command: `flutter pub get`

- [ ] **Image Files Prepared**
  - [ ] Genius avatar (can be placeholder for now)
  - [ ] Therapist avatar (can be placeholder for now)
  - [ ] Mentor avatar (can be placeholder for now)
  - [ ] Comedian avatar (can be placeholder for now)
  - Note: Can use any 1024×1024px PNG images

- [ ] **App Icons & Splash**
  - ✅ Icon assets in `assets/icons/`
  - ✅ Image assets in `assets/images/`
  - Recommendation: Use FlutterLauncher for production icons

---

## ✅ Section 6: Data Models & UI Components

- [ ] **Message Model Created/Updated**
  - File: `lib/models/message.dart` (or existing)
  - Fields: id, userId, personaId, conversationId, content, isUserMessage, timestamp, status
  - Methods: toFirestore(), fromFirestore(), copyWith()
  - Template: See `lib/models/message_template.dart`

- [ ] **Persona Model Created/Updated**
  - File: `lib/models/persona.dart` (or existing)
  - Fields: id, name, avatar, description, personality, systemPrompt, traits, expertise
  - Templates: PersonaTemplates class with predefined personas
  - Template: See `lib/models/persona_template.dart`

- [ ] **Conversation Model Created**
  - Fields: conversationId, personaId, userId, startedAt, lastMessageAt, messageCount
  - (Will be fully implemented in backend phase)

- [ ] **UI Components Template Reviewed**
  - ✅ MessageBubble widget
  - ✅ ChatInputField widget
  - ✅ PersonaCard widget
  - ✅ ChatListView widget
  - ✅ LoadingIndicator widget
  - ✅ EmptyStateWidget widget
  - File: `lib/widgets/ui_components.dart`
  - Note: These are templates ready to be used

---

## ✅ Section 7: Chat Screen UI Implementation

- [ ] **Login Screen Verified**
  - File: `lib/screens/login_screen.dart`
  - Features:
    - [ ] Google Sign-In button
    - [ ] Firebase Auth integration
    - [ ] Redirect to home on success
    - [ ] Error handling

- [ ] **Persona Selection Screen Exists**
  - Features:
    - [ ] Display all available personas
    - [ ] Show persona name, avatar, description
    - [ ] "Select Persona" button for each
    - [ ] Navigate to chat screen on selection

- [ ] **Chat Screen Exists**
  - Features:
    - [ ] Message list (MessageBubble widgets)
    - [ ] Chat input field (ChatInputField widget)
    - [ ] Send button
    - [ ] Loading indicator while waiting for response
    - [ ] Timestamp display on messages
    - [ ] Different styling for user vs AI messages

- [ ] **Settings Screen Exists**
  - Features:
    - [ ] User profile info
    - [ ] Current persona display
    - [ ] Logout button
    - [ ] Clear chat history button (optional)

- [ ] **Navigation Structure**
  - [ ] LoginScreen → HomeScreen/PersonaSelectionScreen
  - [ ] PersonaSelectionScreen → ChatScreen
  - [ ] ChatScreen → SettingsScreen (nav drawer/menu)
  - [ ] SettingsScreen → LoginScreen (on logout)

---

## ✅ Section 8: Documentation & Reference

- [ ] **PRESETUP_COMPLETE_GUIDE.md Created**
  - ✅ File exists with full setup instructions
  - ✅ Contains all commands
  - ✅ Contains all configuration details
  - ✅ Contains verification steps

- [ ] **COMMANDS_REFERENCE.md Created**
  - ✅ Step-by-step command reference
  - ✅ Quick copy-paste commands
  - ✅ Troubleshooting section
  - ✅ Time estimates included

- [ ] **FIRESTORE_SCHEMA.md Created**
  - ✅ Database collection structure
  - ✅ Document field definitions
  - ✅ Security rules
  - ✅ Indexing strategy
  - ✅ Data flow examples

- [ ] **README.md in functions/ Exists**
  - ✅ Quick start guide
  - ✅ Project structure explanation
  - ✅ Build and deploy instructions

---

## ✅ Section 9: Security & Configuration

- [ ] **Firebase Security Rules Plan**
  - ✅ Users can only access their own data
  - ✅ Personas are public readable
  - ✅ Messages linked to user ownership
  - File: Ready to deploy (see FIRESTORE_SCHEMA.md)

- [ ] **API Keys Secured**
  - ✅ Gemini API key in Firebase config (not in code)
  - ✅ .runtimeconfig.json in .gitignore
  - ✅ No API keys in source code
  - ✅ No API keys in git history

- [ ] **.gitignore Updated**
  - ✅ functions/.runtimeconfig.json
  - ✅ functions/node_modules/
  - ✅ functions/lib/
  - ✅ .env (if using)

- [ ] **Environment Variables Plan**
  - ✅ GEMINI_API_KEY (set via Firebase)
  - ✅ FIREBASE_PROJECT_ID (automatic)
  - ✅ FIREBASE_DATABASE_URL (automatic)
  - ✅ How to access documented in index.ts

---

## ✅ Section 10: Verification Commands (Run These)

### 10.1: Firebase CLI
```powershell
firebase --version                    # Should show version
firebase projects:list                # Should show persona-ai-b0d88
firebase functions:list               # Should work (empty or with functions)
firebase functions:config:get         # Should show gemini.api_key
```

### 10.2: Flutter
```powershell
flutter --version                     # Should show version
flutter pub get                       # Should complete without errors
flutter analyze                       # Should show no Firebase errors
flutter pub list | findstr firebase   # Should show all packages
```

### 10.3: Functions
```powershell
cd functions
npm list                              # Should show all dependencies
npm run build                         # Should compile without errors
ls lib/index.js                       # Should exist
cd ..
```

### 10.4: Assets
```powershell
Get-ChildItem -Path assets -Recurse   # Should show avatars folder
```

---

## 📋 Pre-Setup Completion Certificate

When ALL items above are checked:

```
✅ Firebase CLI Setup Complete
✅ FlutterFire Configuration Complete
✅ Cloud Functions Structure Ready
✅ Gemini API Configuration Complete
✅ Flutter Assets Setup Complete
✅ Data Models Prepared
✅ UI Components Ready
✅ Chat UI Structure Ready
✅ Security Configuration Planned
✅ Documentation Complete
✅ All Verification Commands Pass

🎉 ENVIRONMENT FULLY PREPARED FOR BACKEND IMPLEMENTATION
```

---

## 🚀 Next Steps

Once all items are checked:

1. **Response to Me:**
   - Reply: "Pre-setup complete! Ready for backend implementation."
   - Include: Screenshot of `firebase functions:config:get` output

2. **I Will Generate:**
   - Complete backend implementation code
   - Gemini API integration functions
   - Firestore operations
   - Flutter service layer
   - Real-time message handling
   - Error handling & logging
   - Complete working chat system

3. **You Will Implement:**
   - Deploy backend to Firebase
   - Deploy functions to Firebase
   - Test all endpoints
   - Run the app with full backend

---

## 📞 Troubleshooting Reference

| Issue | Solution | Reference |
|-------|----------|-----------|
| Firebase CLI not found | `npm install -g firebase-tools` | Section 1 |
| FlutterFire config fails | Run `flutterfire configure --project=persona-ai-b0d88` | Section 2 |
| TypeScript compilation fails | Run `npm install` in functions/ | Section 3 |
| Gemini key not set | Use exact command: `firebase functions:config:set gemini.api_key="KEY"` | Section 4 |
| Assets not loading | Verify pubspec.yaml has `assets/avatars/` | Section 5 |
| Analyze shows errors | Run `flutter clean && flutter pub get` | Section 10 |

---

## 📊 Pre-Setup Metrics

| Component | Status | Files | Size |
|-----------|--------|-------|------|
| Documentation | ✅ Complete | 5 files | ~100KB |
| Firebase Config | ✅ Ready | 3 files | Auto |
| Functions Project | ✅ Ready | 4 files | ~50KB |
| Flutter Models | ✅ Ready | 2 files | ~20KB |
| UI Components | ✅ Ready | 1 file | ~25KB |
| Assets | ✅ Ready | 4 files | Variable |

**Total Pre-Setup:** Estimated 45 minutes to complete all tasks

---

**This checklist is your guide to full pre-setup completion. Check off each item as you complete it. Once all are complete, you're ready for the full backend implementation!**
