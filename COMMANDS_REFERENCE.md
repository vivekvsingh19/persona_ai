# Pre-Setup Step-by-Step Command Reference

This document contains all the exact commands you need to run to complete the pre-setup phase.

## Phase 1: Firebase CLI Setup (5 minutes)

```powershell
# Step 1: Install Firebase Tools globally
npm install -g firebase-tools

# Step 2: Verify installation
firebase --version
# Expected output: Firebase CLI version X.X.X

# Step 3: Authenticate with Google
firebase login
# This will open a browser for Google authentication

# Step 4: Verify you're logged in
firebase projects:list
# Expected output: Lists "persona-ai-b0d88"

# Step 5: Set your current project
firebase use persona-ai-b0d88
# Or just use this command to verify current project:
firebase projects:list
```

## Phase 2: FlutterFire Setup (10 minutes)

```powershell
# Step 1: Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Step 2: Navigate to your Flutter project root
cd c:\Flutter_projects\ai_persona

# Step 3: Run FlutterFire configure
flutterfire configure --project=persona-ai-b0d88

# When prompted, select:
# Android: y
# iOS: y
# Web: y
# Windows: n (optional)
# macOS: n (optional)

# Step 4: Install Flutter dependencies
flutter pub get

# Step 5: Verify Firestore and Cloud Functions are added to pubspec.yaml
flutter pub list | findstr "cloud_firestore\|cloud_functions"
# Expected: Both packages should be listed
```

## Phase 3: Firebase Functions Setup (15 minutes)

```powershell
# Step 1: Navigate to project root
cd c:\Flutter_projects\ai_persona

# Step 2: Navigate to functions folder (already created)
cd functions

# Step 3: Install Node dependencies
npm install

# Step 4: Verify TypeScript compilation works
npm run build

# Step 5: Check that lib/ folder was created
Get-ChildItem -Path .\lib -Recurse
# Expected: lib/index.js should exist

# Step 6: Go back to project root
cd ..
```

## Phase 4: Gemini API Key Setup (5 minutes)

```powershell
# Step 1: Get your API key from https://ai.google.dev/gemini-api/docs
# Copy the API key (looks like: AIzaXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx)

# Step 2: Store it in Firebase Functions config
firebase functions:config:set gemini.api_key="YOUR_ACTUAL_API_KEY_HERE"
# Replace YOUR_ACTUAL_API_KEY_HERE with your real key from Step 1

# Step 3: Verify it was set correctly
firebase functions:config:get
# Expected output should show:
# {
#   "gemini": {
#     "api_key": "AIzaXxXxXxXxXxXxXxXxXxXxXxXxXxXxXxXx"
#   }
# }

# Step 4 (OPTIONAL): For local development, create .runtimeconfig.json in functions/
# Create file: functions/.runtimeconfig.json
# Add content:
# {
#   "gemini": {
#     "api_key": "YOUR_API_KEY_HERE"
#   }
# }
# ⚠️ IMPORTANT: Add to .gitignore - NEVER commit this file!
```

## Phase 5: Flutter Assets Setup (5 minutes)

```powershell
# Step 1: Create assets folder structure
cd c:\Flutter_projects\ai_persona

# Create main asset folders (if they don't exist)
mkdir -Force assets\avatars
mkdir -Force assets\icons
mkdir -Force assets\images

# Step 2: Add placeholder images
# For now, you can copy existing images or create placeholders:
# - Place persona avatars in: assets/avatars/
# - Place app icons in: assets/icons/
# - Place splash/background images in: assets/images/

# Recommended files to add:
# assets/avatars/
#   - genius_avatar.png
#   - therapist_avatar.png
#   - mentor_avatar.png
#   - comedian_avatar.png

# Step 3: Verify pubspec.yaml has assets section
# Should already be there, verify:
# flutter:
#   uses-material-design: true
#   assets:
#     - assets/icons/
#     - assets/images/
#     - assets/avatars/

# Step 4: Get Flutter again to register new assets
cd c:\Flutter_projects\ai_persona
flutter pub get
```

## Phase 6: Verification Commands (5 minutes)

```powershell
# ========== FIREBASE VERIFICATION ==========
Write-Host "=== Firebase Verification ===" -ForegroundColor Green

# Check Firebase CLI
firebase --version

# Check current project
firebase projects:list

# Check Cloud Functions status
firebase functions:list

# Check environment config
firebase functions:config:get

Write-Host ""
Write-Host "=== Flutter Verification ===" -ForegroundColor Green

# Check Flutter version
flutter --version

# Check pubspec.yaml dependencies
flutter pub list | findstr "firebase\|cloud_"

# Run analyzer
flutter analyze

# Get fresh dependencies
flutter pub get

Write-Host ""
Write-Host "=== Functions Project Verification ===" -ForegroundColor Green

# Check TypeScript compilation
cd c:\Flutter_projects\ai_persona\functions
npm run build
npm list

# Check that lib/ was created
if (Test-Path .\lib\index.js) {
    Write-Host "✅ lib/index.js compiled successfully" -ForegroundColor Green
} else {
    Write-Host "❌ lib/index.js not found - run npm run build" -ForegroundColor Red
}

cd ..

Write-Host ""
Write-Host "=== Assets Verification ===" -ForegroundColor Green

# Check assets folders
Get-ChildItem -Path .\assets -Recurse -Directory

Write-Host ""
Write-Host "✅ Pre-Setup Verification Complete!" -ForegroundColor Green
```

## Individual Command Summary

### Quick Reference - Copy & Paste Ready

```powershell
# Firebase CLI Setup
npm install -g firebase-tools
firebase login
firebase use persona-ai-b0d88

# FlutterFire Setup
dart pub global activate flutterfire_cli
cd c:\Flutter_projects\ai_persona
flutterfire configure --project=persona-ai-b0d88
flutter pub get

# Functions Setup
cd functions
npm install
npm run build
cd ..

# Gemini API Key Setup (replace YOUR_KEY)
firebase functions:config:set gemini.api_key="YOUR_GEMINI_API_KEY_HERE"
firebase functions:config:get

# Verify Everything
firebase --version
firebase projects:list
flutter --version
flutter analyze
cd functions && npm list && npm run build && cd ..
```

## Troubleshooting Commands

```powershell
# If Firebase Login Fails
firebase logout
firebase login

# If npm packages don't install
cd functions
Remove-Item -Path node_modules -Recurse -Force
npm cache clean --force
npm install

# If TypeScript won't compile
cd functions
npm install
npm run build
npm list typescript

# If Flutter pub get fails
flutter clean
flutter pub get

# If assets aren't loading
flutter pub get
flutter clean
flutter pub get

# Check all Firebase project details
firebase projects:get persona-ai-b0d88
firebase firestore:describe
firebase functions:list
```

## Estimated Time

| Phase | Time | Status |
|-------|------|--------|
| Firebase CLI Setup | 5 min | ✅ |
| FlutterFire Setup | 10 min | ✅ |
| Functions Setup | 15 min | ✅ |
| Gemini API Setup | 5 min | ✅ |
| Assets Setup | 5 min | ✅ |
| Verification | 5 min | ✅ |
| **TOTAL** | **45 min** | ✅ |

## What Gets Created

After running these commands:

```
your-project/
├── functions/
│   ├── node_modules/              ✅ Created by npm install
│   ├── lib/                        ✅ Created by npm run build
│   ├── src/
│   │   └── index.ts               ✅ Already provided
│   ├── package.json               ✅ Already provided
│   ├── tsconfig.json              ✅ Already provided
│   └── .runtimeconfig.json        ✅ Create manually for local dev
├── assets/
│   ├── avatars/                   ✅ Already exists
│   ├── icons/                     ✅ Already exists
│   └── images/                    ✅ Already exists
├── lib/
│   ├── firebase_options.dart      ✅ Already exists
│   └── main.dart                  ✅ Already exists
└── pubspec.yaml                   ✅ Already configured
```

## Next Steps After Pre-Setup

Once you've completed all these commands and they all succeed:

1. ✅ Your Firebase environment is fully configured
2. ✅ Your Flutter project has all dependencies
3. ✅ Your Cloud Functions are ready for implementation
4. ✅ Your Gemini API key is securely stored
5. ✅ Your assets are properly structured

**Then reply with:** "Pre-setup complete! Ready for backend implementation."

And I will generate the full backend code with Gemini integration, Firestore operations, and Flutter service layer.

