# Firebase Functions Configuration

This folder contains Cloud Functions for the AI Persona Chat App.

## Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Set Environment Variables
```bash
# From project root (NOT in this directory)
firebase functions:config:set gemini.api_key="YOUR_API_KEY_HERE"

# Verify
firebase functions:config:get
```

### 3. Local Development
```bash
npm run build
npm run watch
```

### 4. Deploy to Firebase
```bash
npm run deploy
```

## Project Structure

- `src/index.ts` - Main entry point with all Cloud Functions
- `tsconfig.json` - TypeScript configuration
- `package.json` - Dependencies and build scripts
- `lib/` - Compiled JavaScript output (auto-generated)

## Functions Ready for Backend Implementation

1. **processChatMessage** - Handle user messages and Gemini responses
2. **selectPersona** - Initialize new persona conversation
3. **getChatHistory** - Fetch conversation history with pagination
4. **clearChatHistory** - Delete all messages in a conversation
5. **streamChatResponse** - Stream Gemini responses (optional enhancement)
6. **testConfig** - Test environment configuration

## Build Scripts

- `npm run build` - Compile TypeScript to JavaScript
- `npm run watch` - Watch mode for development
- `npm run deploy` - Deploy to Firebase Cloud Functions
- `npm run logs` - View function execution logs
- `npm run lint` - Run ESLint

## Important Notes

- All API keys are managed via `firebase functions:config:set`
- Never commit `.runtimeconfig.json` with actual keys
- Functions run in Node.js 20 environment
- Region: us-central1 (can be changed in function definitions)

## Next Phase

All placeholder functions are ready to be implemented with:
- Firestore operations
- Gemini API integration
- Real-time message streaming
- Error handling and validation

